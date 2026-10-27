--!strict
-- The meta-gel sprite: its animations, each its frames' durations in ticks.
return asset.sprite("meta-gel", {
    { 2 },
    { 3, 3, 2 },
    { 7, 6, 3, 5, 6, loop = true },
    { 2, 3, 2 },
})
