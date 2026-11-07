--!strict
-- AntiNavi (EXE5 chip 0x090): a trap that turns the other side's next navi chip around: EXE6's (@exelib/traps; EXE5's
-- the same code).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local traps = require("../lib/traps")

local chip: Chip = {
    codes = { "M", "T", "V" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 3,
    mb = 44,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    slot_in_limit = 3,
    trap = TrapKind.anti_navi,
    dimming = traps.hook(),
    auto_battle = { class = "when_trap_free" },
}

return { antinavi = chip }
