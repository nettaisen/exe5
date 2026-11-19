--!strict
-- EXE5's cannonball (attack object #0x35, 0x080CB5C8; thrown by action 0x12's subtype 4, 0x080CB7D4): the shared one
-- (@exelib/cannon_ball/ball, EXE5's code, which EXE4's Ball shares) with EXE5's look: the bomb's sprite, effects 0x14 (a
-- puff) and 0x11 (an impact), the crack's sound, a thrown object that breaks, hitting navis.

local attachment = require("../../objects/attachment")
local collision = require("../../rules/collision")
local common = require("@exelib/cannon_ball/ball")
local trajectory = require("../../lib/trajectory")

local cannon_ball = {}

-- 0x080CB5EC: the bomb's sprite.
local SPRITE = asset.sprite("bomb")
local hit_sparks_sprite = asset.sprite("hit_sparks")
local puff_sprite = asset.sprite("puff")

-- What the navi holds throwing one (the attachment table's row 0x1A): the bomb in palette 4.
cannon_ball.held = attachment.look { sprite = SPRITE, palette = 4 }

local made = common.make({
    id = "cannon_ball/ball",
    sprite = SPRITE,
    puff = new.effect { sprite = puff_sprite, anim = 2, palette = 0, steps = 4 },
    impact = new.effect { sprite = hit_sparks_sprite, anim = 1, palette = 0, steps = 10 },
    crack = asset.sound("panel_crack"),
    is = collision.thrown_break,
    hits = collision.hits_navis,
}, trajectory)

-- A thrower of cannonballs at the panel three ahead of the user.
cannon_ball.thrower = made.thrower

return cannon_ball
