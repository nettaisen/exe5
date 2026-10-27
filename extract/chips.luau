--!strict
-- The chips' pictures and icons, from their records: each chip's from a ROM of its version, a team navi's own chip's
-- picture from its team's (versions.luau), any other's from the Team ProtoMan US ROM, which every ROM has alike.

local place = require("@exelib/extract/place")
local hud = require("./hud")
local versions = require("./versions")

local chips = {}

-- The chip records (0x2C bytes, as EXE6's; the chip accessor's literal, Team ProtoMan US's table 0x0801E214): +0x20
-- the icon, +0x24 the picture, +0x28 its palette.
local CHIP_DATA = place.pointer_in_each({ 0x0801_DF1C, 0x0801_DF18, 0x0801_DED8, 0x0801_DED4 })
local CHIP_COUNT = 368
local PICTURE_BYTES = 0x540

-- The chips with art in the pack: the named ones' table, and past it the ones the content names (the invalid chip,
-- 0x185: its record's art is the blank icon and picture the unused records have, what EXE5 draws).
local function ids(names: AssetNames): { number }
    local out: { number } = {}
    for id = 0, CHIP_COUNT - 1 do
        table.insert(out, id)
    end
    local past: { number } = {}
    for id in (names.chips or {}) do
        if id >= CHIP_COUNT then
            table.insert(past, id)
        end
    end
    table.sort(past)
    for _, id in past do
        table.insert(out, id)
    end
    return out
end

-- A chip's key as the pack has its icon and picture under (`chip-185` where compat names none).
local function key(names: AssetNames, id: number): string
    local keys = names.chips or {}
    return keys[id] or string.format("chip-%03x", id)
end

-- A chip's picture (tiles and palette) and icon in `rom`, each where its record has one. A picture whose palette no ROM
-- holds (the e-Reader cards' LeadRaid and ChaosLrd: their records point at EWRAM, 0x02001660 and 0x02001680, where the
-- save's card data goes) gets a black one; its definition gives the palette (`art_palette`), as EXE6's gift chips'
-- do.
local function media(rom: Rom, id: number): (Picture, Tiles?)
    local r = place.at(rom, CHIP_DATA) + 0x2C * id
    local icon, gfx, pal = rom:u32(r + 0x20), rom:u32(r + 0x24), rom:u32(r + 0x28)
    local picture: Picture = {}
    if rom:holds(gfx) then
        local palette: Palette = if rom:holds(pal) then hud.palette(rom, pal) else { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }
        local drawn: Picture = { tiles = gba.tiles(rom, gfx, PICTURE_BYTES), palette = palette }
        picture = drawn
    end
    local tiles = if rom:holds(icon) then gba.tiles(rom, icon, 0x80) else nil
    return picture, tiles
end

-- The chips' pictures, each under its chip's key: a version chip's from its own version's ROM, marked with it (a
-- console of the other version shows its counterpart's there); a team navi's own chip's from its team's (with no
-- counterpart on the other version's console); any other's from the Team ProtoMan US ROM.
function chips.art(set: Set, names: AssetNames): { ChipArt }
    local out: { ChipArt } = {}
    for _, id in ids(names) do
        local own = versions.chip_version(id)
        local picture = media(versions.rom(set, own or versions.own_chip_version(id)), id)
        local art: ChipArt = { key = key(names, id), picture = picture, version = own }
        table.insert(out, art)
    end
    return out
end

-- The chips' icons, each under its chip's key, from the ROM its version's picture is from.
function chips.icons(set: Set, names: AssetNames): { { key: string, tiles: Tiles? } }
    local out: { { key: string, tiles: Tiles? } } = {}
    for _, id in ids(names) do
        local _, icon = media(versions.rom(set, versions.chip_version(id)), id)
        table.insert(out, { key = key(names, id), tiles = icon })
    end
    return out
end

return chips
