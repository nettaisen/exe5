--!strict
-- Boxer1, Boxer2 and Boxer3: the boxer series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local boxer = require("@self/boxer")
local recipe_firehit1 = require("./fire_hit").fire_hit_1
local recipe_firehit2 = require("./fire_hit").fire_hit_2
local recipe_firehit3 = require("./fire_hit").fire_hit_3
local recipe_hotbody1 = require("./hot_body").hot_body_1
local recipe_hotbody2 = require("./hot_body").hot_body_2
local recipe_hotbody3 = require("./hot_body").hot_body_3

-- Boxer1 (EXE5 chip 0x146): the Program Advance of two HotBody1s and a FireHit1 (or three FireHit1s of one code): an
-- unseen boxer punches FireHit's fists down the rows, nine in all (chips/boxer/boxer, instant effect 21; the fists' hit
-- modifier 1, the record's +0x11).
local boxer_1: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 100,
    counter = 10,
    lockout = 20,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    -- EXE5's recipes (written by tools/exe5/recipes.py): in the order of its full table (0x08027FC8); the netbattles'
    -- table (0x0802801C) is that table but for its first 21, which only a battle with each side keeping its own
    -- gauge tries.
    program_advances = {
        { order = 9, sequence = { recipe_hotbody1, recipe_hotbody1, recipe_firehit1 }, operation_battle_only = true },
        { order = 45, code_run = { chip = recipe_firehit1, count = 3 } },
    },
    instant = boxer.instant({ flinch = true }),
    auto_battle = { class = "at_once" },
}

-- Boxer2 (EXE5 chip 0x147): the Program Advance of two HotBody2s and a FireHit2 (or three FireHit2s of one code): an
-- unseen boxer punches FireHit's fists down the rows, nine in all (chips/boxer/boxer, instant effect 21; the fists' hit
-- modifier 1, the record's +0x11).
local boxer_2: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 150,
    counter = 10,
    lockout = 20,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    -- EXE5's recipes (written by tools/exe5/recipes.py): in the order of its full table (0x08027FC8); the netbattles'
    -- table (0x0802801C) is that table but for its first 21, which only a battle with each side keeping its own
    -- gauge tries.
    program_advances = {
        { order = 10, sequence = { recipe_hotbody2, recipe_hotbody2, recipe_firehit2 }, operation_battle_only = true },
        { order = 46, code_run = { chip = recipe_firehit2, count = 3 } },
    },
    instant = boxer.instant({ flinch = true }),
    auto_battle = { class = "at_once" },
}

-- Boxer3 (EXE5 chip 0x148): the Program Advance of two HotBody3s and a FireHit3 (or three FireHit3s of one code): an
-- unseen boxer punches FireHit's fists down the rows, nine in all (chips/boxer/boxer, instant effect 21; the fists' hit
-- modifier 1, the record's +0x11).
local boxer_3: Chip = {
    codes = { "A", "B", "C", "*" },
    element = Element.fire,
    family = Family.program_advance,
    class = ChipClass.program_advance,
    rarity = 0,
    mb = 5,
    damage = 200,
    counter = 10,
    lockout = 20,
    flags = { has_damage = true, library = true },
    slot_in_limit = 1,
    -- EXE5's recipes (written by tools/exe5/recipes.py): in the order of its full table (0x08027FC8); the netbattles'
    -- table (0x0802801C) is that table but for its first 21, which only a battle with each side keeping its own
    -- gauge tries.
    program_advances = {
        { order = 11, sequence = { recipe_hotbody3, recipe_hotbody3, recipe_firehit3 }, operation_battle_only = true },
        { order = 47, code_run = { chip = recipe_firehit3, count = 3 } },
    },
    instant = boxer.instant({ flinch = true }),
    auto_battle = { class = "at_once" },
}

return { boxer_1 = boxer_1, boxer_2 = boxer_2, boxer_3 = boxer_3 }
