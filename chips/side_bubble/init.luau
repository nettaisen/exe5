--!strict
-- SideBub1, SideBub2 and SideBub3: the sidebub series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local side_bubble = require("@self/side_bubble")

-- SideBub1 (EXE5 chip 0x0a0): the navi sends two bubbles to the column ahead, in the rows above and below its own,
-- drifting forward and bouncing between the top and bottom rows; a popped bubble bursts into an aqua shot: EXE5's
-- own (chips/side_bubble/side_bubble).
local side_bubble_1: Chip = {
    codes = { "D", "Q", "S" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.standard,
    rarity = 0,
    mb = 25,
    damage = 90,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = side_bubble.action,
    auto_battle = { class = "into_reach", range = "one_ahead" },
}

-- SideBub2 (EXE5 chip 0x0a1): the navi sends two bubbles to the column ahead, in the rows above and below its own,
-- drifting forward and bouncing between the top and bottom rows; a popped bubble bursts into an aqua shot: EXE5's
-- own (chips/side_bubble/side_bubble).
local side_bubble_2: Chip = {
    codes = { "H", "L", "W" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.standard,
    rarity = 1,
    mb = 35,
    damage = 110,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = side_bubble.action,
    auto_battle = { class = "into_reach", range = "one_ahead" },
}

-- SideBub3 (EXE5 chip 0x0a2): the navi sends two bubbles to the column ahead, in the rows above and below its own,
-- drifting forward and bouncing between the top and bottom rows; a popped bubble bursts into an aqua shot: EXE5's
-- own (chips/side_bubble/side_bubble).
local side_bubble_3: Chip = {
    codes = { "E", "N", "P" },
    element = Element.aqua,
    family = Family.aqua,
    class = ChipClass.standard,
    rarity = 2,
    mb = 45,
    damage = 130,
    counter = 20,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = side_bubble.action,
    auto_battle = { class = "into_reach", range = "one_ahead" },
}

return { side_bubble_1 = side_bubble_1, side_bubble_2 = side_bubble_2, side_bubble_3 = side_bubble_3 }
