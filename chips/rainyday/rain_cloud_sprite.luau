--!strict
-- The rain-cloud sprite: its animations, each its frames' durations in ticks.
return asset.sprite("rain-cloud", {
    { 6, 6, 6, 6, 4 },
    { 7, 7, 7, 7, loop = true },
    { 4, 4, 18 },
})
