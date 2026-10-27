--!strict
-- The battle sprites and the portraits: the sprite list (EXE6's `SpritePointersList`, 0x08031CC4; Team ProtoMan US's
-- 0x08032728: per category, a table of sprite archive entries, bit 31 LZ77 compressed), whose pointer is at the same
-- address in the four ROMs.

local place = require("@exelib/extract/place")
local lists = require("@exelib/extract/sprites")

local sprites = {}

local SPRITE_LIST = place.pointer(0x0800_2690, 0x0800_2690)
-- Categories with battle sprites (the byte offsets 0x00..=0x14, as in EXE6) of the list's ten.
local BATTLE_CATEGORIES = 6
local CATEGORIES = 10

-- The portraits' category (the sprite list's byte offset 0x20, EXE6's `mugshotSpritePtrs`) and an entry every ROM
-- has its placeholder in.
local PORTRAITS = 0x20
local PLACEHOLDER_PORTRAIT = 0x2A

-- The portraits content names (the chatbox's speakers: a no-running message's `F5 00 n`), each from a ROM that has
-- its face: the Team ProtoMan US ROM's unless it has the placeholder there, then the Team Colonel one's (a version's
-- Japanese ROM has the same pictures and the same placeholders as its US one). Team ProtoMan's ROM has the
-- placeholder for four of Team Colonel's navis, Team Colonel's for five of Team ProtoMan's: a console operates its own
-- team's navis alone (a save has a stats block for no other), so no placeholder is ever shown, and the pack keeps no
-- mark of whose a face is.
local function portraits(set: Set, names: AssetNames): { Sheet }
    local sources = { set.BRBE, set.BRKE }
    local indexes: { number } = {}
    for index in ((names.sprites or {})[PORTRAITS] or {}) do
        table.insert(indexes, index)
    end
    table.sort(indexes)
    local out: { Sheet } = {}
    for _, index in indexes do
        local sheet = lists.portrait(sources, SPRITE_LIST, PORTRAITS, index, PLACEHOLDER_PORTRAIT)
        if sheet ~= nil then
            table.insert(out, sheet)
        end
    end
    return out
end

-- The battle sprites, from the Team ProtoMan US ROM (the two versions' ROMs have the same ones, and the four the same
-- but for one label's words, which the verification knows a Japanese console shows otherwise), and the named
-- portraits.
function sprites.sprites(set: Set, names: AssetNames): { Sheet }
    local rom = set.BRBE
    local categories = lists.categories(rom, place.at(rom, SPRITE_LIST), CATEGORIES)
    local out: { Sheet } = {}
    for k = 1, BATTLE_CATEGORIES do
        local category = (k - 1) * 4
        for index = 0, lists.slots(categories, k) - 1 do
            local sheet = lists.sheet(rom, rom:u32(categories[k] + 4 * index), category, index)
            if sheet ~= nil then
                table.insert(out, sheet)
            end
        end
    end
    for _, sheet in portraits(set, names) do
        table.insert(out, sheet)
    end
    return out
end

return sprites
