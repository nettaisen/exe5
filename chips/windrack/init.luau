--!strict
-- WindRack (EXE5 chip 0x035): a swing of a rack that pushes the column ahead (chips/windrack/action: EXE6's WindRack,
-- action 0x26, without its gusts).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local windrack = require("@self/action")

local chip: Chip = {
    codes = { "B", "F", "J", "*" },
    element = Element.null,
    family = Family.wind,
    class = "standard",
    rarity = 2,
    mb = 23,
    damage = 100,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = windrack.action,
    auto_battle = { class = "into_reach", range = "column_ahead" },
}

return { windrack = chip }
