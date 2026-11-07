--!strict
-- AirHoc (EXE5 chip 0x005): a puck flicked from the panel ahead, slanting down the field, that bounces around for 10
-- steps: EXE6's AirHocky (the shared flick and puck, @exelib/airhocky; EXE5's action 0x21, the same code but for the
-- recovery's start, and the puck's, attack object 0x2E, but for its sprite) with EXE5's puck (10-12; its rows at
-- 0x080CA3A4 are EXE6's, the record's Param1 2 and Param2 1, down).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local flick = require("@exelib/airhocky/flick")
local puck = require("@self/puck")

local chip: Chip = {
    codes = { "Q", "R", "S" },
    element = Element.null,
    family = Family["break"],
    class = "standard",
    rarity = 2,
    mb = 40,
    damage = 40,
    counter = 5,
    lockout = 50,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = flick.action {
        kind = puck.kind,
        -- The row 2 of 0x080CA3A4: 10 steps.
        puck = puck.variant { steps = 0x0A, own_side = 1, ticks = 6 },
        down = true,
    },
    auto_battle = { class = "to_front" },
}

return { airhoc = chip }
