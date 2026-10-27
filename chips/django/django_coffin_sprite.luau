--!strict
-- The django-coffin sprite: its animations, each its frames' durations in ticks.
return asset.sprite("django-coffin", {
    { 2, 2, 2 },
    { 2 },
    { 3, 2, loop = true },
})
