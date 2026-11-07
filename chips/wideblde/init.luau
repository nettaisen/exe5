--!strict
-- WideBlde (EXE5 chip 0x033): WideSwrd's slash, stronger: the shared slash (@exelib/swords/slash, the original's action
-- 0x13; EXE5's the same code) with EXE5's parts (lib/swords) and its slash effect 0x19.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local regions = require("@exelib/regions")
local swords = require("../lib/swords")
local sword_slash_sprite = asset.sprite("sword-slash")

-- Its slash over a column (effect 0x19: WideSwrd's in another palette).
local WIDE_BLADE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 5, steps = 15 }

local chip: Chip = {
    codes = { "A", "L", "V" },
    element = Element.null,
    family = Family.sword,
    class = "standard",
    rarity = 3,
    mb = 38,
    damage = 150,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = swords.slash {
        blade = swords.blade,
        blade_anim = swords.blade_anim,
        hit = { region = regions.wide, collision = swords.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = WIDE_BLADE_SLASH,
        sound = swords.swing,
    },
    auto_battle = { class = "into_reach", range = "column_ahead" },
}

return { wideblde = chip }
