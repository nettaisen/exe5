--!strict
-- The NaviCust program SprArmr (program 1), in red.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "red" },
    shape = {
        ".......",
        ".......",
        "...#...",
        "..###..",
        "...#...",
        ".......",
        ".......",
    },
    compressed = {
        ".......",
        ".......",
        "...#...",
        "...##..",
        "...#...",
        ".......",
        ".......",
    },
    bug = "step",
    exclusive = "super_armor",
    effects = { programs.super_armor() },
}

return { super_armor = program }
