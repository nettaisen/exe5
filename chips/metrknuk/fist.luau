--!strict
-- A MetrKnuk fist (EXE5's attack object #0x76, 0x080D4C58): the shared fist (@exelib/metrknuk/fist), EXE5's kind: its
-- sprite 0C-55, no sound as it falls, gone when the battle ends (0x080D4D08); its hit (0x080D4E2E, 0x15050001) a
-- breaking thrown attack hitting navis on its panel, with the null spark.

local collision = require("../../rules/collision")
local common = require("@exelib/metrknuk/fist")
local effects = require("../../lib/effects")
local sparks = require("../../lib/sparks")
local justice_one_sprite = require("../justcone/justice_one_sprite")

return common.make {
    id = "metrknuk/fist",
    sprite = justice_one_sprite,
    anim = 0,
    sound = nil,
    burst = effects.burst,
    burst_on_fist = false,
    self_type = collision.thrown_break,
    target = collision.hits_navis,
    spark = sparks.plain,
    ends_with_battle = true,
}
