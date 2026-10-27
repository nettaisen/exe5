--!strict
-- The immobilized sprite: its animations, each its frames' durations in ticks.
return asset.sprite("immobilized", {
    { 3, 3 },
    { 3, 3, 3, loop = true },
    { 3, 3 },
})
