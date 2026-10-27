--!strict
-- The gridman sprite: its animations, each its frames' durations in ticks.
return asset.sprite("gridman", {
    { 2 },
    { 2 },
    { 2 },
    { 2, 1 },
    { 1, 2 },
    { 1, 10 },
    { 2 },
    { 2 },
    { 1, 10 },
    { 2 },
    { 8, 3, 3, 8 },
    { 1, 8, 3, 10, 3 },
    { 6, 6, loop = true },
    { 2 },
    { 2 },
    { 2 },
    { 5, 8, 5 },
    { 3, 3, 4, 4 },
})
