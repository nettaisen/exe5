--!strict
-- BatCan1, BatCan2, BatCan3 and BatCan4: the batcan series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bat_cannon = require("@self/bat_cannon")

-- BatCan1 (EXE5 chip 0x13b): the navi raises its bat cannon and fires an unseen shot from the panel ahead on the 7th
-- tick: EXE6's BatCan (chips/bat_cannon/bat_cannon).
local bat_cannon_1: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 5,
    damage = 40,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true },
    slot_in_limit = 1,
    action = bat_cannon.action { shots = { { flinch = true, flash = true } } },
    -- Past the chip pack's list (its last chip 0x13A): no folder holds it (rules/folder).
    past_the_pack = true,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- BatCan2 (EXE5 chip 0x13c): the navi raises its bat cannon and fires an unseen shot from the panel ahead on the 7th
-- tick: EXE6's BatCan (chips/bat_cannon/bat_cannon).
local bat_cannon_2: Chip = {
    codes = { "S" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 5,
    damage = 40,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true },
    slot_in_limit = 1,
    action = bat_cannon.action { shots = { { flinch = true, flash = true } } },
    -- Past the chip pack's list (its last chip 0x13A): no folder holds it (rules/folder).
    past_the_pack = true,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- BatCan3 (EXE5 chip 0x13d): the navi raises its bat cannon and fires an unseen shot from the panel ahead on the 7th
-- tick: EXE6's BatCan (chips/bat_cannon/bat_cannon).
local bat_cannon_3: Chip = {
    codes = { "R" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 5,
    damage = 40,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true },
    slot_in_limit = 1,
    action = bat_cannon.action { shots = { { flinch = true, flash = true } } },
    -- Past the chip pack's list (its last chip 0x13A): no folder holds it (rules/folder).
    past_the_pack = true,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- BatCan4 (EXE5 chip 0x13e): the navi raises its bat cannon and fires three unseen shots from the panel ahead, 16
-- ticks apart, the last staggering harder: EXE6's BatCan4 (chips/bat_cannon/bat_cannon).
local bat_cannon_4: Chip = {
    codes = { "Z" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 5,
    damage = 40,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true },
    slot_in_limit = 1,
    action = bat_cannon.action { shots = { { flinch = true }, { flinch = true }, { flinch = true, flash = true } } },
    -- Past the chip pack's list (its last chip 0x13A): no folder holds it (rules/folder).
    past_the_pack = true,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { bat_cannon_1 = bat_cannon_1, bat_cannon_2 = bat_cannon_2, bat_cannon_3 = bat_cannon_3, bat_cannon_4 = bat_cannon_4 }
