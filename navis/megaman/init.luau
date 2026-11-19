--!strict
-- EXE5's MegaMan (navi 0, NameID 0x180), from EXE5's tables: his battle sprite (08-00, 0x0800DA65 by navi), his
-- element (0x0800E634), his buster bonus (0x0800F5AC), his move lag (4 after a move, `sub_8010332`'s
-- counterpart 0x0800E0BE: MegaMan's isn't by variant), his netbattle banners (0x080090D8, 0x080090B0), his
-- weapons (weapons/: the buster and the charged shot, EXE6's actions with EXE5's setups), and his identity: his
-- actor record (0x08014C94: version 0, a player, AI index 0) and his sprite's 30 attach points (./attach_points). EXE5 has no weakness table (EXE6's `byte_80108D1`).
-- On sea, his Aqua chips with damage (dimming chips too) hit 30 harder and spend the sea under him, unless his soul
-- gives a bonus of its own (0x0800D0A6: NumberSoul's, NapalmSoul's; the panel turns Normal at 0x080100B0).
--
-- Not yet (docs/design/exe5-map.md §15.7): the held offset.

local attach_points = require("@self/attach_points")
local buster = require("@self/weapons/buster")
local charged_shot = require("@self/weapons/charged_shot")
local colonel_soul = require("@self/forms/colonel_soul").colonel_soul
local gyro_soul = require("@self/forms/gyro_soul").gyro_soul
local knight_soul = require("@self/forms/knight_soul").knight_soul
local magnet_soul = require("@self/forms/magnet_soul").magnet_soul
local meddy_soul = require("@self/forms/meddy_soul").meddy_soul
local napalm_soul = require("@self/forms/napalm_soul").napalm_soul
local number_soul = require("@self/forms/number_soul").number_soul
local proto_soul = require("@self/forms/proto_soul").proto_soul
local search_soul = require("@self/forms/search_soul").search_soul
local shadow_soul = require("@self/forms/shadow_soul").shadow_soul
local toad_soul = require("@self/forms/toad_soul").toad_soul
local tomahawk_soul = require("@self/forms/tomahawk_soul").tomahawk_soul
local megaman_navi_sprite = asset.sprite("megaman_navi")
local megaman_portrait_sprite = asset.sprite("megaman_portrait")

local navi: NaviDef = {
    sprite = megaman_navi_sprite,
    -- How many steps of the sprite he is drawn with (his form's; every soul's alike) his warp out (animation 4) lasts.
    animation_steps = { warp_out = 4 },
    element = Element.null,
    buster_bonus = 1,
    move_lag = { 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4 },
    banners = { win = asset.banner("megaman_win"), lose = asset.banner("megaman_deleted") },
    -- The no-running message's portrait: the speaker beside the box (L on the custom screen, 0x08023190: the run
    -- dialog's script 3, past its navi check). Its words are locales/<lang>.toml's; the content's own (en) time it.
    run_message = {
        portrait = megaman_portrait_sprite,
    },
    weapons = { buster = buster.weapon, charge_shot = charged_shot.weapon },
    panel_bonus = { panel = PanelType.sea, family = Family.aqua, damage = 30 },
    -- His fresh stats, as a navi's stats start (0x080111BA from the table 0x0801D55F: his row, EXE6's):
    -- the stats a match's side starts him at.
    fresh = { hp = 100, mega_level = 5, giga_level = 1 },
    -- His souls, which the custom screen's soul button offers (rules/souls): the set `souls`, its `form_list` in the
    -- original's order of the navis he unites with (0x0873BBC8's names: compat's records.toml has each form's number):
    -- the order of the soul button's icons in a pack, where a frontend finds a soul's icon by its place here, and the
    -- place the round's souls given are counted by (rules/souls/custom's `used_bit`).
    forms = {
        souls = {
            form_list = {
                proto_soul,
                gyro_soul,
                search_soul,
                napalm_soul,
                magnet_soul,
                meddy_soul,
                colonel_soul,
                shadow_soul,
                number_soul,
                tomahawk_soul,
                knight_soul,
                toad_soul,
            },
        },
    },
    -- His post-init hook (0x080EB2A8's row 0, 0x080F04EE): in a soul (NaviStats +0x2C not 0), the status reset again
    -- (0x08011B20, EXE6's `sub_80144C0`). (His init has put him in his base form by then: it never runs.)
    post_init = function(navi: Object)
        if not battle.navi(navi.alliance).form.base then
            navi:reset_status()
        end
    end,
    identity = new.identity {
        class = IdentityClass.player,
        changes_form = true,
        version = 0,
        actor_type = ActorType.player,
        ai_index = 0,
        -- The Full Synchro aura's animation: its owner's AI index (the aura's start, 0x080C4608).
        aura_anim = 0,
        -- He wears what his soul does: his death hook takes it off (0x0800EFCC, his record's category 2), and an
        -- animation change (0x0800F11C by AI index 0), a flinch and a drag (0x080F0500) restart it.
        overlay_hooks = { death = true, refresh = true, flinch = true, drag = true },
        attach_points = attach_points,
    },
}

return { megaman = navi }
