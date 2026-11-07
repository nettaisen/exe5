--!strict
-- PanlGrab (EXE5 chip 0x074): a dimming that drops a grab shot on the first panel past the user's side's front in
-- its row: EXE6's (@exelib/grab; EXE5's the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local grab = require("../lib/grab")

local chip: Chip = {
    codes = { "*" },
    element = "null",
    family = "null",
    class = ChipClass.standard,
    rarity = 0,
    mb = 6,
    damage = 10,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 1,
    dimming = grab.panel,
    auto_battle = { class = "at_once" },
}

return { panlgrab = chip }
