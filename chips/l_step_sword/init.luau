--!strict
-- LStepSwd (EXE5 chip 0x11f): a Liberation chip: a copy of the user's navi glows over it as it logs in, and the side gets
-- five uses of StepSword's Liberation ability, which only a Liberation Mission's specials use (the dimming handler's
-- subtype 66, objects/bug_fix).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bug_fix = require("../objects/bug_fix")

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 4,
    mb = 80,
    damage = 140,
    counter = 20,
    lockout = 0,
    flags = { dimming = true },
    slot_in_limit = 1,
    dimming = bug_fix.liberation,
    auto_battle = { class = "at_once" },
}

return { l_step_sword = chip }
