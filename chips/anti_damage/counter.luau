--!strict
-- EXE5's AntiDmg's counter (navi action 0x47) and shuriken (attack object #0xC2): EXE6's code (@exelib/anti_damage), EXE5's
-- definitions; the shuriken's look and collision types, the sounds and the puff EXE6's. The rules start it by role
-- (`actions.anti_damage_counter`, rules/roles.luau): a trap's catch leaves the attack's variant 0, a random enemy;
-- ShadowSoul's stance (navis/megaman/forms/shadow_soul/back) 1, the nearest enemy ahead.

local collision = require("../../rules/collision")
local common = require("@exelib/anti_damage/counter")
local effects = require("../../lib/effects")
local shuriken = require("@exelib/anti_damage/shuriken")
local shuriken_sprite = asset.sprite("shuriken")

local counter = {}

local shuriken_kind = shuriken.make_kind {
    id = "anti_damage/shuriken",
    sprite = shuriken_sprite,
    land_sound = asset.sound("panel_crack"),
    puff = effects.bubbles,
    self_type = collision.thrown_slash,
    target = collision.hits_navis,
}

-- (ShadowMan's charged attack throws the same shuriken: navis/shadowman/charge.)
counter.shuriken = shuriken_kind

counter.action = common.action_at {
    id = "anti_damage/counter",
    shuriken = shuriken_kind,
    vanish_sound = asset.sound("trap_vanish"),
    throw_sound = asset.sound("boomerang"),
    puff = effects.bubbles,
}

return counter
