--!strict
-- EXE5's GrabBnsh's and GrabRvng's dimming controller (effect object #0x22) and hand (attack object #0x46): EXE6's
-- code (@exelib/grabbnsh), EXE5's kinds; the hand's look EXE6's numbers, its hit EXE5's curse row
-- hitting navis, the flash on each panel taken
-- back (EXE5's effect 0x29, EXE6's 0x3B: the same) and its sound EXE6's number.

local collision = require("../../rules/collision")
local common = require("@exelib/grabbnsh/controller")
local hand = require("@exelib/grabbnsh/hand")
local grab_shot_sprite = require("../../sprites/grab_shot")

local hand_kind = hand.make_kind {
    id = "grabbnsh/hand",
    sprite = grab_shot_sprite,
    fall_sound = asset.sound("grab-shot-2"),
    land_sound = asset.sound("grab-shot"),
    target = collision.hits_navis,
    self_type = collision.curse,
}

return common.make {
    id = "grabbnsh/controller",
    hand = hand_kind,
    returned = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0 },
    return_sound = asset.sound("err-select-91"),
}
