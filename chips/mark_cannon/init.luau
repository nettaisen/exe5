--!strict
-- MrkCan1, MrkCan2 and MrkCan3: the mrkcan series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local mark_cannon = require("@self/mark_cannon")

-- MrkCan1 (EXE5 chip 0x00c): a sight sweeps the field ahead and locks on to the first enemy it finds, paralyzing it,
-- and the cannon fires at it (EXE5's own MarkCannon, chips/mark_cannon/mark_cannon: action 0x4E).
local mark_cannon_1: Chip = {
    codes = { "M", "K", "S" },
    element = Element.null,
    family = Family.cursor,
    class = ChipClass.standard,
    rarity = 0,
    mb = 18,
    damage = 70,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = mark_cannon.action { cannon = mark_cannon.cannon(0) },
    auto_battle = { class = "to_front" },
}

-- MrkCan2 (EXE5 chip 0x00d): a sight sweeps the field ahead and locks on to the first enemy it finds, paralyzing it,
-- and the cannon fires at it (EXE5's own MarkCannon, chips/mark_cannon/mark_cannon: action 0x4E).
local mark_cannon_2: Chip = {
    codes = { "D", "F", "Z" },
    element = Element.null,
    family = Family.cursor,
    class = ChipClass.standard,
    rarity = 1,
    mb = 27,
    damage = 100,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = mark_cannon.action { cannon = mark_cannon.cannon(3) },
    auto_battle = { class = "to_front" },
}

-- MrkCan3 (EXE5 chip 0x00e): a sight sweeps the field ahead and locks on to the first enemy it finds, paralyzing it,
-- and the cannon fires at it (EXE5's own MarkCannon, chips/mark_cannon/mark_cannon: action 0x4E).
local mark_cannon_3: Chip = {
    codes = { "E", "R", "Y" },
    element = Element.null,
    family = Family.cursor,
    class = ChipClass.standard,
    rarity = 2,
    mb = 36,
    damage = 130,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = mark_cannon.action { cannon = mark_cannon.cannon(6) },
    auto_battle = { class = "to_front" },
}

return { mark_cannon_1 = mark_cannon_1, mark_cannon_2 = mark_cannon_2, mark_cannon_3 = mark_cannon_3 }
