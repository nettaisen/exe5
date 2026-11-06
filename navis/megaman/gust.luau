--!strict
-- EXE5's gust (attack object #0x49, 0x080CEA0C): the shared gust (@exelib/gust/gust, EXE6's code) in EXE6's look (sheet
-- 0c-2e, EXE6's), but that no hit stops it (0x080CEB30 tests its hit flags against 0: EXE6's wind stoppers don't), an
-- unseen one pushes weaker too (0x080CEAA6: any first parameter), and its panel table's side 2 reads other code.
-- The patch cards' Vacuum blows three (navis/megaman/weapons/instants).

local collision = require("../../rules/collision")
local common = require("@exelib/gust")
local gust_sprite = asset.sprite("gust")

local gust = {}

gust.kind = common.make_kind("gust", {
    sprite = gust_sprite,
    is = collision.pull,
    hits = collision.hits_navis,
    stopped_by = nil,
    weak_when_unseen = true,
    -- The panels it can blow over (0x080CEB94, by side: the other side's area; its third row, read for a side of 2,
    -- is code: require 0xB427B500, forbid 0xF7342049).
    panels = { require = "enemy_area" },
})

-- 0x080CEBA4: a gust on (x, y) for side `alliance` and flip `flip`, blowing as `how` says, with the damage word
-- `damage`, and the spawner that tracks it by `holder.state.gusts[slot]`, if any.
function gust.spawn(
    x: number,
    y: number,
    alliance: number,
    flip: number,
    how: GustHow,
    damage: number,
    holder: Object?,
    slot: number
): Object?
    return common.spawn(gust.kind, x, y, alliance, flip, how, damage, holder, slot)
end

return gust
