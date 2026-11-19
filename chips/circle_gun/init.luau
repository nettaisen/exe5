--!strict
-- CircGun (EXE5 chip 0x061): a gun sight circles the enemy's area until A or 360 ticks, then leaves four shots on the
-- panels it passes: EXE5's CircGun (chips/circle_gun/circle_gun: the shared CircGun with EXE5's look, DarkCirc's kinds) of its
-- variant: period 2, 4 shots, look 0.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local circle_gun = require("@self/circle_gun")
local collision = require("../rules/collision")

local chip: Chip = {
    codes = { "A", "C", "F" },
    element = Element.null,
    family = Family.cursor,
    class = ChipClass.standard,
    rarity = 2,
    mb = 50,
    damage = 100,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    dimming = circle_gun.hook(circle_gun.variant { period = 2, shots = 4, palette = 0, hit = collision.thrown }),
    auto_battle = { class = "at_once" },
}

return { circle_gun = chip }
