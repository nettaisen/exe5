--!strict
-- EXE5's GrabBnsh's and GrabRvng's dimming controller (effect object #0x22) and hand (attack object #0x46): EXE6's
-- code (@exelib/grab_banish), EXE5's kinds; the hand's look EXE6's numbers, its hit EXE5's own (0x080CE31C's word
-- 0x1505FF01: a thrown attack that breaks, row 0x15, hitting navis; EXE6's row 0x19 pierces invisibility, which
-- EXE5's doesn't), the flash on each panel taken back (EXE5's effect 0x29, EXE6's 0x3B: the same) and its sound
-- EXE6's number.

local collision = require("../../rules/collision")
local common = require("@exelib/grab_banish/controller")
local hand = require("@exelib/grab_banish/hand")
local grab_shot_sprite = asset.sprite("grab_shot")

local hand_kind = hand.make_kind {
    id = "grab_banish/hand",
    sprite = grab_shot_sprite,
    fall_sound = asset.sound("grab_shot_2"),
    land_sound = asset.sound("grab_shot"),
    grab_steps = 16,
    target = collision.hits_navis,
    self_type = collision.thrown_break,
}

return common.make {
    id = "grab_banish/controller",
    hand = hand_kind,
    returned = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0, steps = 16 },
    return_sound = asset.sound("err_select_91"),
}
