--!strict
-- HotBody1, HotBody2 and HotBody3: the hotbody series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local hotbody = require("@self/hotbody")

-- HotBody1 (EXE5 chip 0x09a): the navi bursts into flames that spread to the enemies around it, two rounds 30 ticks
-- apart (chips/hotbody/hotbody, action 0x58; the record's second parameter, 2).
local hotbody1: Chip = {
    codes = { "A", "F", "P" },
    element = Element.fire,
    family = Family.fire,
    class = "standard",
    rarity = 0,
    mb = 28,
    damage = 110,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = hotbody.action(2),
    auto_battle = { class = "into_reach", range = "around" },
}

-- HotBody2 (EXE5 chip 0x09b): the navi bursts into flames that spread to the enemies around it, two rounds 30 ticks
-- apart (chips/hotbody/hotbody, action 0x58; the record's second parameter, 2).
local hotbody2: Chip = {
    codes = { "C", "R", "W" },
    element = Element.fire,
    family = Family.fire,
    class = "standard",
    rarity = 1,
    mb = 40,
    damage = 130,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = hotbody.action(2),
    auto_battle = { class = "into_reach", range = "around" },
}

-- HotBody3 (EXE5 chip 0x09c): the navi bursts into flames that spread to the enemies around it, two rounds 30 ticks
-- apart (chips/hotbody/hotbody, action 0x58; the record's second parameter, 2).
local hotbody3: Chip = {
    codes = { "J", "M", "S" },
    element = Element.fire,
    family = Family.fire,
    class = "standard",
    rarity = 2,
    mb = 52,
    damage = 150,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = hotbody.action(2),
    auto_battle = { class = "into_reach", range = "around" },
}

return { hotbody1 = hotbody1, hotbody2 = hotbody2, hotbody3 = hotbody3 }
