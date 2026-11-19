--!strict
-- CannBall (EXE5 chip 0x02c): a cannonball lobbed at the panel three ahead that hits and breaks the panel where it
-- lands: EXE5's throw (lib/bombs, action 0x12 subtype 4) and its cannonball (chips/cannon_ball/cannon_ball, attack object #0x35) of
-- kind 0.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bombs = require("../lib/bombs")
local cannon_ball = require("@self/cannon_ball")

local chip: Chip = {
    codes = { "C", "T", "Z", "*" },
    element = Element.null,
    family = Family["break"],
    class = ChipClass.standard,
    rarity = 2,
    mb = 30,
    damage = 140,
    counter = 40,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = bombs.throw { held = cannon_ball.held, thrower = cannon_ball.thrower() },
    auto_battle = { class = "into_reach", range = "three_ahead" },
}

return { cannon_ball = chip }
