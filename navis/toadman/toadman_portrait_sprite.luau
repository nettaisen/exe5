--!strict
-- The toadman-portrait sprite: its animations, each its frames' durations in ticks.
return asset.sprite("toadman-portrait", {
    { 6 },
    { 40, 1, 5, 2, 100, 1, 5, 2, loop = true },
    { 6, 5, 5, 5, 6, 5, 5, 5, 3, 3, 3, 3, loop = true },
})
