--!strict
-- BugCharg's dimming controller (EXE5's effect object #0x7C, 0x080E98C8; its hook 0x080E9946):
-- @exelib/bug_charge/controller with EXE5's stand-in (./actor).

local actor = require("./actor")
local common = require("@exelib/bug_charge/controller")

return common.make { id = "bug_charge/controller", actor = actor.spawn }
