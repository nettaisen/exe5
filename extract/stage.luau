--!strict
-- The field and the backgrounds, from the Team ProtoMan US ROM. The routines that load them are EXE6's, the same or
-- nearly (the verification workspace's tools/exe5 maps them); each block is stated by where the game's own pointer to
-- it is in each ROM, mostly at an address of its own in each, as the two versions' code parts early.

local place = require("@exelib/extract/place")
local field = require("@exelib/extract/field")
local backgrounds = require("@exelib/extract/backgrounds")
local scroll = require("@exelib/extract/scroll")
local names = require("@exelib/extract/names")

local pointer, pointer_in_each = place.pointer, place.pointer_in_each
local at = place.at

local stage = {}

-- The field tiles (`sub_80075CA`'s, decompressed to VRAM 0x06001460; Team ProtoMan US's 0x086F3BA0) and the
-- background palettes 1..=8 its transfer list copies (0x086F6970).
local FIELD_TILES = pointer(0x0800_6A34, 0x0800_6A34)
local FIELD_PALETTES = pointer(0x0800_6A08, 0x0800_6A08)
-- Panel blocks: 32 bytes (5x3 map entries) per 6 * type + 3 * owner + row - 1 (`sub_800C01C`'s table, 0x086F5CB0).
-- EXE5 has 11 panel types (EXE6 13).
local PANEL_BLOCKS = pointer_in_each({ 0x0800_A658, 0x0800_A650, 0x0800_A66C, 0x0800_A664 })
local PANEL_TYPES = 11
-- The highlighted panel block (`sub_800C0BA`'s, 0x086F64F0): EXE5 has one, which it draws for both highlights (EXE6 a
-- table of two); the pack has it as both, what EXE5 draws for each.
local HIGHLIGHT_BLOCK = pointer_in_each({ 0x0800_A6C8, 0x0800_A6C0, 0x0800_A6DC, 0x0800_A6D4 })
-- The front edges by owner (`sub_800C100`'s, 0x086F6510).
local FRONT_EDGES = pointer_in_each({ 0x0800_A73C, 0x0800_A734, 0x0800_A750, 0x0800_A748 })
-- The panel palette animations `sub_800C192`'s counterpart runs (0x0800A7AC).
local PANEL_PALETTE_ANIMS = pointer_in_each({ 0x0800_A7A4, 0x0800_A79C, 0x0800_A7B8, 0x0800_A7B0 })
-- The palette buffer's background palette 0 (EXE6 0x03001960): RAM, the same in the four ROMs.
local PALETTE_BUFFER = 0x0300_3960

-- EXE5's panel types' names by number (compat/panels.toml, the names its rules give the same numbers).
function stage.panel_names(): { string }
    local panels = data("compat/panels.toml")
    local types = panels.types or {}
    for _, key in names.sorted(types) do
        if tonumber(key) == nil then
            error(string.format("panels.toml: type %q isn't a number", key), 0)
        end
    end
    local out: { string } = {}
    for n = 0, PANEL_TYPES - 1 do
        local entry = types[tostring(n)]
        if entry == nil then
            error(string.format("EXE5 panel %d: panels.toml has no type %d", n, n), 0)
        end
        table.insert(out, entry.name)
    end
    return out
end

-- The field, from `rom`.
function stage.field(rom: Rom): Field
    local tiles = at(rom, FIELD_TILES)
    local palettes = at(rom, FIELD_PALETTES)
    local panels = at(rom, PANEL_BLOCKS)
    local highlight = at(rom, HIGHLIGHT_BLOCK)
    local a: FieldAddresses = {
        tiles = tiles,
        palettes = palettes,
        panels = panels,
        highlights = { highlight, highlight },
        edges = at(rom, FRONT_EDGES),
        palette_anims = at(rom, PANEL_PALETTE_ANIMS),
        palette_buffer = PALETTE_BUFFER,
    }
    return field.read(rom, a, stage.panel_names())
end

-- The backgrounds' tables (the loader's literals): the load data by background id (EXE6 `off_8080F98`; Team ProtoMan
-- US's 0x0808C578), the scroll callbacks (16 bytes each, the second scrolls BG1; 0x0808C32C) and the GFX animation
-- lists (0x0808C96C). One background differs between the releases: 0x05, Yai's HP, which the Japanese ROMs draw as
-- bubbles in the dark, still, its palette its animations' (the US ROMs': goldfish, scrolling). The pack has the US
-- ROMs' (the verification knows what a Japanese console shows there).
local BACKGROUNDS = pointer_in_each({ 0x0808_C574, 0x0808_C5E4, 0x0808_BEC0, 0x0808_BF30 })
local BACKGROUND_SCROLL = pointer_in_each({ 0x0808_C328, 0x0808_C398, 0x0808_BC74, 0x0808_BCE4 })
local BACKGROUND_ANIMS = pointer_in_each({ 0x0808_C324, 0x0808_C394, 0x0808_BC70, 0x0808_BCE0 })
local BACKGROUND_COUNT = 29

-- The scroll callbacks and their counters' steps (1/16 pixel a frame): the same code as EXE6's `BGScrollCB_*`.
-- 0x08001A24 does nothing (drawn still); EXE5's own at 0x080019EC (nebulagray's, 0x1B) is a `speeding` scroll from
-- the battle's first frame, read from its code (@exelib/extract/scroll): while battle flag 0x40 is set
-- (BattleState+0x5C, which the battle's intro sets on its first frame, 0x080E06A0) it takes 0x400 from its counter
-- (0x0200A728, which the battle's init clears, 0x0808C2B8), to -0x40000, and moves BG1 down by the counter's
-- arithmetic shift right 16 (BG1VOFS minus it). (The callbacks are at the same addresses in the four ROMs.)
local SCROLLERS: { [number]: { number } } = {
    [0x0800_1936] = { -8, -4 }, -- EXE6 BGScrollCB_BG1Diagonal3to2Scroll
    [0x0800_196E] = { 0, -4 }, -- BGScrollCB_BG1UpScroll
    [0x0800_1992] = { 0, 4 }, -- BGScrollCB_BG1DownScroll
    [0x0800_19B6] = { 8, 0 }, -- a fast right scroll (EXE6 has a slow one)
    [0x0800_19C8] = { -8, 0 }, -- BGScrollCB_BG1FastLeftScroll
}

-- Each background number's picture as its load data, scroll callback and animations make it.
local function pictures(rom: Rom): { [number]: Background, n: number }
    local loads = at(rom, BACKGROUNDS)
    local scrolls = at(rom, BACKGROUND_SCROLL)
    local anim_lists = at(rom, BACKGROUND_ANIMS)
    local out: { [number]: Background, n: number } = { n = BACKGROUND_COUNT }
    for id = 0, BACKGROUND_COUNT - 1 do
        local b = backgrounds.picture(rom, rom:u32(loads + 4 * id))
        if b ~= nil then
            local callback = bit32.band(rom:u32(scrolls + 16 * id + 4), 0xFFFFFFFE)
            b.scroll = SCROLLERS[callback] or { 0, 0 }
            b.speeding = scroll.speeding(rom, callback)
            b.anims = gfx.anims(rom, rom:u32(anim_lists + 4 * id), PALETTE_BUFFER)
            out[id] = b
        end
    end
    return out
end

-- Whether two lists are one: the same length, each entry equal (`==`: a handle's own equality).
local function same_list<T>(a: { T }?, b: { T }?): boolean
    if a == nil or b == nil then
        return a == b
    end
    if #a ~= #b then
        return false
    end
    for i, x in a do
        if x ~= b[i] then
            return false
        end
    end
    return true
end

-- Whether two backgrounds are one picture: their tiles, map and palette, how they scroll and how they animate.
local function same_background(a: Background?, b: Background?): boolean
    if a == nil or b == nil then
        return a == b
    end
    local sa, sb = a.speeding, b.speeding
    local speeding = if sa == nil or sb == nil
        then sa == sb
        else same_list(sa.step, sb.step) and same_list(sa.top, sb.top) and sa.from_battle == sb.from_battle
    return a.tiles == b.tiles
        and a.first_tile == b.first_tile
        and a.map == b.map
        and a.map_width == b.map_width
        and a.map_height == b.map_height
        and same_list(a.palette, b.palette)
        and same_list(a.scroll, b.scroll)
        and speeding
        and same_list(a.anims, b.anims)
end

-- The battle backgrounds by number, from `rom`, one picture a background: where compat's assets.toml makes several
-- numbers one background (a liberation's map's number and its area's), the pack has the first's, and the others must
-- be the same (their load data, their scroll callbacks and their animations), or the extraction fails.
function stage.backgrounds(rom: Rom): { [number]: Background, n: number }
    local loads = at(rom, BACKGROUNDS)
    local scrolls = at(rom, BACKGROUND_SCROLL)
    local out = pictures(rom)
    -- A background's load data (seven words) and scroll callbacks (four).
    local function raw(id: number): { number }
        local d = rom:u32(loads + 4 * id)
        local words: { number } = {}
        for i = 0, 6 do
            table.insert(words, rom:u32(d + 4 * i))
        end
        for i = 0, 3 do
            table.insert(words, rom:u32(scrolls + 16 * id + 4 * i))
        end
        return words
    end
    local all = data("compat/assets.toml").backgrounds or {}
    for _, name in names.sorted(all) do
        local numbers: { number } = if type(all[name]) == "number" then { all[name] } else all[name]
        local first = numbers[1]
        for i = 2, #numbers do
            local n = numbers[i]
            if not (same_list(raw(n), raw(first)) and same_background(out[n], out[first])) then
                error(
                    string.format(
                        "background %s: 0x%02x isn't 0x%02x's picture again (its load data, scroll or animations differ)",
                        name,
                        n,
                        first
                    ),
                    0
                )
            end
            out[n] = nil
        end
    end
    return out
end

return stage
