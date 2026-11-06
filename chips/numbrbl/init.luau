--!strict
-- NumbrBl (EXE5 chip 0x0d3): a cut-in chip: the user warps out, and NumberMan himself sets five balls rolling down the
-- row (./controller, ./numberman); its damage is the last two digits of the user's HP.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "N", "*" },
    element = "null",
    family = "null",
    class = "mega",
    rarity = 3,
    mb = 69,
    damage = { formula = "hp_last_digits" },
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, damage_shown_variable = true, library = true, variable_damage = true },
    slot_in_limit = 1,
    -- Five balls (the original's by the chip's level, its first parameter 2, and three).
    dimming = controller.hook(5),
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { numbrbl = chip }
