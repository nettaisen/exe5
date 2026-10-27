--!strict
-- The django-sun sprite: its animations, each its frames' durations in ticks.
return asset.sprite("django-sun", {
    { 1, 1, 1, 1, 1 },
    { 2, 2, 2, loop = true },
    { 1, 2, 1, 2, 1, 2, loop = true },
})
