--!strict
-- CrosSwrd (EXE5 chip 0x176): a slash over the X ahead and one over the panel ahead (NeoVari's pick: no library
-- chip): the shared slash (@exelib/swords/slash, EXE5's action 0x13 subtype 10) with EXE5's parts (lib/swords), regions
-- 0x0B and 1 and the effect table's row 0x37.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local regions = require("@exelib/regions")
local swords = require("../lib/swords")
local cross_slash_sprite = asset.sprite("cross-slash")

local chip: Chip = {
    codes = { "E", "L", "S", "*" },
    element = Element.null,
    family = Family.sword,
    class = ChipClass.special,
    rarity = 0,
    mb = 8,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    action = swords.slash {
        blade = swords.blade,
        blade_anim = swords.blade_anim,
        hit = { region = regions.x, collision = swords.slashes_navis, hit_mod = { flinch = true, flash = true } },
        second_hit = { region = regions.single, collision = swords.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = new.effect { sprite = cross_slash_sprite, anim = 0, palette = 1, steps = 10 },
        sound = swords.swing,
    },
}

return { crosswrd = chip }
