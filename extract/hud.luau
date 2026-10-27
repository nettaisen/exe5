--!strict
-- The HUD's graphics: what EXE5's HUD tasks copy to VRAM, by the counterparts of the EXE6 routines EXE6's recipe reads
-- them by (the verification workspace's tools/exe5 pairs them). EXE5's HUD is EXE6's but for where its blocks load
-- (its HUD layer's tiles from 0x180, EXE6's 0x1A0; the gauge from 0x202, EXE6's 0x222) and its emotion window: a face
-- brings its box (pictures 0-4 and 11-15), or shows a count beside it (the souls', 5-10), and the faces' palettes run
-- on past the pictures for Chaos Unison's (exe5-map.md §11).
--
-- Each block is stated by where the game's own pointer to it is in each of the four ROMs (a place; the addresses in
-- the comments are the US Team ProtoMan ROM's blocks'). What the four have alike and the English words are read from
-- the Team ProtoMan US ROM, a team's own faces from its version's US ROM. EXE5's code drops each color's bit 15
-- everywhere (`palette`).

local place = require("@exelib/extract/place")
local colors = require("@exelib/extract/colors")
local banners = require("@exelib/extract/banners")
local texts = require("@exelib/extract/texts")
local chatbox = require("@exelib/extract/chatbox")

local at = place.at
local pointer_in_each = place.pointer_in_each

local hud = {}

-- The battle's HUD load list (EXE6 `off_801ECB4`, at 0x0801B54C): the HUD layer's tiles to tile 0x180 (the HP box,
-- HP and damage digits, '+', "????"; 0x086F76B0), then the 8x16 font's '×' and '2' (tiles 0x1B2, 0x1B4).
local HUD_TILES = pointer_in_each({ 0x0801_B558, 0x0801_B554, 0x0801_B524, 0x0801_B520 })
local HUD_FIRST_TILE = 0x180
local TIMES_GLYPH = pointer_in_each({ 0x0801_B570, 0x0801_B56C, 0x0801_B53C, 0x0801_B538 })
local TWO_GLYPH = pointer_in_each({ 0x0801_B57C, 0x0801_B578, 0x0801_B548, 0x0801_B544 })
-- The gauge's tiles (EXE6 `sub_801DED0`'s counterpart, 0x0801A7F4: to tile 0x202; 0x086FA2CC), the same in the four
-- ROMs.
hud.GAUGE_TILES = pointer_in_each({ 0x0801_A86C, 0x0801_A864, 0x0801_A838, 0x0801_A830 })
hud.GAUGE_BYTES = 0x380
local GAUGE_FIRST_TILE = 0x202
-- Background palettes 9 (the gauge) and 13 (the HP box: + 0x20 per color state; 0x086F7CF0).
local HUD_PALETTES = pointer_in_each({ 0x0801_A7EC, 0x0801_A7E4, 0x0801_A7B8, 0x0801_A7B0 })
-- The HP box (6x2) and gauge frame (18x2) maps (EXE6 `sub_801E03E`'s and `sub_801DDF6`'s counterparts).
local HP_BOX = pointer_in_each({ 0x0801_A968, 0x0801_A960, 0x0801_A934, 0x0801_A92C })
local GAUGE_FRAME = pointer_in_each({ 0x0801_A7E4, 0x0801_A7DC, 0x0801_A7B0, 0x0801_A7A8 })
-- The 8x16 font (glyph k = 0x40 bytes; EXE6 `dword_86B7AE0`; 0x086CBA68), drawn with the HP box's first palette.
hud.FONT = pointer_in_each({ 0x0801_9C58, 0x0801_9C50, 0x0801_9C2C, 0x0801_9C24 })
hud.FONT_GLYPHS = 0xE0
-- The opponent's HP digits by color (EXE6 `off_801D854`'s tables, at 0x0801A1A4) and their sprite palette (the load
-- list's first).
local ENEMY_DIGITS = {
    pointer_in_each({ 0x0801_A1A4, 0x0801_A19C, 0x0801_A178, 0x0801_A170 }),
    pointer_in_each({ 0x0801_A1D0, 0x0801_A1C8, 0x0801_A1A4, 0x0801_A19C }),
    pointer_in_each({ 0x0801_A1FC, 0x0801_A1F4, 0x0801_A1D0, 0x0801_A1C8 }),
}
local ENEMY_PALETTE = pointer_in_each({ 0x0801_B54C, 0x0801_B548, 0x0801_B518, 0x0801_B514 })
-- The chip icons' palette (sprite palette 4: the HUD's load list's to 0x03003690) and the hidden chip's icon.
local ICON_PALETTE = pointer_in_each({ 0x0801_B5B8, 0x0801_B5B4, 0x0801_B584, 0x0801_B580 })
local HIDDEN_ICON = pointer_in_each({ 0x0801_8C6C, 0x0801_8C64, 0x0801_8C40, 0x0801_8C38 })
-- The emotion window's faces (0x0801968E's literals): pictures 0-4 at FACES and 11-15 at FACES_DARK (which is where an
-- eleventh before them would be: picture n at + 0x180 n), 0x180 bytes each (the 32x16 face, then its 16x16 box); 5-10
-- (the version's souls) at SOUL_FACES, 0x100 bytes each, beside the count box showing 10 - n at COUNTS + 0x80 n. The
-- palettes: picture n's at FACE_PALETTES + 0x20 n; a soul's in Chaos Unison n + 11 (+ 0x160).
--
-- Pictures 0-4 and the counts are the same in the four ROMs. The souls' are each version's own six, with their
-- palettes. Pictures 11-15 are the same and four of their palettes differ by version in two or three colors: the pack
-- has Team ProtoMan's.
local FACES = pointer_in_each({ 0x0801_97F0, 0x0801_97E8, 0x0801_97C4, 0x0801_97BC })
local SOUL_FACES = pointer_in_each({ 0x0801_97F8, 0x0801_97F0, 0x0801_97CC, 0x0801_97C4 })
local FACES_DARK = pointer_in_each({ 0x0801_97F4, 0x0801_97EC, 0x0801_97C8, 0x0801_97C0 })
local COUNTS = pointer_in_each({ 0x0801_985C, 0x0801_9854, 0x0801_9830, 0x0801_9828 })
local FACE_PALETTES = pointer_in_each({ 0x0801_9808, 0x0801_9800, 0x0801_97DC, 0x0801_97D4 })
local DARK_PALETTES = 11
-- The team navis' faces (EXE6 `sub_801CC34`'s counterpart, 0x08019724: navi n's at + 0x100 (n - 1), its version's six;
-- Team Colonel's routine reads its own six, navi n's at + 0x100 (n - 7)), the box beside them (the same in both
-- versions) and their two palettes each, normal and Full Synchro.
local NAVI_MUGSHOTS = pointer_in_each({ 0x0801_9864, 0x0801_985C, 0x0801_9838, 0x0801_9830 })
local NAVI_MUGSHOT_COUNT = 6
local NAVI_BOX = pointer_in_each({ 0x0801_986C, 0x0801_9864, 0x0801_9840, 0x0801_9838 })
local NAVI_MUGSHOT_PALETTES = pointer_in_each({ 0x0801_9868, 0x0801_9860, 0x0801_983C, 0x0801_9834 })
-- The dialogue font (16x12 glyphs of 0x60 bytes, up to the HUD font; 0x086C14C8) and its advances: a word a glyph in
-- EXE5 (a byte in EXE6; 0x080426B4).
local DIALOGUE_FONT = pointer_in_each({ 0x0803_AA48, 0x0803_AA4C, 0x0803_A9C4, 0x0803_A9C8 })
local DIALOGUE_ADVANCES = pointer_in_each({ 0x0803_EBD4, 0x0803_EBD8, 0x0803_EAB8, 0x0803_EABC })
-- The dialogue font's glyphs: it runs up to the 8x16 font (0xA5A0 bytes in every ROM).
local DIALOGUE_GLYPHS = 0xA5A0 // 0x60
-- "PAUSE" (EXE6 `off_801E188`'s): a 32x16 sprite's eight tiles and an 8x16 one's two.
local PAUSE = pointer_in_each({ 0x0801_AA54, 0x0801_AA4C, 0x0801_AA20, 0x0801_AA18 })
-- The HUD's text lines (EXE6 `TextScript86F0374`, at the counterparts' 0x0873ACF0).
local TEXTS = pointer_in_each({ 0x0801_9C4C, 0x0801_9C44, 0x0801_9C20, 0x0801_9C18 })
local TEXT_END = 0xE6
-- The banners (EXE6 `pt_801EF84`: 49 records to EXE6's 47, the same layout: a head word, then 20 glyph pointers that
-- repeat the filler once it shows up, then a kind-1 banner's number place), their glyph filler (EXE6 `byte_801FDC0`),
-- the banner font's digits (ten glyphs from here; EXE6 `dword_86F1DC0`, by `off_801FD64`'s counterpart at 0x0801C698)
-- and the banners' palette (EXE6 `byte_86F2900`).
local BANNERS = pointer_in_each({ 0x0801_B1C4, 0x0801_B1C0, 0x0801_B190, 0x0801_B18C })
hud.BANNER_COUNT = 49
local BANNER_FILLER = pointer_in_each({ 0x0801_B1F4, 0x0801_B1F0, 0x0801_B1C0, 0x0801_B1BC })
local BANNER_DIGITS = pointer_in_each({ 0x0801_C698, 0x0801_C694, 0x0801_C654, 0x0801_C650 })
hud.BANNER_PALETTE = pointer_in_each({ 0x0801_B1D4, 0x0801_B1D0, 0x0801_B1A0, 0x0801_B19C })
-- "Cstmzing..." (8x2 tiles), the first of the three transfers before the banners (EXE6 `off_801EF30`'s one, 0x200
-- bytes with the banners' palette); the other two (0x240 and 0x2C0 bytes) are EXE5's own. The Japanese ROMs' is seven
-- tiles wide. (The other two are what the screen says in a Team Battle between its rounds and while a side changes its
-- order: "Interval...", "Strat Change...". A netbattle shows neither, and the pack has neither.)
hud.WAITING = pointer_in_each({ 0x0801_B7BC, 0x0801_B7B8, 0x0801_B788, 0x0801_B784 })
-- The warning marker's two 16x16 frames and its palette (EXE6's `dword_86E55FC` and `byte_86E56FC`, the same data:
-- the palette is the first of the emblems').
local WARNING = pointer_in_each({ 0x0802_5D94, 0x0802_5D98, 0x0802_5D50, 0x0802_5D54 })
local WARNING_PALETTE = pointer_in_each({ 0x0802_3FBC, 0x0802_3FC0, 0x0802_3F78, 0x0802_3F7C })
-- The chatbox (`chatbox_runScript`'s counterpart, 0x0803EF18): the box's twenty tiles (to BG0's tile 0x2EB, which its
-- maps count from) and palette, the text's palette; the box's maps (eight pointers a kind, the opening steps 0-3
-- first, 30x8 entries each); the key-wait arrow's three 16x16 frames.
local CHATBOX: ChatboxPlaces = {
    tiles = pointer_in_each({ 0x0803_F000, 0x0803_F004, 0x0803_EEE4, 0x0803_EEE8 }),
    tile_count = 20,
    first_tile = 0x2EB,
    palette = pointer_in_each({ 0x0803_F00C, 0x0803_F010, 0x0803_EEF0, 0x0803_EEF4 }),
    text_palette = pointer_in_each({ 0x0803_F014, 0x0803_F018, 0x0803_EEF8, 0x0803_EEFC }),
    boxes = pointer_in_each({ 0x0803_EF00, 0x0803_EF04, 0x0803_EDE4, 0x0803_EDE8 }),
    kinds = 2,
    arrow = pointer_in_each({ 0x0803_F424, 0x0803_F428, 0x0803_F308, 0x0803_F30C }),
    masked = true,
}

-- A palette (the hardware ignores bit 15 of a color; chip 0's palette has it set, which an image can't hold).
function hud.palette(rom: Rom, a: number): Palette
    return colors.masked(gba.palette(rom, a))
end

-- Entry `k` (from 0) of a list of characters, else its number in brackets.
local function char(list: { string }, k: number): string
    return list[k + 1] or string.format("[%03x]", k)
end

-- An encoding's characters: the 8x16 font's glyphs, then the dialogue font's past them.
local function chained(cell: { string }, dialogue: { string }): { string }
    local out = table.clone(cell)
    for _, c in dialogue do
        table.insert(out, c)
    end
    return out
end

-- The HUD's text lines in `rom` (a line with anything but glyphs in it, a text command, is cut there).
function hud.texts(rom: Rom): { { number } }
    return texts.lines(rom, at(rom, TEXTS), TEXT_END, hud.FONT_GLYPHS)
end

-- Banner `id` of `rom`, in its release's words.
function hud.banner(rom: Rom, id: number): BannerLayout
    return banners.at(rom, at(rom, BANNERS), at(rom, BANNER_FILLER), id)
end

-- `rom`'s dialogue font with its advances (a word a glyph), its glyphs drawing `cell` (the 8x16 font's characters),
-- then `dialogue` (the dialogue font's past them; a glyph past them its number in brackets).
function hud.dialogue_font(rom: Rom, cell: { string }, dialogue: { string }): DialogueFont
    local all = chained(cell, dialogue)
    local chars: { string } = {}
    for k = 0, DIALOGUE_GLYPHS - 1 do
        table.insert(chars, char(all, k))
    end
    return font.dialogue(rom, at(rom, DIALOGUE_FONT), at(rom, DIALOGUE_ADVANCES), DIALOGUE_GLYPHS, 4, chars)
end

-- The 8x16 font's characters, of a list of characters (a glyph past them its number in brackets).
function hud.font_chars(list: { string }): { string }
    local out: { string } = {}
    for k = 0, hud.FONT_GLYPHS - 1 do
        table.insert(out, char(list, k))
    end
    return out
end

-- An emotion-window face of `rom` (4x2 tiles) and the box it brings (2x2; none for a soul's, which shows a count).
local function face(rom: Rom, picture: number): (Tiles, Tiles)
    local boxed = picture < 5 or picture >= 11
    local a
    if picture < 5 then
        a = at(rom, FACES) + 0x180 * picture
    elseif picture < 11 then
        a = at(rom, SOUL_FACES) + 0x100 * (picture - 5)
    else
        a = at(rom, FACES_DARK) + 0x180 * picture
    end
    local tiles = gba.tiles(rom, a, 0x100)
    local box = if boxed then gba.tiles(rom, a + 0x100, 0x80) else gba.join({})
    return tiles, box
end

-- The emotion window's faces, as compat/assets.toml numbers them (its [mugshots]): the face table's sixteen pictures
-- in their own palettes, the version's souls (5-10) in Chaos Unison's (+11), then Team Colonel's own souls likewise.
-- Each with the box it brings (`mugshot_boxes`). The table's sixteen are the Team ProtoMan US ROM's.
local function mugshots(set: Set, h: Hud)
    local faces: { { any } } = {}
    local boxes: { Tiles } = {}
    local function push(rom: Rom, picture: number, palette_index: number)
        local tiles, box = face(rom, picture)
        local palette = hud.palette(rom, at(rom, FACE_PALETTES) + 0x20 * palette_index)
        local entry: { any } = { tiles, palette }
        table.insert(faces, entry)
        table.insert(boxes, box)
    end
    local protoman, colonel = set.BRBE, set.BRKE
    for picture = 0, 15 do
        push(protoman, picture, picture)
    end
    for picture = 5, 10 do
        push(protoman, picture, picture + DARK_PALETTES)
    end
    for picture = 5, 10 do
        push(colonel, picture, picture)
    end
    for picture = 5, 10 do
        push(colonel, picture, picture + DARK_PALETTES)
    end
    h.mugshots = faces
    h.mugshot_boxes = boxes
end

-- A team's six navis' faces, from its version's US ROM.
local function navi_mugshots(rom: Rom, out: { { tiles: Tiles, palettes: { Palette } } })
    for n = 0, NAVI_MUGSHOT_COUNT - 1 do
        local tiles = gba.tiles(rom, at(rom, NAVI_MUGSHOTS) + 0x100 * n, 0x100)
        local palettes: { Palette } = {}
        for k = 0, 1 do
            table.insert(palettes, hud.palette(rom, at(rom, NAVI_MUGSHOT_PALETTES) + 0x40 * n + 0x20 * k))
        end
        table.insert(out, { tiles = tiles, palettes = palettes })
    end
end

-- `h` with what the four ROMs have alike, read from `rom`.
local function drawn(rom: Rom, h: Hud)
    h.tiles = gba.join({
        gba.tiles(rom, at(rom, HUD_TILES), 0x640),
        gba.tiles(rom, at(rom, TIMES_GLYPH), 0x40),
        gba.tiles(rom, at(rom, TWO_GLYPH), 0x40),
    })
    -- The banner digits, and the filler as glyph 10 (blank).
    local digits = gba.tiles(rom, at(rom, BANNER_DIGITS), 0x40 * 10)
    local blank = gba.tiles(rom, at(rom, BANNER_FILLER), 0x40)
    -- "PAUSE" as five glyphs: the first four are the 32x16 sprite's columns (its tiles go row by row), the fifth the
    -- 8x16 sprite.
    local pause = gba.tiles(rom, at(rom, PAUSE), 0x140):pick({ 0, 4, 1, 5, 2, 6, 3, 7, 8, 9 })
    h.first_tile = HUD_FIRST_TILE
    h.gauge_tiles = gba.tiles(rom, at(rom, hud.GAUGE_TILES), hud.GAUGE_BYTES)
    h.gauge_first_tile = GAUGE_FIRST_TILE
    local hp_palettes: { Palette } = {}
    for i = 0, 2 do
        table.insert(hp_palettes, hud.palette(rom, at(rom, HUD_PALETTES) + 0x20 * i))
    end
    h.hp_palettes = hp_palettes
    h.gauge_palette = hud.palette(rom, at(rom, HUD_PALETTES))
    h.hp_box = gba.map(rom, at(rom, HP_BOX), 12)
    h.gauge_frame = gba.map(rom, at(rom, GAUGE_FRAME), 36)
    local enemy_digits: { Tiles } = {}
    for _, p in ENEMY_DIGITS do
        table.insert(enemy_digits, gba.tiles(rom, at(rom, p), 0x40 * 10))
    end
    h.enemy_digits = enemy_digits
    h.enemy_palette = hud.palette(rom, at(rom, ENEMY_PALETTE))
    h.hidden_icon = gba.tiles(rom, at(rom, HIDDEN_ICON), 0x80)
    h.icon_palette = hud.palette(rom, at(rom, ICON_PALETTE))
    -- The soul faces' count boxes: 0..=10. (EXE5 has no box without a count, `count_box`: its faces bring their own.)
    local counts: { Tiles } = {}
    for n = 0, 10 do
        table.insert(counts, gba.tiles(rom, at(rom, COUNTS) + 0x80 * (10 - n), 0x80))
    end
    h.counts = counts
    h.navi_box = gba.tiles(rom, at(rom, NAVI_BOX), 0x80)
    h.pause = pause
    h.banner_digits = gba.join({ digits, blank })
    h.warning = gba.tiles(rom, at(rom, WARNING), 0x100)
    h.warning_palette = hud.palette(rom, at(rom, WARNING_PALETTE))
    h.chatbox = chatbox.of(rom, CHATBOX)
end

-- `h` with the words of `rom`'s release (a US ROM's: the pack's own language is English, and the Japanese ROMs' words
-- are lettering.luau's).
local function worded(rom: Rom, names: AssetNames, h: Hud)
    local cell, dialogue = names.glyphs or {}, names.dialogue_glyphs or {}
    h.font = gba.tiles(rom, at(rom, hud.FONT), 0x40 * hud.FONT_GLYPHS)
    -- (What glyph k draws: the content's name for it, EXE5's text encoding, else its number in brackets.)
    h.font_chars = hud.font_chars(chained(cell, dialogue))
    h.texts = hud.texts(rom)
    local list: { BannerLayout } = {}
    for id = 0, hud.BANNER_COUNT - 1 do
        table.insert(list, hud.banner(rom, id))
    end
    h.banners = list
    h.banner_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE))
    h.waiting = gba.tiles(rom, at(rom, hud.WAITING), 0x200)
    h.waiting_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE))
    h.dialogue_font = hud.dialogue_font(rom, cell, dialogue)
end

-- The HUD's graphics; `chip_icons` the chips' (chips.luau), `names` the fonts' characters. What the four ROMs have
-- alike is the Team ProtoMan US ROM's (`drawn`), the English words the same ROM's (`worded`), a team's own faces its
-- version's US ROM's.
function hud.hud(set: Set, names: AssetNames, chip_icons: { { key: string, tiles: Tiles? } }): Hud
    local h: Hud = {}
    mugshots(set, h)
    -- The team navis' by navi number: Team ProtoMan's six, then Team Colonel's.
    local navis: { { tiles: Tiles, palettes: { Palette } } } = {}
    navi_mugshots(set.BRBE, navis)
    navi_mugshots(set.BRKE, navis)
    h.navi_mugshots = navis
    h.chip_icons = chip_icons
    drawn(set.BRBE, h)
    worded(set.BRBE, names, h)
    return h
end

return hud
