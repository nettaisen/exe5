--!strict
-- The names EXE5's pack's assets are written under (docs/design/extraction-recipes.md §4.3), from compat: assets.toml
-- by number (a background of several numbers under its first: the others are the same, stage.luau's check), a chip's
-- icon and picture by its key in chips.toml (`cannon`), a navi's emblem by its key in records.toml's [navis]
-- (`searchman`), what each glyph of the fonts draws (text.toml; the Japanese ROMs' encoding is the pack's Japanese
-- lettering's). The numbers each name belongs to are checked as the compat crate checks them.

local names = require("@exelib/extract/names")

-- The language of the Japanese ROMs' words, as the pack names its lettering.
local JAPANESE = "ja"

-- A background's numbers (assets.toml: one, or a list of the numbers that are one background), the first first.
local function numbers(v: any): { number }
    return if type(v) == "number" then { v } else v
end

return function(): AssetNames
    local assets = data("compat/assets.toml")
    local chips = data("compat/chips.toml")
    local records = data("compat/records.toml")
    local text = data("compat/text.toml")
    -- One chip a number, as the compat crate reads chips.toml (and says it: the later key first).
    names.unique("chips.toml", chips, function(c: any): number
        return c.id
    end, function(earlier: string, later: string, n: number): string
        return string.format("chips.toml: %s and %s are both chip 0x%03x", later, earlier, n)
    end)
    local chip_keys: { [number]: string } = {}
    for _, key in names.sorted(chips) do
        chip_keys[chips[key].id] = names.key(key)
    end
    -- Every background has a number, and a number is one background's.
    local backgrounds = assets.backgrounds or {}
    local background_of: { [number]: string } = {}
    local first: { [number]: string } = {}
    for _, name in names.sorted(backgrounds) do
        local all = numbers(backgrounds[name])
        if #all == 0 then
            error(string.format("assets.toml: background %s has no number", name), 0)
        end
        for _, n in all do
            local other = background_of[n]
            if other ~= nil then
                error(string.format("assets.toml: backgrounds %s and %s are both 0x%02x", name, other, n), 0)
            end
            background_of[n] = name
        end
        first[all[1]] = name
    end
    local navi_keys: { [number]: string } = {}
    local navis = records.navis or {}
    for _, key in names.sorted(navis) do
        navi_keys[navis[key]] = names.key(key)
    end
    local jp = text.jp or {}
    return {
        sprites = names.sprites(assets.sprites or {}),
        songs = names.by_number(assets.sounds or {}),
        banners = names.by_number(assets.banners or {}),
        backgrounds = first,
        mugshots = names.by_number(assets.mugshots or {}),
        chips = chip_keys,
        navis = navi_keys,
        glyphs = text.glyphs,
        dialogue_glyphs = text.dialogue_glyphs or {},
        language_glyphs = { [JAPANESE] = { glyphs = jp.glyphs or {}, dialogue_glyphs = jp.dialogue_glyphs or {} } },
    }
end
