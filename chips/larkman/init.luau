--!strict
-- LarkMan, LarkManSP and LarkManDS: the larkman series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local navi = require("@self/navi")
local navi_chips = require("../lib/navi_chips/chip")
local sp_chips = require("../rules/sp_chips")
local swoop = require("@self/swoop")

-- LarkMan's swoop (its variant 5).
local SWOOP = swoop.variant {
    speed_x = 0x8_0000,
    speed_y = 0x4_CCCC,
    turn_step = 0xD_AC50,
    shorter = 1,
    longer = 0,
    wild_turn = false,
    commanded = true,
}

-- LarkMan (EXE5 chip 0x110): LarkMan cuts in and sends his swoop round the field (./navi).
local larkman: Chip = {
    codes = { "S" },
    element = Element.null,
    family = Family.null,
    class = "mega",
    rarity = 2,
    mb = 45,
    damage = 140,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "larkman/controller",
        summon = navi.summon { palette = 0, swoop = SWOOP },
    },
    auto_battle = { class = "at_once" },
}

-- LarkManSP (EXE5 chip 0x111): LarkMan cuts in and sends his swoop round the field (../larkman/navi); its damage by how
-- fast its user deleted LarkMan SP (rules/sp_chips: formula 18, its table's row 17).
local larkman_sp: Chip = {
    codes = { "S" },
    element = Element.null,
    family = Family.null,
    class = "mega",
    rarity = 3,
    mb = 77,
    sp = { by_time = { 270, 260, 250, 240, 230, 220, 210, 200, 190, 180, 170 }, operation_battle = 220 },
    damage = sp_chips.damage,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "larkman-sp/controller",
        summon = navi.summon { palette = 0, swoop = SWOOP },
    },
    auto_battle = { class = "at_once" },
}

-- LarkManDS (EXE5 chip 0x112): LarkMan, dark, cuts in and sends his swoop round the field (../larkman/navi); its damage
-- by its user's side's statistic 3 (formula 40, its table's row 17).
local larkman_ds: Chip = {
    codes = { "S" },
    element = Element.null,
    family = Family.null,
    class = "mega",
    rarity = 3,
    mb = 77,
    damage = { formula = "count", of = { side_stat = "reactions" }, by_count = { 170, 180, 190, 200, 210, 220, 230, 240, 250, 260, 270 }, operation_battle = 180 },
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, damage_shown_variable = true, library = true, variable_damage = true },
    slot_in_limit = 1,
    megaman = "dark",
    navi = navi_chips.make {
        id = "larkman-ds/controller",
        summon = navi.summon { palette = 4, swoop = SWOOP },
    },
    auto_battle = { class = "at_once" },
}

return { larkman = larkman, ["larkman-sp"] = larkman_sp, ["larkman-ds"] = larkman_ds }
