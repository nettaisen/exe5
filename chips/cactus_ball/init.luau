--!strict
-- CactBal1, CactBal2 and CactBal3: the cactbal series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local cactus_ball = require("@self/cactus_ball")

-- CactBal1 (EXE5 chip 0x0af): the navi throws a wooden ball that hops along the row, bouncing back off what it hits:
-- EXE5's own (chips/cactus_ball/cactus_ball), the ball in palette 0.
local cactus_ball_1: Chip = {
    codes = { "H", "I", "J" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 0,
    mb = 10,
    damage = 30,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = cactus_ball.action(0),
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- CactBal2 (EXE5 chip 0x0b0): the navi throws a wooden ball that hops along the row, bouncing back off what it hits:
-- EXE5's own (chips/cactus_ball/cactus_ball), the ball in palette 2.
local cactus_ball_2: Chip = {
    codes = { "Q", "R", "S" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 1,
    mb = 30,
    damage = 40,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = cactus_ball.action(2),
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- CactBal3 (EXE5 chip 0x0b1): the navi throws a wooden ball that hops along the row, bouncing back off what it hits:
-- EXE5's own (chips/cactus_ball/cactus_ball), the ball in palette 4.
local cactus_ball_3: Chip = {
    codes = { "L", "M", "N" },
    element = Element.wood,
    family = Family.wood,
    class = ChipClass.standard,
    rarity = 2,
    mb = 50,
    damage = 50,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = cactus_ball.action(4),
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { cactus_ball_1 = cactus_ball_1, cactus_ball_2 = cactus_ball_2, cactus_ball_3 = cactus_ball_3 }
