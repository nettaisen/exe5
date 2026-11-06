--!strict
-- Navi+20 (EXE5 chip 0x096): folded into the navi chip before it on the custom screen, 20 more damage; used alone,
-- action 0x1A's effect 3 (lib/plus: the sparkle, or in a special battle the side's Navi+ bonus).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local plus = require("../lib/plus")

local chip: Chip = {
    codes = { "*" },
    element = "null",
    family = "plus",
    class = "standard",
    rarity = 2,
    mb = 36,
    damage = 20,
    counter = 0,
    lockout = 20,
    flags = { standard_library = true, library = true },
    extra_flags = { modifier = true, free_slot_in = true },
    slot_in_limit = 3,
    modifier = "navi_plus",
    instant = plus.navi,
    auto_battle = { class = "at_once" },
}

return { ["navi-20"] = chip }
