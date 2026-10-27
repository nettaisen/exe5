--!strict
-- The bomb sprite: its animations, each its frames' durations in ticks.
return asset.sprite("bomb", {
    { 3, 3, 3 },
    { 1 },
    { 3, 3, 3 },
    { 4, 4, 4, 4, 4, loop = true },
    { 3, 3, 3 },
    { 1 },
    { 3, 3, 3 },
    { 3, 3, 3, 3, loop = true },
    { 3, 3, 3 },
    { 3, 3, 3, 3, loop = true },
})
