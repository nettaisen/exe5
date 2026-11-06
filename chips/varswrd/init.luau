--!strict
-- VarSwrd (EXE5 chip 0x037): the navi holds A and enters a direction sequence: a quarter circle forward (down,
-- down-forward, forward) gives LongSwrd, a half circle from back FtrSword, up-forward-down WideSwrd,
-- down-back-up-forward-down LifeSrd, and back, A+B, forward, A+B SonicBom; letting go of A, or 48 ticks, gives a
-- Sword: EXE5's action 0x2A (action.luau).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local action = require("@self/action")
local ftrsword = require("./ftrsword").ftrsword
local lifesrd = require("./lifesrd").lifesrd
local longswrd = require("./longswrd").longswrd
local sonicbom = require("./sonicbom").sonicbom
local sword = require("./sword").sword
local wideswrd = require("./wideswrd").wideswrd

local chip: Chip = {
    codes = { "B", "C", "V" },
    element = "null",
    family = "sword",
    class = "standard",
    rarity = 3,
    mb = 60,
    damage = 160,
    hit_param = 30,
    lockout = 0,
    flags = { has_damage = true, standard_library = true, library = true },
    slot_in_limit = 3,
    action = action.action {
        -- The sequences (0x080ED4E4, joypad words each ending in 0), not turned (facing right on side 0) and turned,
        -- each step the buttons held, A among them.
        sequences = {
            unturned = {
                { { a = true, down = true }, { a = true, right = true, down = true }, { a = true, right = true } },
                { { a = true, left = true }, { a = true, left = true, down = true }, { a = true, down = true }, { a = true, right = true, down = true }, { a = true, right = true } },
                { { a = true, up = true }, { a = true, right = true }, { a = true, down = true } },
                { { a = true, down = true }, { a = true, left = true }, { a = true, up = true }, { a = true, right = true }, { a = true, down = true } },
                { { a = true, left = true }, { a = true, b = true }, { a = true, right = true }, { a = true, b = true } },
            },
            turned = {
                { { a = true, down = true }, { a = true, left = true, down = true }, { a = true, left = true } },
                { { a = true, right = true }, { a = true, right = true, down = true }, { a = true, down = true }, { a = true, left = true, down = true }, { a = true, left = true } },
                { { a = true, up = true }, { a = true, left = true }, { a = true, down = true } },
                { { a = true, down = true }, { a = true, right = true }, { a = true, up = true }, { a = true, left = true }, { a = true, down = true } },
                { { a = true, right = true }, { a = true, b = true }, { a = true, left = true }, { a = true, b = true } },
            },
        },
        -- LongSwrd, FtrSword, WideSwrd, LifeSrd, SonicBom (0x080ED618); a Sword (chip 0x30).
        picks = { longswrd, ftrsword, wideswrd, lifesrd, sonicbom },
        sword = sword,
    },
    auto_battle = { class = "sword_swing", swings = { "two_in_row", "three_in_row", "column_ahead", "two_columns_ahead", "all_ahead", "one_ahead" } },
}

return { varswrd = chip }
