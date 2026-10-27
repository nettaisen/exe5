--!strict
-- The frog sprite: its animations, each its frames' durations in ticks.
return asset.sprite("frog", {
    { 2 },
    { 1, 4, 3 },
    { 2 },
    { 3, 3, 3 },
    { 2, 2, 2 },
    { 3, 3, loop = true },
})
