--!strict
-- The side-bubble sprite: its animations, each its frames' durations in ticks.
return asset.sprite("side-bubble", {
    { 8, 8, loop = true },
    { 8, 3, 3, 3 },
    { 3 },
    { 5, 5 },
})
