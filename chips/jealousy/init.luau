--!strict
-- Jealousy (EXE5 chip 0x0d4): a cut-in chip whose effect hits every panel the opponent's side stands on once for
-- each chip the opponent holds, 10 ticks apart (./controller: EXE5's effect object #0x36, EXE6's code that no EXE6 chip
-- uses, @exelib/jealousy/controller).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    codes = { "J" },
    element = "null",
    family = "null",
    class = "mega",
    rarity = 3,
    mb = 35,
    damage = 80,
    hit_param = 138,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 1,
    dimming = controller.hook,
    auto_battle = { class = "at_once" },
}

return { jealousy = chip }
