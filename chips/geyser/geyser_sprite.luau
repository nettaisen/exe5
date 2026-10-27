--!strict
-- The geyser sprite: its animations, each its frames' durations in ticks.
return asset.sprite("geyser", {
    { 3, 3, 3, 2 },
    { 2, 2, 2, loop = true },
    { 3, 2, 2, 2 },
})
