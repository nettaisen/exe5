--!strict
-- BlizMan, BlizManSP and BlizManDS: the blizman series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local navi = require("@self/navi")
local navi_chips = require("../lib/navi_chips/chip")
local sp_chips = require("../rules/sp_chips")

-- BlizMan (EXE5 chip 0x107): BlizzardMan cuts in and rolls a snowball down his row, growing on the field objects it
-- swallows (./navi).
local blizzardman: Chip = {
    codes = { "B" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.mega,
    rarity = 2,
    mb = 27,
    damage = 100,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "blizzardman/controller",
        summon = navi.summon(0),
    },
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- BlizManSP (EXE5 chip 0x108): BlizzardMan cuts in and rolls a snowball down his row, growing on the field objects it
-- swallows (../blizzardman/navi); its damage by how fast its user deleted BlizzardMan SP (rules/sp_chips: formula 15, its
-- table's row 14).
local blizzardman_sp: Chip = {
    codes = { "B" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.mega,
    rarity = 3,
    mb = 55,
    sp = { by_time = { 180, 175, 170, 165, 160, 155, 150, 145, 140, 135, 130 }, operation_battle = 200 },
    damage = sp_chips.damage,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "blizzardman_sp/controller",
        summon = navi.summon(0),
    },
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- BlizManDS (EXE5 chip 0x109): BlizzardMan, dark, cuts in and rolls a snowball down his row, growing on the field
-- objects it swallows (../blizzardman/navi); its damage by its user's side's statistic 3 (formula 37, its table's row 14).
local blizzardman_ds: Chip = {
    codes = { "B" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.mega,
    rarity = 3,
    mb = 55,
    damage = { formula = Formula.count, of = { side_stat = "reactions" }, by_count = { 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180 }, operation_battle = 160 },
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, damage_shown_variable = true, library = true, variable_damage = true },
    slot_in_limit = 1,
    megaman = "dark",
    navi = navi_chips.make {
        id = "blizzardman_ds/controller",
        summon = navi.summon(3),
    },
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { blizzardman = blizzardman, blizzardman_sp = blizzardman_sp, blizzardman_ds = blizzardman_ds }
