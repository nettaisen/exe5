--!strict
-- AntiSwrd (EXE5 chip 0x092): a trap that answers the next sword with a slash: EXE6's (@exelib/traps, its counter
-- the role actions.anti_sword_counter; EXE5's the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local traps = require("../lib/traps")

local chip: Chip = {
    codes = { "D", "O", "R" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.standard,
    rarity = 2,
    mb = 43,
    damage = 100,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    trap = TrapKind.anti_sword,
    dimming = traps.hook(),
    auto_battle = { class = "when_trap_free" },
}

return { antiswrd = chip }
