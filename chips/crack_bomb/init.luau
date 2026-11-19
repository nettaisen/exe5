--!strict
-- CrakBom (EXE5 chip 0x026): a bomb thrown three panels ahead that hits the column where it lands and cracks it: EXE5's
-- throw (lib/bombs, action 0x12 subtype 10, the bomb held in animation 6) and its bomb (chips/crack_bomb/crack_bomb, attack
-- object #0x24) of kind 1.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bombs = require("../lib/bombs")
local crack_bomb = require("@self/crack_bomb")

-- Its bomb (kind 1): the burst in palette 1, a crack's sound, hit modifier 3, cracking the column.
local BOMB = crack_bomb.variant {
    burst = new.effect { sprite = crack_bomb.burst, anim = 0, palette = 1, steps = 18 },
    sound = asset.sound("panel_crack"),
    hit_mod = { flinch = true, flash = true },
    bug = 0,
    cracks = true,
}

local chip: Chip = {
    codes = { "C", "R", "V", "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 18,
    damage = 80,
    counter = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = bombs.throw { held = bombs.held, held_anim = 6, thrower = crack_bomb.thrower(BOMB) },
    auto_battle = { class = "into_reach", range = "column_three_ahead" },
}

return { crack_bomb = chip }
