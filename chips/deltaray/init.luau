--!strict
-- DeltaRay (EXE5 chip 0x12e): ProtoMan cuts in as DeltaRay and strikes the first enemy navi ahead, a strike more for each A while dimmed, up to three (./navi).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local navi = require("@self/navi")
local navi_chips = require("../lib/navi_chips/chip")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = Version.protoman,
    codes = { "Z" },
    element = Element.null,
    family = Family.sword,
    class = "giga",
    rarity = 4,
    mb = 82,
    damage = 220,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    navi = navi_chips.make {
        id = "deltaray/controller",
        summon = navi.summon { palette = 0 },
    },
    auto_battle = { class = "spot_test", range = "behind_target_up_open" },
}

return { deltaray = chip }
