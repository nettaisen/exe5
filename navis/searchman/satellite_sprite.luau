--!strict
-- The satellite sprite: its animations, each its frames' durations in ticks.
return asset.sprite("satellite", {
    { 3, 3, 2 },
    { 2, 2, loop = true },
    { 3 },
    { 3, 3, loop = true },
})
