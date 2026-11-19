--!strict
-- BugCurse's dimming controller and curse (EXE5's effect object #0x56, 0x080E6AC8, and attack object #0x80, 0x080D6534;
-- EXE4's code): @exelib/bug_curse with EXE5's look: the curse's sheet 0C-3F and its sound; what keeps it off the enemy
-- navi (0x080E6B84: 0x80000206, invisible, submerged, flashing or bubbled); its bugs, five (0x080D6644: code and
-- argument), and the operation battle's three (0x080D664E, three ticks).

local collision = require("../../rules/collision")
local common = require("@exelib/bug_curse")
local operation_battle = require("../../lib/operation_battle")
local bug_curse_sprite = asset.sprite("bug_curse")

local controller = {}

-- 0x080E6B62: BugCurse's `dimming` hook.
controller.hook = common.make {
    controller_id = "bug_curse/controller",
    curse_id = "bug_curse/curse",
    sprite = bug_curse_sprite,
    sound = asset.sound("trap_vanish"),
    untouched = { invisible = true, submerged = true, flashing = true, bubbled = true },
    bugs = {
        { bug = 0x24, arg = 1 },
        { bug = 0x18, arg = 20 },
        { bug = 0x19, arg = 20 },
        { bug = 0xFF, arg = 4 },
        { bug = 0xFE, arg = 4 },
    },
    operation_battle = operation_battle,
    operation_bugs = { { bug = 0x18, arg = 18 }, { bug = 0xF9, arg = 4 }, { bug = 0x14, arg = 8 } },
    is = collision.breaking,
    hits = collision.hits_navis,
}

return controller
