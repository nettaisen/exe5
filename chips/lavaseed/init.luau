--!strict
-- LavaSeed (EXE5 chip 0x02b): a seed thrown three panels ahead that turns the panels around where it lands to lava
-- (only its own if it hit something): EXE5's throw (lib/bombs, action 0x12) and its seed (lib/bombs/seed, attack object
-- #0x4A).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bombs = require("../lib/bombs")
local seed = require("../lib/bombs/seed")
local grab_shot_sprite = asset.sprite("grab-shot")

-- Its seed (Param1 3): lava, the sprout (effect 0x55) and its sound.
local SEED = seed.variant {
    element = Element.null,
    palette = 3,
    panel = "lava",
    effect = new.effect { sprite = grab_shot_sprite, anim = 1, palette = 0xC, steps = 16 },
    sound = asset.sound("panel-volcano"),
}

local chip: Chip = {
    codes = { "H", "K", "P" },
    element = "null",
    family = "null",
    class = ChipClass.standard,
    rarity = 1,
    mb = 60,
    damage = 10,
    counter = 10,
    lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    action = bombs.throw {
        held = seed.held(SEED),
        held_anim = 8,
        thrower = seed.thrower(SEED),
    },
    auto_battle = { class = "into_reach", range = "columns_two_to_four" },
}

return { lavaseed = chip }
