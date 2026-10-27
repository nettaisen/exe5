--!strict
-- The bug-charger sprite: its animations, each its frames' durations in ticks.
return asset.sprite("bug-charger", {
    { 3, 3, loop = true },
    { 2, 3, 2 },
    { 3, 3, loop = true },
})
