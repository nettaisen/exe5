--!strict
-- The Japanese ROMs' lettering (`ROCKEXE5_TOBBRBJ`, Team of Blues; `ROCKEXE5_TOCBRKJ`, Team of Colonel): what a battle
-- shows in words in the Japanese games, where the US games show English (nettai-assets `lettering`;
-- docs/design/text-rendering.md §10), as EXE6's recipe has EXE6's.
--
-- - The fonts: the 8x16 font and the dialogue font with its advances, in the Japanese encoding (compat/text.toml's
--   [jp]).
-- - The HUD's text lines, in the Japanese font's glyphs.
-- - Banners: the ten whose words differ (ROCKMAN and BLUES for MegaMan and ProtoMan, the Program Advance's and the
--   others' katakana), each where it starts, and the banners' palette.
-- - "Cstmzing...": カスタム中…, seven tiles wide where the US's is eight.
-- - The custom gauge: the same tiles in the four ROMs; the pack's lettering has the Team ProtoMan US ROM's.
-- - The chip window's pictures for OK ("no data selected", "chip data transmission") and the re-deal button, with their
--   palettes; Arm Change's picture, which has no words, is the US ROM's.
-- - The soul button: "uni son" in two rows where the US's says "UNITE".
--
-- Everything else a battle shows is the same pictures in all four ROMs (the verification workspace's
-- tools/exe5/jpassets.py compares them: the HUD's and the custom screen's blocks, every chip's icon and picture, the
-- backgrounds a netbattle has, the sprites; and its frame comparison knows what a Japanese console shows otherwise:
-- background 0x05, the battle mode 1 label 14-17). Team of Blues' and Team of Colonel's lettering is the same: the
-- pack's is Team of Blues'. The same code reaches each block as in the US ROMs: hud.luau's and custom.luau's places.

local place = require("@exelib/extract/place")
local hud = require("./hud")
local custom = require("./custom")

local at = place.at

local lettering = {}

-- The pack's name for the Japanese ROMs' language.
lettering.LANGUAGE = "ja"

-- The Japanese ROMs' notice of the other player customizing: seven tiles wide, for the US ROMs' eight.
local WAITING_BYTES = 0x1C0

-- Whether two banners are one: their place, kind, glyphs and number's place.
local function same_banner(a: BannerLayout, b: BannerLayout): boolean
    local na, nb = a.number_at, b.number_at
    local numbers = if na == nil or nb == nil then na == nb else na[1] == nb[1] and na[2] == nb[2]
    return a.x == b.x and a.y == b.y and a.kind == b.kind and a.glyphs == b.glyphs and numbers
end

-- The HUD's Japanese lettering, from the Team of Blues ROM. `base` is the pack's own HUD: a banner whose glyphs are the
-- same is left to it, and one of another kind than the base's is an error.
function lettering.hud(set: Set, base: Hud, names: AssetNames): HudLettering
    local rom = set.BRBJ
    local gauge_tiles = gba.tiles(set.BRBE, at(set.BRBE, hud.GAUGE_TILES), hud.GAUGE_BYTES)
    local languages: { [string]: { glyphs: { string }?, dialogue_glyphs: { string }? } } = names.language_glyphs or {}
    local glyphs = languages[lettering.LANGUAGE]
    local cell: { string } = if glyphs and glyphs.glyphs then glyphs.glyphs else {}
    local dialogue: { string } = if glyphs and glyphs.dialogue_glyphs then glyphs.dialogue_glyphs else {}
    local own_banners = base.banners or {}
    local count = hud.BANNER_COUNT :: number
    if #own_banners ~= count then
        error(string.format("the HUD has %d banners, not %d", #own_banners, count), 0)
    end
    local banners: { [number]: BannerLayout, n: number } = { n = #own_banners }
    for i, own in own_banners do
        local id = i - 1
        local b = hud.banner(rom, id)
        local bg, og = b.glyphs, own.glyphs
        local same_glyphs = (if bg then bg:count() else 0) == (if og then og:count() else 0)
        local na, nb = b.number_at, own.number_at
        local same_number = if na == nil or nb == nil then na == nb else na[1] == nb[1] and na[2] == nb[2]
        if b.kind ~= own.kind or not same_number or not same_glyphs then
            error(string.format("the Japanese ROM's banner 0x%02x is another kind", 4 * id), 0)
        end
        if not same_banner(b, own) then
            banners[id] = b
        end
    end
    return {
        font = gba.tiles(rom, at(rom, hud.FONT), 0x40 * hud.FONT_GLYPHS),
        font_chars = hud.font_chars(cell),
        dialogue_font = hud.dialogue_font(rom, cell, dialogue),
        texts = hud.texts(rom),
        banners = banners,
        banner_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE)),
        waiting = gba.tiles(rom, at(rom, hud.WAITING), WAITING_BYTES),
        waiting_palette = hud.palette(rom, at(rom, hud.BANNER_PALETTE)),
        gauge_tiles = gauge_tiles,
    }
end

-- The custom screen's Japanese lettering, from the Team of Blues ROM: the chip window's worded pictures and the soul
-- button's label. (Arm Change's picture, which the lettering has too, has no words: the Team ProtoMan US ROM's.)
function lettering.custom(set: Set): CustomLettering
    local jp = set.BRBJ
    local ok = custom.picture(jp, custom.OK)
    local ok_picked = custom.picture(jp, custom.OK_PICKED)
    local other = custom.picture(jp, custom.OTHER)
    local arm_change = custom.picture(set.BRBE, custom.SCRAP)
    local redeal = custom.picture(jp, custom.REDEAL)
    local soul = custom.tiles(jp, custom.SOUL_BUTTONS)
    return {
        pictures = { ok = ok, ok_picked = ok_picked, other = other },
        buttons = {
            { name = custom.ARM_CHANGE_BUTTON, value = { picture = arm_change } },
            { name = custom.REDEAL_BUTTON, value = { picture = redeal } },
            { name = custom.SOUL_BUTTON, value = { tiles = soul } },
        },
    }
end

return lettering
