--!strict
-- AntiElec (EXE5 chip 0x08e): a trap the other side's first elec hit springs, striking back in elec on every
-- panel the enemy stands on (lib/traps/anti_trap: EXE6's ElemTrap trap and counterattack, EXE5's).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local anti_trap = require("../lib/traps/anti_trap")

local chip: Chip = {
    codes = { "A", "N", "Y", "*" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 2,
    mb = 59,
    damage = 200,
    counter = 50,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = anti_trap.hook("elec"),
    auto_battle = { class = "when_trap_free", element_trap = true },
}

return { antielec = chip }
