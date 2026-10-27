--!strict
-- The custom screen's graphics. EXE5's screen is EXE6's shared screen (`sub_8026A28`'s counterpart): the same window
-- map and patch list (EXE5's special button, the soul button under OK, is 3x2 where EXE6's Beast Out button is 4x2),
-- the same slots and picked column, with its own frame (0x44 tiles to EXE6's 0x87, so every block after it loads
-- lower: `LAYOUT`), its own pictures and EXE5's element icons (13 to EXE6's 11). It has no Cross window and no Beast
-- Out: its buttons are the soul button under OK and, over slots 8 and 9, Shuffle's re-deal and Arm Change.
--
-- Read where the counterparts of the EXE6 routines EXE6's recipe reads load them (the HUD's load list at 0x0801B54C,
-- the window's opening, the chip window's 0x080242FA and 0x080244F8 on, the emblems' 0x08023F68): each block by where
-- the game's own pointer to it is in each of the four ROMs (a place). The window and its parts are the same in the
-- four, and the pack has the Team ProtoMan US ROM's; the chip window's worded pictures and the soul button's label are
-- each release's own (the US ROM's here, the Japanese ROM's in lettering.luau); a team's emblems its version's.

local place = require("@exelib/extract/place")
local colors = require("@exelib/extract/colors")
local patches = require("@exelib/extract/patches")
local buttons = require("@exelib/extract/buttons")
local hud = require("./hud")
local versions = require("./versions")

local at = place.at
local pointer_in_each = place.pointer_in_each
local band, rshift = bit32.band, bit32.rshift

local custom = {}

-- A block: its place and its length in bytes.
type Block = { place: Place, len: number }

-- The window frame's tiles, loaded at tile 1 (0x44 tiles), the picked column's cells (at 0x47), the late turns' block
-- (0x4B) and the enemy names' bar (0x1B6): the HUD's load list.
local WINDOW_TILES: Block = { place = pointer_in_each({ 0x0801_B588, 0x0801_B584, 0x0801_B554, 0x0801_B550 }), len = 0x880 }
local COLUMN_CELLS: Block = { place = pointer_in_each({ 0x0801_B594, 0x0801_B590, 0x0801_B560, 0x0801_B55C }), len = 0x80 }
local TURN_LIMIT: Block = { place = pointer_in_each({ 0x0801_B5D0, 0x0801_B5CC, 0x0801_B59C, 0x0801_B598 }), len = 0x1C0 }
local NAME_BAR: Block = { place = pointer_in_each({ 0x0801_B5E8, 0x0801_B5E4, 0x0801_B5B4, 0x0801_B5B0 }), len = 0x80 }
-- The window's 15x20 map (one: EXE5 has no Cross tab) and its patch list, from tile 0x59.
local WINDOW_MAP = pointer_in_each({ 0x0802_2D48, 0x0802_2D44, 0x0802_2D04, 0x0802_2D00 })
local WINDOW_PATCHES = pointer_in_each({ 0x0802_2D50, 0x0802_2D4C, 0x0802_2D0C, 0x0802_2D08 })
local WINDOW_PATCHES_FIRST_TILE = 0x59
local MAP_CELLS = 15 * 20

-- The cursor's corners over OK and over the soul button (`sub_80288D0`'s and `sub_8028904`'s counterparts' tables: four
-- words a frame, y in the low half, x and the flips (0x1000 h, 0x2000 v) in the high).
local OK_CORNERS = pointer_in_each({ 0x0802_4710, 0x0802_4714, 0x0802_46CC, 0x0802_46D0 })
local SOUL_CORNERS = pointer_in_each({ 0x0802_4740, 0x0802_4744, 0x0802_46FC, 0x0802_4700 })

-- A number's low byte, signed.
local function signed8(n: number): number
    local b = band(n, 0xFF)
    return if b >= 0x80 then b - 0x100 else b
end

-- A cursor's corners from a table of them: two frames of four, each { y, x, hflip, vflip }.
local function cursor_corners(rom: Rom, a: number): { { { any } } }
    local frames: { { { any } } } = {}
    for f = 0, 1 do
        local four: { { any } } = {}
        for k = 0, 3 do
            local w = rom:u32(a + 16 * f + 4 * k)
            local hi = rshift(w, 16)
            local corner: { any } = { signed8(w), signed8(hi), band(hi, 0x1000) ~= 0, band(hi, 0x2000) ~= 0 }
            table.insert(four, corner)
        end
        table.insert(frames, four)
    end
    return frames
end

-- Where the blocks load (EXE6's, all lower by the frame's 0x42 tiles, the column's icons by 0x44: the special button is
-- two tiles narrower); the hidden slots' fill (0x08025D44: solid 2, EXE6's solid 1); the cursor over OK (0x08024704: at
-- (0x58, 0x70), EXE6's (0x5B, 0x6E)), its corners read from `OK_CORNERS`.
local function layout(rom: Rom): CustomLayout
    return {
        column_cells = 0x47,
        turn_limit = 0x4B,
        -- (0x08025970's map: palette 9.)
        turn_limit_palette = 9,
        name = 0x59,
        art = 0x69,
        code = 0x93,
        element = 0x95,
        digits = 0x99,
        slots = 0x9F,
        column_icons = 0xE1,
        name_bar = 0x1B6,
        form_names = 0,
        slot_blank = 2,
        detail_blank = 8,
        ok_cursor = buttons.cursor(0x58, 0x70, cursor_corners(rom, at(rom, OK_CORNERS))),
        regular = { 2, 100 },
        column_columns = { 11, 14 },
        column_row = 3,
        form_names_at = { 1, 1 },
    }
end

-- The cursor over a button two slots wide in the slots' row (Shuffle's and Arm Change's, over slots 8 and 9: EXE6's
-- `sub_8028820`'s counterpart).
local ROW_BUTTON_CURSOR = buttons.cursor(0x38, 0x80, {
    { { 2, 2, false, false }, { 2, 0x1C, true, false }, { 0x14, 0x1C, true, true }, { 0x14, 2, false, true } },
    { { 4, 4, false, false }, { 4, 0x1A, true, false }, { 0x12, 0x1A, true, true }, { 0x12, 4, false, true } },
})

-- Background palette 9 by the chip window's class (standard, mega, giga, dark), and palettes 11, 12 and 14 (the HUD's
-- load list).
local FRAME_PALETTES = pointer_in_each({ 0x0802_464C, 0x0802_4650, 0x0802_4608, 0x0802_460C })
local FRAME_PALETTE_COUNT = 4
local ICON_PALETTE = pointer_in_each({ 0x0801_B5A0, 0x0801_B59C, 0x0801_B56C, 0x0801_B568 })
local GRAY_PALETTE = pointer_in_each({ 0x0801_B5AC, 0x0801_B5A8, 0x0801_B578, 0x0801_B574 })
local OTHER_PALETTE = pointer_in_each({ 0x0801_B5C4, 0x0801_B5C0, 0x0801_B590, 0x0801_B58C })
-- The chip window's other pictures and their palettes (EXE6 `sub_80286D4`'s OK, `sub_8028754`'s, `sub_80287A4`'s and
-- `sub_802877C`'s counterparts: 0x080244F8, 0x08024578, 0x080245C8, 0x080245A0). OK's, the other's and the re-deal
-- button's have words, each release's own; Arm Change's (the scrap button's place) has none and is the same in the
-- four ROMs.
type Details = { gfx: Place, palette: Place }
custom.OK = {
    gfx = pointer_in_each({ 0x0802_452C, 0x0802_4530, 0x0802_44E8, 0x0802_44EC }),
    palette = pointer_in_each({ 0x0802_4538, 0x0802_453C, 0x0802_44F4, 0x0802_44F8 }),
} :: Details
custom.OK_PICKED = {
    gfx = pointer_in_each({ 0x0802_4530, 0x0802_4534, 0x0802_44EC, 0x0802_44F0 }),
    palette = pointer_in_each({ 0x0802_453C, 0x0802_4540, 0x0802_44F8, 0x0802_44FC }),
} :: Details
custom.OTHER = {
    gfx = pointer_in_each({ 0x0802_4598, 0x0802_459C, 0x0802_4554, 0x0802_4558 }),
    palette = pointer_in_each({ 0x0802_459C, 0x0802_45A0, 0x0802_4558, 0x0802_455C }),
} :: Details
custom.REDEAL = {
    gfx = pointer_in_each({ 0x0802_4620, 0x0802_4624, 0x0802_45DC, 0x0802_45E0 }),
    palette = pointer_in_each({ 0x0802_462C, 0x0802_4630, 0x0802_45E8, 0x0802_45EC }),
} :: Details
custom.SCRAP = {
    gfx = pointer_in_each({ 0x0802_45C0, 0x0802_45C4, 0x0802_457C, 0x0802_4580 }),
    palette = pointer_in_each({ 0x0802_45C4, 0x0802_45C8, 0x0802_4580, 0x0802_4584 }),
} :: Details
local PICTURE_BYTES = 0x540
-- Chip codes (8x16), element icons (2x2) and the six colors each brings, damage digits (0-9, '?'): `sub_80284E2`'s
-- counterpart.
local CODES = pointer_in_each({ 0x0802_4464, 0x0802_4468, 0x0802_4420, 0x0802_4424 })
local CODE_GLYPHS = 28
local ELEMENTS = pointer_in_each({ 0x0802_446C, 0x0802_4470, 0x0802_4428, 0x0802_442C })
local ELEMENT_COLORS = pointer_in_each({ 0x0802_44A4, 0x0802_44A8, 0x0802_4460, 0x0802_4464 })
-- The icons and colors are by the chip record's family byte (+6), EXE5's order (its first 13 are icons; past them the
-- routine reads on into what follows, as the pack does); the pack has them by the engine's family numbers
-- (`ChipFamily`, EXE6's order with EXE5's recovery and invisible after it): for each, EXE5's family byte.
local FAMILY_BYTES = {
    0, -- fire
    1, -- aqua
    2, -- elec
    3, -- wood
    5, -- plus
    6, -- sword
    8, -- cursor
    9, -- summon (EXE5's obstacles)
    10, -- wind
    11, -- break
    12, -- null
    13, -- program advance
    14, -- special
    4, -- recovery
    7, -- invisible
}
local DIGITS = pointer_in_each({ 0x0802_4474, 0x0802_4478, 0x0802_4430, 0x0802_4434 })
local DIGIT_GLYPHS = 11
-- The slots' codes (16x8), the empty slot's icon.
local SLOT_CODES = pointer_in_each({ 0x0802_405C, 0x0802_4060, 0x0802_4018, 0x0802_401C })
local SLOT_CODE_GLYPHS = 28
local EMPTY_ICON = pointer_in_each({ 0x0802_3FEC, 0x0802_3FF0, 0x0802_3FA8, 0x0802_3FAC })
-- The re-deal and scrap buttons over slots 8 and 9 (EXE6 `sub_80282D2`'s and `sub_8028340`'s counterparts: 12 tiles a
-- state; the shared screen's, which a netbattle doesn't offer).
local REDEAL_BUTTONS: Block = { place = pointer_in_each({ 0x0802_4178, 0x0802_417C, 0x0802_4134, 0x0802_4138 }), len = 0x480 }
local SCRAP_BUTTONS: Block = { place = pointer_in_each({ 0x0802_417C, 0x0802_4180, 0x0802_4138, 0x0802_413C }), len = 0x600 }
-- The soul button (slot 11, EXE6's Beast Out's place): its tiles, 3x2 a state (selectable, unavailable, pressed; the
-- HUD's load list's to tile 0xDB), and its picture in the chip window with a palette a state (EXE6 `sub_802871C`'s
-- counterpart, 0x08024540: by the slot's state). The tiles have the button's label, each release's own ("UNITE" in the
-- US ROMs).
custom.SOUL_BUTTONS = { place = pointer_in_each({ 0x0802_41BC, 0x0802_41C0, 0x0802_4178, 0x0802_417C }), len = 0x240 } :: Block
-- The names EXE5's rules give their buttons (Soul Unison's `soul`, SearchSoul's Shuffle as `redeal`, ColonelSoul's
-- `arm_change`: content/exe5/rules/souls and the souls' own folders), which the pack has their looks by.
custom.SOUL_BUTTON = "soul"
custom.REDEAL_BUTTON = "redeal"
custom.ARM_CHANGE_BUTTON = "arm_change"
-- Arm Change's chip over its button (0x08025508: the sprite's x 0x45, y 0x84).
local ARM_CHANGE_HELD_AT = { 0x45, 0x84 }
local SOUL_PICTURE = pointer_in_each({ 0x0802_4570, 0x0802_4574, 0x0802_452C, 0x0802_4530 })
local SOUL_PALETTES = pointer_in_each({ 0x0802_4574, 0x0802_4578, 0x0802_4530, 0x0802_4534 })
local SOUL_PALETTE_COUNT = 2
-- The cursor over the soul button (0x08024734: at (0x58, 0x88)), its corners read from `SOUL_CORNERS`.
local SOUL_CURSOR_AT = { 0x58, 0x88 }
-- The souls' icons in the picked column, by soul number (13: Chaos Unison's; the column's 0x08024010 from 0x0802341C),
-- which the soul choice (state 9, 0x0802330C) first flies as a sprite in this palette (sprite palette 13).
local SOUL_ICONS: Block = { place = pointer_in_each({ 0x0802_402C, 0x0802_4030, 0x0802_3FE8, 0x0802_3FEC }), len = 14 * 0x80 }
-- (A version's own: Team Colonel's ROMs' has another color 9, the icons' outline.)
local SOUL_ICON_PALETTE = pointer_in_each({ 0x0802_3354, 0x0802_3350, 0x0802_3310, 0x0802_330C })
-- Sprites: the cursor's corner (two frames), the Regular chip's frame.
local CURSOR: Block = { place = pointer_in_each({ 0x0802_5D88, 0x0802_5D8C, 0x0802_5D44, 0x0802_5D48 }), len = 0x40 }
local REGULAR: Block = { place = pointer_in_each({ 0x0802_47D0, 0x0802_47D4, 0x0802_478C, 0x0802_4790 }), len = 0x400 }
-- The emblems (0x08023F68, EXE6 `sub_802812C`'s counterpart): a ROM's seven pictures (four tiles each: MegaMan's, then
-- its own team's six navis'), the eight palettes, and which palette each of the thirteen navis shows (Team ProtoMan
-- US's 0x08023FC4). MegaMan's picture, the palettes and the table are the same in the four ROMs.
local EMBLEMS = pointer_in_each({ 0x0802_3FB8, 0x0802_3FBC, 0x0802_3F74, 0x0802_3F78 })
local EMBLEM_PALETTES = pointer_in_each({ 0x0802_3FBC, 0x0802_3FC0, 0x0802_3F78, 0x0802_3F7C })
local EMBLEM_PALETTE_OF = pointer_in_each({ 0x0802_3FC0, 0x0802_3FC4, 0x0802_3F7C, 0x0802_3F80 })
-- The navis that operate (NaviStats +0x29): MegaMan (0), Team ProtoMan's six (1 to 6) and Team Colonel's (7 to 12).
local NAVI_COUNT = 13
local TEAM_NAVIS = 6
-- The Program Advance animation's names' colors (EXE6 `byte_802BA48`'s counterpart: three sets of four).
local ADVANCE_NAME_COLORS = pointer_in_each({ 0x0802_7D90, 0x0802_7D94, 0x0802_7D4C, 0x0802_7D50 })
local ADVANCE_NAME_SETS = 3

-- A block's tiles in `rom`.
function custom.tiles(rom: Rom, b: Block): Tiles
    return gba.tiles(rom, at(rom, b.place), b.len)
end

-- The first `n` palettes of a block in `rom`.
local function palettes(rom: Rom, p: Place, n: number): { Palette }
    local out: { Palette } = {}
    for i = 0, n - 1 do
        local palette: Palette = hud.palette(rom, at(rom, p) + 32 * i)
        table.insert(out, palette)
    end
    return out
end

-- A picture of the chip window in `rom`, with its palette.
function custom.picture(rom: Rom, d: Details): Picture
    local tiles = gba.tiles(rom, at(rom, d.gfx), PICTURE_BYTES)
    return { tiles = tiles, palette = hud.palette(rom, at(rom, d.palette)) }
end

-- The navis' emblems: navi n's picture is its ROM's nth (Team Colonel's routine takes 6 off a team navi's number,
-- 0x08023F9C: a ROM has MegaMan's and its own team's six) and its palette the one the table gives n, the same table and
-- palettes in every ROM. The pack has each navi's own, from its team's US ROM, under the navi's key (`names`): a navi
-- the content doesn't have yet has none.
local function emblems(set: Set, names: AssetNames): { Emblem }
    local keys = names.navis or {}
    local out: { Emblem } = {}
    for n = 0, NAVI_COUNT - 1 do
        local rom, picture
        if n == 0 then
            rom, picture = set.BRBE, 0
        elseif n <= TEAM_NAVIS then
            rom, picture = set.BRBE, n
        else
            rom, picture = set.BRKE, n - TEAM_NAVIS
        end
        local color = rom:u8(at(rom, EMBLEM_PALETTE_OF) + n)
        local navi = keys[n]
        if navi ~= nil then
            local emblem: Emblem = {
                navi = navi,
                tiles = gba.tiles(rom, at(rom, EMBLEMS) + 0x80 * picture, 0x80),
                palette = hud.palette(rom, at(rom, EMBLEM_PALETTES) + 32 * color),
            }
            table.insert(out, emblem)
        end
    end
    return out
end

-- A button two slots wide in the slots' row (twelve tiles a state, the two slots' icons and codes), with its picture in
-- the chip window.
local function row_button(rom: Rom, b: Block, details: Details): ButtonPictures
    local picture = custom.picture(rom, details)
    return buttons.row(custom.tiles(rom, b), picture, ROW_BUTTON_CURSOR)
end

-- The soul button, from the Team ProtoMan US ROM: its states' tiles have its label (the US release's words), its
-- picture and its souls' icons are the same in every ROM, and the icons' palette is each version's own (the pack's is
-- Team ProtoMan's, with Team Colonel's beside it where it is another).
local function soul_button(set: Set): ButtonPictures
    local rom = set.BRBE
    local function icon_palette(r: Rom): Palette
        return hud.palette(r, at(r, SOUL_ICON_PALETTE))
    end
    local own = icon_palette(rom)
    local button: ButtonPictures = {
        width = 3,
        height = 2,
        tiles = custom.tiles(rom, custom.SOUL_BUTTONS),
        -- (0x08024540: gray when unavailable or picked.)
        sets = "other",
        cursor = buttons.cursor(SOUL_CURSOR_AT[1], SOUL_CURSOR_AT[2], cursor_corners(rom, at(rom, SOUL_CORNERS))),
        picture = custom.picture(rom, { gfx = SOUL_PICTURE, palette = SOUL_PALETTES }),
        palettes = palettes(rom, SOUL_PALETTES, SOUL_PALETTE_COUNT),
        icons = custom.tiles(rom, SOUL_ICONS),
        icon_palette = own,
    }
    local colonel = icon_palette(set.BRKE)
    for i, c in own do
        if colonel[i] ~= c then
            button.icon_palettes = { { name = versions.COLONEL, value = colonel } }
            break
        end
    end
    return button
end

-- A window label: its name, its tiles, its letters' rows and colors. BATTLE CHIP on the window's top frame (tiles 2 to
-- 10, color 3 on 6), CHIP SELECT over the slots (0x27 to 0x2D, 4 on 2).
local LABELS: { WindowLabel } = {
    { name = "battle-chip", first = 0x02, last = 0x0A, top = 1, bottom = 5, letters = { 3 } },
    { name = "chip-select", first = 0x27, last = 0x2D, top = 3, bottom = 6, letters = { 4 } },
}

-- `c` with what the four ROMs have alike, read from `rom`.
local function drawn(rom: Rom, c: CustomScreen)
    local function glyphs(p: Place, n: number): Tiles
        return gba.tiles(rom, at(rom, p), 0x40 * n)
    end
    c.layout = layout(rom)
    c.labels = LABELS
    c.window_tiles = custom.tiles(rom, WINDOW_TILES)
    c.column_cells = custom.tiles(rom, COLUMN_CELLS)
    c.turn_limit = custom.tiles(rom, TURN_LIMIT)
    c.name_bar = custom.tiles(rom, NAME_BAR)
    c.window_maps = { gba.map(rom, at(rom, WINDOW_MAP), MAP_CELLS) }
    c.window_patches = patches.list(rom, at(rom, WINDOW_PATCHES), WINDOW_PATCHES_FIRST_TILE)
    c.frame_palettes = palettes(rom, FRAME_PALETTES, FRAME_PALETTE_COUNT)
    c.icon_palette = hud.palette(rom, at(rom, ICON_PALETTE))
    c.gray_palette = hud.palette(rom, at(rom, GRAY_PALETTE))
    c.other_palette = hud.palette(rom, at(rom, OTHER_PALETTE))
    c.codes = glyphs(CODES, CODE_GLYPHS)
    local elements: { Tiles } = {}
    local element_colors: { { number } } = {}
    for _, b in FAMILY_BYTES do
        table.insert(elements, gba.tiles(rom, at(rom, ELEMENTS) + 0x80 * b, 0x80))
    end
    for _, b in FAMILY_BYTES do
        local six: { number } = {}
        for i = 0, 5 do
            local color: number = colors.color(rom:u16(at(rom, ELEMENT_COLORS) + 12 * b + 2 * i))
            table.insert(six, color)
        end
        table.insert(element_colors, six)
    end
    c.elements = gba.join(elements)
    c.element_colors = element_colors
    c.digits = glyphs(DIGITS, DIGIT_GLYPHS)
    c.slot_codes = glyphs(SLOT_CODES, SLOT_CODE_GLYPHS)
    c.empty_icon = gba.tiles(rom, at(rom, EMPTY_ICON), 0x80)
    c.cursor = custom.tiles(rom, CURSOR)
    c.regular = custom.tiles(rom, REGULAR)
    local advance_name_colors: { { number } } = {}
    for i = 0, ADVANCE_NAME_SETS - 1 do
        local four: { number } = {}
        for k = 0, 3 do
            local color: number = colors.color(rom:u16(at(rom, ADVANCE_NAME_COLORS) + 8 * i + 2 * k))
            table.insert(four, color)
        end
        table.insert(advance_name_colors, four)
    end
    c.advance_name_colors = advance_name_colors
end

-- The custom screen's graphics; `names` gives the navis' emblems their navis' keys, `chip_art` is the chips' pictures
-- (chips.luau). The window and its parts are the Team ProtoMan US ROM's (`drawn`), the worded pictures the same ROM's.
function custom.custom(set: Set, names: AssetNames, chip_art: { ChipArt }): CustomScreen
    local rom = set.BRBE
    -- SearchSoul's Shuffle (EXE6's re-deal button's counterpart, 0x080245C8: its uses left in the chip window,
    -- 0x080245F2) and ColonelSoul's Arm Change (0x0802415A and 0x080245A0, in EXE6's scrap button's place: picked, it
    -- looks on offer, the chip it holds drawn over it; its picture has no words).
    local redeal = row_button(rom, REDEAL_BUTTONS, custom.REDEAL)
    redeal.uses_digit = true
    local arm_change = row_button(rom, SCRAP_BUTTONS, custom.SCRAP)
    arm_change.sets = "unavailable"
    arm_change.held_at = ARM_CHANGE_HELD_AT
    local soul = soul_button(set)
    local ok = custom.picture(rom, custom.OK)
    local ok_picked = custom.picture(rom, custom.OK_PICKED)
    local other = custom.picture(rom, custom.OTHER)
    local c: CustomScreen = {
        buttons = {
            { name = custom.SOUL_BUTTON, value = soul },
            { name = custom.REDEAL_BUTTON, value = redeal },
            { name = custom.ARM_CHANGE_BUTTON, value = arm_change },
        },
        -- (No version shows anything of its own here: the base's name is the game's base version's.)
        versioned = { base_version = versions.PROTOMAN, base = {} },
        chip_art = chip_art,
        pictures = { ok = ok, ok_picked = ok_picked, other = other },
        emblems = emblems(set, names),
    }
    drawn(rom, c)
    return c
end

return custom
