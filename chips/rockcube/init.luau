--!strict
-- RockCube (EXE5 chip 0x063): a dimming that sets a rock cube rising on the panel in front of the user (./cube, the
-- dimming handler's subtype 20).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local cube = require("@self/cube")
local rock = require("../objects/rock")

local chip: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.summon,
    class = "standard",
    rarity = 0,
    mb = 6,
    damage = 200,
    counter = 30,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    dimming = cube.places { variant = rock.variants.cube },
    auto_battle = { class = "landing_ahead" },
}

return { rockcube = chip }
