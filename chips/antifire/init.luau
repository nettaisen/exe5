--!strict
-- AntiFire (EXE5 chip 0x08c): a trap the other side's first fire hit springs, striking back in fire on every
-- panel the enemy stands on (lib/traps/anti_trap: EXE6's ElemTrap trap and counterattack, EXE5's).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local anti_trap = require("../lib/traps/anti_trap")

local chip: Chip = {
    codes = { "E", "K", "T", "*" },
    element = Element.fire,
    family = Family.fire,
    class = ChipClass.standard,
    rarity = 2,
    mb = 58,
    damage = 200,
    counter = 50,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = anti_trap.hook(PrimaryElement.fire),
    auto_battle = { class = "when_trap_free", element_trap = true },
}

return { antifire = chip }
