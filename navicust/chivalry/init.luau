--!strict
-- The NaviCust program Chivalry (program 22), in blue.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "blue" },
    shape = {
        ".......",
        ".......",
        "..#.#..",
        "..###..",
        ".......",
        ".......",
        ".......",
    },
    compressed = {
        ".......",
        ".......",
        "..#....",
        "..###..",
        ".......",
        ".......",
        ".......",
    },
    bug = "emotion",
    exclusive = "l_button",
    effects = { programs.outside("chivalry") },
}

return { chivalry = program }
