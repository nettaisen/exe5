--!strict
-- TankCan1, TankCan2 and TankCan3: the tankcan series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local tankcan = require("@self/tankcan")

-- TankCan1 (EXE5 chip 0x03f): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tankcan/tankcan: EXE6's with EXE5's look).
local tankcan1: Chip = {
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
    action = tankcan.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- TankCan2 (EXE5 chip 0x040): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tankcan/tankcan: EXE6's with EXE5's look).
local tankcan2: Chip = {
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
    action = tankcan.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- TankCan3 (EXE5 chip 0x041): a shell from the panel ahead that staggers what it hits, or, off the far edge, blasts
-- and cracks the last column and sets off three explosions there (chips/tankcan/tankcan: EXE6's with EXE5's look).
local tankcan3: Chip = {
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
    action = tankcan.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { tankcan1 = tankcan1, tankcan2 = tankcan2, tankcan3 = tankcan3 }
