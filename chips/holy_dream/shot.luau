--!strict
-- HolyDrem's shot (EXE5's attack object #0x83, 0x080D6A60: @exelib/holy_dream/shot) in EXE5's look: its sprite, its
-- sound (0xBB) and collision rows (0x17, 5), the plain spark; its spawn (0x080D6B88) takes its owner's side and facing.

local collision = require("../../rules/collision")
local common = require("@exelib/holy_dream/shot")
local sparks = require("../../lib/sparks")
local holy_dream_shot_sprite = asset.sprite("holy_dream_shot")

return common.make {
    id = "holy_dream/shot",
    sprite = holy_dream_shot_sprite,
    sound = asset.sound("energy_burst"),
    is = collision.thrown_piercing_break,
    hits = collision.hits_navis,
    spark = sparks.plain,
}
