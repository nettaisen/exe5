--!strict
-- The NaviCust program SoulT+1 (program 38), in white, pink, yellow.

local programs = require("../rules/navicust/programs")

local program: NaviCustProgram = {
    colors = { "white", "pink", "yellow" },
    plus = true,
    shape = {
        ".......",
        ".......",
        "...##..",
        "...##..",
        ".......",
        ".......",
        ".......",
    },
    bug = "emotion",
    effects = { programs.soul_time(1) },
}

return { soul_time_1 = program }
