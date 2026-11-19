--!strict
-- HolyDrem's dimming controller (EXE5's effect object #0x59, 0x080E6DFC: @exelib/holy_dream/controller) with EXE5's
-- stand-in (./actor); its hook (0x080E6E78, the dimming spawner's entry 0x23) takes the user's side and facing.

local actor = require("./actor")
local common = require("@exelib/holy_dream/controller")

return common.make { id = "holy_dream/controller", stand_in = actor.spawn }
