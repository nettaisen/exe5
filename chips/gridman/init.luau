--!strict
-- GridMan, GridManSP and GridManDS: the gridman series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local navi = require("@self/navi")
local navi_chips = require("../lib/navi_chips/chip")
local sp_chips = require("../rules/sp_chips")

-- GridMan (EXE5 chip 0x113): GridMan cuts in, dashes across the field and strikes the whole enemy area (./navi).
local gridman: Chip = {
    codes = { "F" },
    element = "null",
    family = "null",
    class = ChipClass.mega,
    rarity = 2,
    mb = 46,
    damage = 100,
    counter = 40,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "gridman/controller",
        summon = navi.summon(0),
    },
    auto_battle = { class = "at_once" },
}

-- GridManSP (EXE5 chip 0x114): GridMan cuts in, dashes across the field and strikes the whole enemy area (../gridman/navi);
-- its damage by how fast its user deleted GridMan SP (rules/sp_chips: formula 19, its table's row 18).
local gridman_sp: Chip = {
    codes = { "F" },
    element = "null",
    family = "null",
    class = ChipClass.mega,
    rarity = 3,
    mb = 72,
    sp = { by_time = { 250, 240, 230, 220, 210, 200, 190, 180, 170, 160, 150 }, operation_battle = 230 },
    damage = sp_chips.damage,
    counter = 40,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    navi = navi_chips.make {
        id = "gridman-sp/controller",
        summon = navi.summon(0),
    },
    auto_battle = { class = "at_once" },
}

-- GridManDS (EXE5 chip 0x115): GridMan, dark, cuts in, dashes across the field and strikes the whole enemy area
-- (../gridman/navi); its damage by its user's side's statistic 3 (formula 41, its table's row 18).
local gridman_ds: Chip = {
    codes = { "F" },
    element = "null",
    family = "null",
    class = ChipClass.mega,
    rarity = 3,
    mb = 72,
    damage = { formula = Formula.count, of = { side_stat = "reactions" }, by_count = { 150, 160, 170, 180, 190, 200, 210, 220, 230, 240, 250 }, operation_battle = 180 },
    counter = 40,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, damage_shown_variable = true, library = true, variable_damage = true },
    slot_in_limit = 1,
    megaman = "dark",
    navi = navi_chips.make {
        id = "gridman-ds/controller",
        summon = navi.summon(5),
    },
    auto_battle = { class = "at_once" },
}

return { gridman = gridman, ["gridman-sp"] = gridman_sp, ["gridman-ds"] = gridman_ds }
