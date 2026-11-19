--!strict
-- AirSpin1, AirSpin2 and AirSpin3: the airspin series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local action = require("@exelib/air_spin/action")
local top = require("@self/top")

-- AirSpin1 (EXE5 chip 0x082): action 0x47, EXE6's AirSpin (@exelib/air_spin/action): a whirlwind top
-- (./top) set down ahead in palette 0, spinning 2 times.
local air_spin_1: Chip = {
    codes = { "C", "E", "O" },
    element = Element.null,
    family = Family.wind,
    class = ChipClass.standard,
    rarity = 0,
    mb = 32,
    damage = 40,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = action.action { whirlwind = top.sender(0, 2) },
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

-- AirSpin2 (EXE5 chip 0x083): action 0x47, EXE6's AirSpin (@exelib/air_spin/action): a whirlwind top
-- (./top) set down ahead in palette 1, spinning 3 times.
local air_spin_2: Chip = {
    codes = { "B", "H", "W" },
    element = Element.null,
    family = Family.wind,
    class = ChipClass.standard,
    rarity = 1,
    mb = 44,
    damage = 40,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = action.action { whirlwind = top.sender(4, 3) },
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

-- AirSpin3 (EXE5 chip 0x084): action 0x47, EXE6's AirSpin (@exelib/air_spin/action): a whirlwind top
-- (./top) set down ahead in palette 2, spinning 4 times.
local air_spin_3: Chip = {
    codes = { "A", "G", "J" },
    element = Element.null,
    family = Family.wind,
    class = ChipClass.standard,
    rarity = 2,
    mb = 56,
    damage = 40,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = action.action { whirlwind = top.sender(8, 4) },
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

return { air_spin_1 = air_spin_1, air_spin_2 = air_spin_2, air_spin_3 = air_spin_3 }
