--!strict
-- EXE5's BodyGrd (the dimming handler's subtype 46), where EXE6's is a trap: the shared controller
-- (@exelib/body_guard/controller, effect object #0x6D, 0x080E8620: the usual dimming phases; its effect, 0x080E8664,
-- sends out the striker at once with the controller's element and damage word plus the Atk+ bonus, and is done when
-- its second parameter is 0, the record's: at once), the shared striker (@exelib/body_guard/striker, effect object
-- #0x6E, 0x080E86B0: EXE6's code) with EXE5's identity and EXE5's diving shuriken (chips/shadowman/shuriken, attack
-- object #0x5C).

local controller = require("@exelib/body_guard/controller")
local shuriken = require("../shadowman/shuriken")
local striker = require("@exelib/body_guard/striker")

local body_guard = {}

body_guard.striker = striker.make_kind {
    id = "body_guard/striker",
    -- NameID 0xD3: a field object nothing swallows, leaves as junk or throws (Poltrgst's list).
    identity = new.identity {
        class = IdentityClass.field_object,
        version = 0,
        ai_index = 1,
        scrap = false,
        throwable = false,
        look = { anim = 0, palette = 0, shadow = false },
    },
    shuriken = shuriken.kind,
    throw_sound = asset.sound("boomerang"),
}

local CONTROLLER = controller.make("body_guard/controller", body_guard.striker)

body_guard.controller = CONTROLLER.kind

-- 0x080E868C: the chip's `dimming` hook; `wait`: the record's second parameter.
body_guard.hook = CONTROLLER.hook

return body_guard
