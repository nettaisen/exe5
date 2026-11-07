--!strict
-- AreaGrab (EXE5 chip 0x075): a dimming that drops grab shots on the first column in front not wholly the user's
-- side's: EXE6's (@exelib/grab; EXE5's the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local grab = require("../lib/grab")

local chip: Chip = {
    codes = { "A", "L", "S", "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 1,
    mb = 8,
    damage = 10,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 1,
    dimming = grab.area,
    auto_battle = { class = "at_once" },
}

return { areagrab = chip }
