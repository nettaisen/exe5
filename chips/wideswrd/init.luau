--!strict
-- WideSwrd (EXE5 chip 0x031): a slash over the column ahead: the shared slash (@exelib/swords/slash) with EXE5's parts
-- (lib/swords).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local regions = require("@exelib/regions")
local swords = require("../lib/swords")
local sword_slash_sprite = asset.sprite("sword-slash")

-- The slash over a column (effect 0x16).
local WIDE_SLASH = new.effect { sprite = sword_slash_sprite, anim = 0, palette = 0, steps = 15 }

local chip: Chip = {
    codes = { "K", "S", "Z" },
    element = "null",
    family = "sword",
    class = ChipClass.standard,
    rarity = 1,
    mb = 16,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = swords.slash {
        blade = swords.blade,
        blade_anim = swords.blade_anim,
        hit = { region = regions.wide, collision = swords.slashes_navis, hit_mod = { flinch = true, flash = true } },
        effect = WIDE_SLASH,
        sound = swords.swing,
    },
    auto_battle = { class = "into_reach", range = "column_ahead" },
}

return { wideswrd = chip }
