--!strict
-- EXE5's BlakWing (the dimming handler's subtype 32): the shared BlakWing (@exelib/black_wing, EXE4's too), EXE5's
-- parts: sheet 0C-42, the puff (effect row 20), the start's and the flap's sounds (0x112, 0x130), its wings an
-- attack of type 0x480 hitting navis (row 0x25) with the plain spark, its perches listed as found from the enemy
-- area's front column (0x080D633E).

local collision = require("../../rules/collision")
local common = require("@exelib/black_wing")
local sparks = require("../../lib/sparks")
local black_wing_sprite = asset.sprite("black_wing")
local puff_sprite = asset.sprite("puff")

local black_wing = {}

-- 0x080E69CC: the chip's `dimming` hook.
black_wing.hook = common.make {
    controller_id = "black_wing/controller",
    flock_id = "black_wing/flock",
    perch_id = "black_wing/perch",
    wing_id = "black_wing/wing",
    sprite = black_wing_sprite,
    puff = new.effect { sprite = puff_sprite, anim = 2, palette = 0, steps = 4 },
    sounds = { start = asset.sound("place"), flap = asset.sound("black_wing_flap") },
    is = collision.attack_480,
    hits = collision.hits_navis,
    spark = sparks.plain,
}

return black_wing
