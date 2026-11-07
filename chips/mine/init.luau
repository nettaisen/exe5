--!strict
-- Mine (EXE5 chip 0x062): a land mine hidden on a random panel of the other side's area: EXE6's Mine
-- (@exelib/mine, the dimming spawner's entry 11; EXE5's the same code but for its blast's effect number, EXE5's
-- 0x2A for EXE6's 0x47, the same look). Its collision type is EXE6's (row 0x33 with the 0x80 self bit), which EXE5's
-- targets don't test (docs/design/exe5-map.md §15.3 item 9).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "H", "P", "T" },
    element = Element.null,
    family = Family.invisible,
    class = "standard",
    rarity = 2,
    mb = 42,
    damage = 300,
    counter = 50,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = controller.hook,
    auto_battle = { class = "at_once" },
}

return { mine = chip }
