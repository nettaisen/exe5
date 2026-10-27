--!strict
-- The cactus sprite: its animations, each its frames' durations in ticks.
return asset.sprite("cactus", {
    { 9, 7, 6, 6, 6, 7, 9, 7, 6, 6, 6, 7, loop = true },
    { 2, 8 },
    { 1, 2, 20 },
    { 1 },
    { 4, 4, 4, loop = true },
    { 3, 3, loop = true },
})
