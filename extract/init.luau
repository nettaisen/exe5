--!strict
-- EXE5's extraction recipe (docs/design/extraction-recipes.md): how its pack's assets are extracted from a complete
-- Legacy Collection's four ROMs (the manifest's [extract]). It reads the ROMs through the primitives
-- (content/nettai/extract.d.luau) and returns the asset model; the extractor makes the pack.
--
-- What an EXE5 pack has: the battle sprites, the field (panels, edges, cycling palettes), the battle backgrounds, the
-- chips' pictures and icons; the HUD (its fonts, banners, faces and the chatbox) and the custom screen, in EXE6's
-- formats with what EXE5 lays out otherwise said (the custom screen's layout, the faces' own boxes, the soul button).
-- What the four ROMs have alike is read from the Team ProtoMan US ROM (BRBE), a version's own from its US ROM
-- (versions.luau), the Japanese words from the Team of Blues ROM (lettering.luau).

local names = require("@self/names")
local versions = require("@self/versions")
local chips = require("@self/chips")
local hud = require("@self/hud")
local custom = require("@self/custom")
local lettering = require("@self/lettering")
local sprites = require("@self/sprites")
local stage = require("@self/stage")

return function(set: Set): Extracted
    local n = names()
    local h = hud.hud(set, n, chips.icons(set, n))
    local c = custom.custom(set, n, chips.art(set, n))
    -- The US ROMs' words are English; the Japanese ROMs' lettering is the pack's Japanese.
    h.languages = { { name = lettering.LANGUAGE, value = lettering.hud(set, h, n) } }
    h.language = "en"
    c.languages = { { name = lettering.LANGUAGE, value = lettering.custom(set) } }
    local backgrounds = stage.backgrounds(set.BRBE)
    return {
        names = n,
        graphics = {
            sprites = sprites.sprites(set, n),
            field = stage.field(set.BRBE),
            backgrounds = backgrounds,
            hud = h,
            custom = c,
        },
        -- The Team ProtoMan US ROM's sound bank (EXE5's hit, song 0x6D, is louder in the Japanese ROMs, volume 127
        -- for 112), with the songs Team Colonel's plays otherwise as its own.
        sound = {
            from = set.BRBE,
            base_version = versions.PROTOMAN,
            versions = { { name = versions.COLONEL, from = set.BRKE } },
        },
    }
end
