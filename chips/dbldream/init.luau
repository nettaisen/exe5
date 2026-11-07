--!strict
-- DblDream (EXE5 chip 0x178): two big slashes over the column ahead and the next (NeoVari's pick: no library chip): the
-- shared slash (@exelib/swords/slash, EXE5's action 0x13 subtype 11) with EXE5's parts (lib/swords), region 0x11, hit
-- modifier 1, the big swing and LifeSrd's slash.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local regions = require("@exelib/regions")
local swords = require("../lib/swords")
local big_slash_sprite = asset.sprite("big-slash")

-- The big slash over two columns (effect 0x1B).
local BIG_SLASH = new.effect { sprite = big_slash_sprite, anim = 0, palette = 0, steps = 15 }

local chip: Chip = {
    codes = { "E", "L", "S", "*" },
    element = Element.null,
    family = Family.sword,
    class = "special",
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
        hit = { region = regions.wide_long, collision = swords.slashes_navis, hit_mod = { flinch = true } },
        effect = BIG_SLASH,
        sound = swords.big_swing,
        swings = 2,
    },
}

return { dbldream = chip }
