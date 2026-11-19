--!strict
-- BodyGrd (EXE5 chip 0x15c): the Program Advance of AntiDmg, AntiNavi and Muramasa: an unseen striker drops ten
-- shurikens on the enemy navi, one every 20 ticks (./body_guard: EXE5's controller sends out EXE6's striker at once,
-- where EXE6's BodyGrd is a trap).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local body_guard = require("@self/body_guard")
local recipe_antidmg = require("./anti_damage").anti_damage
local recipe_antinavi = require("./anti_navi").anti_navi
local recipe_muramasa = require("./muramasa_blade").muramasa_blade

local chip: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 70,
    counter = 5,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    -- EXE5's recipes (written by tools/exe5/recipes.py): in the order of its full table (0x08027FC8); the netbattles'
    -- table (0x0802801C) is that table but for its first 21, which only a battle with each side keeping its own
    -- gauge tries.
    program_advances = {
        { order = 25, sequence = { recipe_antidmg, recipe_antinavi, recipe_muramasa } },
    },
    dimming = body_guard.hook(0),
    auto_battle = { class = "at_once" },
}

return { body_guard = chip }
