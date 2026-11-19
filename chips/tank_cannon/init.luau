--!strict
-- TankCan1, TankCan2 and TankCan3: the tankcan series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local tank_cannon = require("@self/tank_cannon")

-- TankCan1 (EXE5 chip 0x03f): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tank_cannon/tank_cannon: EXE6's with EXE5's look).
local tank_cannon_1: Chip = {
    codes = { "A", "E", "P" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 20,
    damage = 80,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = tank_cannon.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- TankCan2 (EXE5 chip 0x040): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tank_cannon/tank_cannon: EXE6's with EXE5's look).
local tank_cannon_2: Chip = {
    codes = { "B", "T", "Y" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 1,
    mb = 30,
    damage = 120,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = tank_cannon.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- TankCan3 (EXE5 chip 0x041): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tank_cannon/tank_cannon: EXE6's with EXE5's look).
local tank_cannon_3: Chip = {
    codes = { "F", "M", "R" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 2,
    mb = 40,
    damage = 160,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = tank_cannon.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { tank_cannon_1 = tank_cannon_1, tank_cannon_2 = tank_cannon_2, tank_cannon_3 = tank_cannon_3 }
