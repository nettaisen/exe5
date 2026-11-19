--!strict
-- EXE5's Invisibl's dimming controller (effect object #0x5D, EXE6's code: @exelib/invisible/controller), EXE5's kind;
-- its sound EXE6's number.

local common = require("@exelib/invisible/controller")

return common.make { id = "invisible/controller", sound = asset.sound("invisible") }
