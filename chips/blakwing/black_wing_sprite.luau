--!strict
-- The black-wing sprite: its animations, each its frames' durations in ticks.
return asset.sprite("black-wing", {
    { 1, 2, 2, 3, 3, 1 },
    { 1 },
    { 1, 1, 1, 1, 1, 1 },
    { 2, 3, 2, 3, loop = true },
})
