--!strict
-- EXE5's hit sparks: what shows where a hit lands (`collision:set_hit_effect`). EXE5's spark table (0x080E0814,
-- rows 0 to 0xD) has EXE6's rows (`off_80E0804`: sprite, animation, palette) with EXE5's sprites; EXE5's hit sparks
-- (14-05) last a frame longer than EXE6's, and a spark goes when its animation ends, so EXE5's hits show EXE5's
-- (an EXE6 module that sets a spark takes a game's: chips/thunder's look).

local sparks = {}

local HIT_SPARKS = asset.sprite("hit-sparks")
local chip_destruction_spark_sprite = asset.sprite("chip-destruction-spark")
local explosion_sprite = asset.sprite("explosion")
local hit_marker_sprite = asset.sprite("hit-marker")
local hit_sprite = asset.sprite("hit")
local impact_sprite = asset.sprite("impact")
local pink_flash_sprite = asset.sprite("pink-flash")

-- By primary element (null, fire, aqua, elec, wood, and the drain): the spark the element routine (EXE6's `sub_801A146`, EXE5's
-- the same code) gives an attack of that element (hit effects 0 to 5).
local BY_ELEMENT: { [PrimaryElement]: Spark } = {
    null = new.spark { sprite = HIT_SPARKS, anim = 0, palette = 0, steps = 5 },
    fire = new.spark { sprite = HIT_SPARKS, anim = 2, palette = 0, steps = 18 },
    aqua = new.spark { sprite = HIT_SPARKS, anim = 3, palette = 0, steps = 14 },
    elec = new.spark { sprite = HIT_SPARKS, anim = 4, palette = 0, steps = 14 },
    wood = new.spark { sprite = HIT_SPARKS, anim = 5, palette = 0, steps = 16 },
    drain = new.spark { sprite = pink_flash_sprite, anim = 0, palette = 0, steps = 10 },
}

-- The plain hit (spark 0) and the charged shot's (5).
sparks.plain = BY_ELEMENT.null
sparks.charged = BY_ELEMENT.drain
-- The element sparks by name (hit effects 1 to 4), for hits that name theirs.
sparks.fire, sparks.aqua, sparks.elec, sparks.wood = BY_ELEMENT.fire, BY_ELEMENT.aqua, BY_ELEMENT.elec, BY_ELEMENT.wood
-- A heavy hit's (6).
sparks.heavy = new.spark { sprite = HIT_SPARKS, anim = 8, palette = 0, steps = 5 }
-- A cannon's impact (7).
sparks.impact = new.spark { sprite = impact_sprite, anim = 0, palette = 0, steps = 19 }
-- A guarded hit's (8).
sparks.guard = new.spark { sprite = hit_sprite, anim = 0, palette = 0, steps = 9 }
-- The chip destruction hit spark (9).
sparks.chip_destruction = new.spark { sprite = chip_destruction_spark_sprite, anim = 0, palette = 0, steps = 15 }
-- A breaking hit (0x0A).
sparks.breaking = new.spark { sprite = HIT_SPARKS, anim = 1, palette = 0, steps = 10 }
-- A blast (0x0B).
sparks.blast = new.spark { sprite = explosion_sprite, anim = 0, palette = 0, steps = 22 }
-- The erase beams' (0x0C).
sparks.erase = new.spark { sprite = pink_flash_sprite, anim = 0, palette = 2, steps = 10 }
-- A bat's impact (0x0D).
sparks.bat = new.spark { sprite = hit_marker_sprite, anim = 1, palette = 0, steps = 18 }

-- The element routine: the spark of an attack of `element` (its primary element, the low nibble).
function sparks.of_element(element: Element): Spark
    local p = element.primary
    local s = if p then BY_ELEMENT[p] else nil
    if not s then
        error(string.format("the element spark routine: element %s has no hit spark", tostring(element)))
    end
    return s
end

return sparks
