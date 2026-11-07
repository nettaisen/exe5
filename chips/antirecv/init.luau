--!strict
-- AntiRecv (EXE5 chip 0x093): a trap that turns the other side's next recovery into damage: EXE6's (@exelib/traps,
-- its counterattack the role kinds.anti_recovery; EXE5's the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local traps = require("../lib/traps")

local chip: Chip = {
    codes = { "B", "J", "P" },
    element = "null",
    family = "null",
    class = ChipClass.standard,
    rarity = 2,
    mb = 37,
    damage = 0,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 3,
    trap = TrapKind.anti_recovery,
    dimming = traps.hook(),
    auto_battle = { class = "when_trap_free" },
}

return { antirecv = chip }
