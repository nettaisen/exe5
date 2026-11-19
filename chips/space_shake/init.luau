--!strict
-- SpShake1, SpShake2 and SpShake3: the spshake series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local space_shake = require("@self/space_shake")

-- Their waves: 1.5, 2.25 and 3 pixels a tick (rows 0 to 2 of 0x080D30D4), in palettes 0, 6 and 12.
local WAVE1 = space_shake.wave { speed = 0x1_8000, paralyzes = false, palette = 0 }
local WAVE2 = space_shake.wave { speed = 0x2_4000, paralyzes = false, palette = 6 }
local WAVE3 = space_shake.wave { speed = 0x3_0000, paralyzes = false, palette = 0x0C }

-- SpShake1 (EXE5 chip 0x018): an electric wave that snakes along the field from the panel ahead (EXE5's SpShake,
-- chips/space_shake/space_shake: action 0x51).
local space_shake_1: Chip = {
    codes = { "G", "H", "I" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 0,
    mb = 30,
    damage = 60,
    counter = 20,
    lockout = 20,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = space_shake.action(WAVE1),
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

-- SpShake2 (EXE5 chip 0x019): an electric wave that snakes along the field from the panel ahead (EXE5's SpShake,
-- chips/space_shake/space_shake: action 0x51).
local space_shake_2: Chip = {
    codes = { "B", "C", "D" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 1,
    mb = 40,
    damage = 80,
    counter = 20,
    lockout = 20,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = space_shake.action(WAVE2),
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

-- SpShake3 (EXE5 chip 0x01a): an electric wave that snakes along the field from the panel ahead (EXE5's SpShake,
-- chips/space_shake/space_shake: action 0x51).
local space_shake_3: Chip = {
    codes = { "S", "T", "U" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 2,
    mb = 50,
    damage = 100,
    counter = 20,
    lockout = 20,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = space_shake.action(WAVE3),
    auto_battle = { class = "into_reach", range = "all_ahead" },
}

return { space_shake_1 = space_shake_1, space_shake_2 = space_shake_2, space_shake_3 = space_shake_3 }
