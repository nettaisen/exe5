--!strict
-- WoodNos1, WoodNos2 and WoodNos3: the woodnos series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local wood_nose = require("@self/wood_nose")

-- WoodNos1 (EXE5 chip 0x0b2): the navi sends a wooden wave along its row; past the field it raises geysers under the
-- other side's navis: EXE5's own (chips/wood_nose/wood_nose).
local wood_nose_1: Chip = {
    codes = { "F", "R", "W" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 0,
    mb = 27,
    damage = 100,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = wood_nose.action,
    auto_battle = { class = "to_back" },
}

-- WoodNos2 (EXE5 chip 0x0b3): the navi sends a wooden wave along its row; past the field it raises geysers under the
-- other side's navis: EXE5's own (chips/wood_nose/wood_nose).
local wood_nose_2: Chip = {
    codes = { "J", "T", "Z" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 1,
    mb = 40,
    damage = 130,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = wood_nose.action,
    auto_battle = { class = "to_back" },
}

-- WoodNos3 (EXE5 chip 0x0b4): the navi sends a wooden wave along its row; past the field it raises geysers under the
-- other side's navis: EXE5's own (chips/wood_nose/wood_nose).
local wood_nose_3: Chip = {
    codes = { "I", "S", "V" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 2,
    mb = 53,
    damage = 160,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = wood_nose.action,
    auto_battle = { class = "to_back" },
}

return { wood_nose_1 = wood_nose_1, wood_nose_2 = wood_nose_2, wood_nose_3 = wood_nose_3 }
