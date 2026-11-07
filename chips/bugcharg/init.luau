--!strict
-- BugCharg (EXE5 chip 0x136): a giga cut-in chip whose stand-in takes in its user's NaviCust bugs and fires a heavy shot for each (./controller).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = "colonel",
    codes = { "B" },
    element = "null",
    family = "null",
    class = ChipClass.giga,
    -- A save can collect it (rules/folder): Team Colonel's library lists it, where this record's flags are Team
    -- ProtoMan's ROM's, which doesn't.
    collectible = true,
    rarity = 4,
    mb = 77,
    damage = 200,
    counter = 10,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true },
    slot_in_limit = 1,
    megaman = "dark",
    dimming = controller.hook,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { bugcharg = chip }
