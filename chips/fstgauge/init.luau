--!strict
-- FstGauge (EXE5 chip 0x079): the user's custom gauge fills fast: EXE6's (@exelib/gauge_speed; EXE5's the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local gauge_speed = require("../lib/gauge_speed")

local chip: Chip = {
    codes = { "H", "Q", "W", "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 2,
    mb = 32,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 1,
    dimming = gauge_speed.fast,
    auto_battle = { class = "at_once" },
}

return { fstgauge = chip }
