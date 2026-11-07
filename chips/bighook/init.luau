--!strict
-- BigHook (EXE5 chip 0x134): The hook swings two big flames across the enemy area (./hook); its user stays on the field.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local hook = require("@self/hook")
local navi_chips = require("../lib/navi_chips/chip")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = Version.protoman,
    codes = { "G" },
    element = Element.null,
    family = Family["break"],
    class = ChipClass.giga,
    rarity = 4,
    mb = 92,
    damage = 240,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    megaman = "light",
    -- (Its user stays on the field while the hook strikes: 0x080E1910, navi 26.)
    navi = navi_chips.make {
        id = "bighook/controller",
        summon = hook.summon,
        course = navi_chips.USER_STAYS,
    },
    auto_battle = { class = "at_once" },
}

return { bighook = chip }
