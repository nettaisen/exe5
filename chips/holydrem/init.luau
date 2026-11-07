--!strict
-- HolyDrem (EXE5 chip 0x133): a light MegaMan's Giga chip: in the dimming, a stand-in of the user fires a shot along
-- the row, then one more for each holy panel on the field, each panel turned Normal: 50 damage a shot
-- (docs/design/exe5-map.md §6.2). Its dimming controller (./controller, EXE6's BurnSqr controller's code), stand-in
-- (./actor) and shot (./shot); the light MegaMan it needs is the record's `megaman` field, which the rules' light
-- and dark part reads.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = "protoman",
    codes = { "H" },
    element = "null",
    family = "null",
    class = ChipClass.giga,
    rarity = 4,
    mb = 92,
    damage = 50,
    counter = 5,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    dimming = controller.hook,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { holydrem = chip }
