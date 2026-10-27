--!strict
-- EXE5's thunder ball (attack object 0x2A, EXE6's number; 0x080C9FA0, EXE6's `sub_80C940C`): the shared ball
-- (@exelib/thunder/ball, EXE6's code) with EXE5's look: EXE5's ball sprite (10-11, a big ball's 0c-53), animation 0,
-- collision type row 0x0A (DarkThnd's its own) with hit modifier 0 (EXE6's an attack with 1), hitting navis, and its
-- sound for every ball. Thunder's and DarkThnd's, whose shot
-- (@exelib/thunder/shoot, action 0x1F) raises EXE5's buster arm: `thunder.shoot { ... }`.

local ball = require("@exelib/thunder/ball")
local buster = require("../../lib/buster")
local collision = require("../../rules/collision")
local shoot = require("@exelib/thunder/shoot")
local sparks = require("../../lib/sparks")
local big_thunder_ball_sprite = require("./big_thunder_ball_sprite")
local thunder_ball_sprite = require("../../sprites/thunder_ball")

local thunder = {}

thunder.kind = ball.make_kind("thunder/ball", {
    sprite = thunder_ball_sprite,
    small_anim = 0,
    big_sprite = big_thunder_ball_sprite,
    big_anim = 0,
    is = collision.thrown,
    target = collision.hits_navis,
    hit_mod = 0,
    spark = sparks.elec,
    sound = asset.sound("erase-man-2"),
})

local LOOK: ThunderShotLook = { buster = buster, ball = thunder.kind }

-- A chip's shot.
function thunder.shoot(spec: ThunderShot): Action
    return shoot.action(spec, LOOK)
end

return thunder
