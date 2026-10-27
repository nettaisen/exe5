--!strict
-- EXE5's hockey puck (attack object #0x2E, 0x080CA3D4): the shared puck (@exelib/airhocky/puck, EXE6's code) with EXE5's
-- look: EXE6's collision types, spark and sounds, EXE5's sprite (10-12), its burst a puff (effect 0x14). AirHoc's and
-- PitHoky's, each stating its own row (`puck.variant`, a row of 0x080CA3A4, EXE6's: the steps it lasts, how it bounces
-- and its ticks per step; PitHoky's leaves a trail).

local collision = require("../../rules/collision")
local common = require("@exelib/airhocky/puck")
local sparks = require("../../lib/sparks")
local hockey_puck_sprite = require("./hockey_puck_sprite")
local puff_sprite = require("../../sprites/puff")

local puck = {}

puck.kind = common.make_kind("airhoc/puck", {
    sprite = hockey_puck_sprite,
    sound = asset.sound("hockey-puck"),
    bounce = asset.sound("bounce"),
    is = collision.breaking,
    hits = collision.hits_navis,
    spark = sparks.breaking,
    burst = new.effect { sprite = puff_sprite, anim = 2, palette = 0 },
})

-- A puck's row.
puck.variant = common.variant

return puck
