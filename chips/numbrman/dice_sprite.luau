--!strict
-- The dice sprite: its animations, each its frames' durations in ticks.
return asset.sprite("dice", {
    { 3 },
    { 1 },
    { 1 },
    { 1 },
    { 1 },
    { 1 },
    { 2, 2, 2, 2, loop = true },
    { 1 },
})
