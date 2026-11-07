--!strict
-- FtrSword (EXE5 chip 0x172): a slash over the three panels ahead (VarSwrd's pick: no library chip): the shared slash
-- (@exelib/swords/slash, EXE5's action 0x13 subtype 9) with EXE5's parts (lib/swords), region 6 and its slash effect
-- 0x2E.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local regions = require("@exelib/regions")
local swords = require("../lib/swords")
local sword_slash_sprite = asset.sprite("sword-slash")

-- Its slash over three panels (effect 0x2E).
local LINE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 3, palette = 0, steps = 15 }

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
        hit = { region = regions.line, collision = swords.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = LINE_SLASH,
        sound = swords.swing,
    },
}

return { ftrsword = chip }
