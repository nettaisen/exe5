--!strict
-- The pile-driver sprite: its animations, each its frames' durations in ticks.
return asset.sprite("pile-driver", {
    { 2, 3, 2 },
    { 2 },
    { 3, 2, loop = true },
    { 2, 3, 2 },
})
