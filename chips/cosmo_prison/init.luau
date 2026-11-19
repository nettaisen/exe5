--!strict
-- CsmoPris (EXE5 chip 0x157): the Program Advance of two Astroid3s and CosmoMnSP or CosmoMnDS: CosmoMan cuts in, rises
-- over the middle row and sends nine comets along the rows that turn toward the enemy navi (./cosmo_prison, the summon
-- table's entry 22).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local cosmo_prison = require("@self/cosmo_prison")
local navi_chips = require("../lib/navi_chips/chip")
local recipe_astroid3 = require("./asteroid").asteroid_3
local recipe_cosmomn_ds = require("./cosmoman").cosmoman_ds
local recipe_cosmomn_sp = require("./cosmoman").cosmoman_sp

local chip: Chip = {
    codes = {},
    element = Element.null,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 60,
    counter = 5,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, library = true },
    slot_in_limit = 1,
    -- EXE5's recipes (written by tools/exe5/recipes.py): in the order of its full table (0x08027FC8); the netbattles'
    -- table (0x0802801C) is that table but for its first 21, which only a battle with each side keeping its own
    -- gauge tries.
    program_advances = {
        { order = 26, sequence = { recipe_astroid3, recipe_astroid3, recipe_cosmomn_sp } },
        { order = 27, sequence = { recipe_astroid3, recipe_astroid3, recipe_cosmomn_ds } },
    },
    navi = navi_chips.make {
        id = "cosmo_prison/controller",
        summon = cosmo_prison.summon,
    },
    auto_battle = { class = "at_once" },
}

return { cosmo_prison = chip }
