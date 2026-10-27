--!strict
-- The colonel-soldier sprite: its animations, each its frames' durations in ticks.
return asset.sprite("colonel-soldier", {
    { 3, 2 },
    { 8, 8, 8, 8, loop = true },
    { 6, 3, 3, 3 },
    { 3, 2 },
    { 8, 8, 8, 8, loop = true },
    { 2, 2, 2, loop = true },
})
