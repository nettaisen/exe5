--!strict
-- EXE5's panels (docs/design/exe5-map.md §15.2): its 11 panel types (0x0800BCF0) are EXE6's but for magnet (type 5,
-- EXE6's road flags, a plate's look), lava (type 8, the volcano's flags and sound but its own behavior) and sea
-- (type 10, flag 0x20000); it has no roads. Each type's flag bits; the sound a panel trail makes turning a panel
-- into it (0x080113A0); which panels start visible and the front edges (0x0800ABAC, 0x0800ABD4); the step rules
-- (0x0800CAE8, dashes 0x0800E114: EXE6's values). EXE5 has no any-side step rule (EXE6's `sub_800E680` is absent):
-- its rows here are EXE6's, for EXE6's code in an EXE5 arena.
--
-- What the panels do (0x0800A998, EXE6's `sub_800C380`): a broken panel mends after 600 ticks whatever the
-- battle; lava and sea turn normal after 960 ticks (blinking in the last 60, each its own timer, which a panel's
-- new type sets: 0x0800B2AE); no panel erupts. A grounded body not of fire on lava burns for 50 (shifted by its
-- weakness to fire) and the panel turns normal (0x08016D80, 0x08016E18); sea drains a fire body as poison drains
-- any (0x08016C7E, EXE6's `sub_801A186`; grass heals a wood body, at 9 HP or less on the 180-tick count, as
-- EXE6's), holds a body that ends a move on it for 20 ticks with a splash
-- (0x0801715E) and submerges what can dive (0x08017030); a move's end on magnet starts a slide, tried in turn by
-- the direction of the move (0x08017216, the tables at 0x0800C920 and 0x0800C9C0: dx toward the front). A hitbox
-- of fire turns grass normal as it passes over, of aqua lava, of wood magnet (0x08016D14).
-- Written by tools/exe5/gen_rules.py (bn6battle-verify) from the EXE5 ROM; people own it now.

local panel_types = require("@exelib/panel_types")
local sparks = require("../lib/sparks")
local splash_sprite = asset.sprite("splash")

-- The steps a magnet slide tries: forward, back, up, down.
local F, B, U, D = { dx = 1, dy = 0 }, { dx = -1, dy = 0 }, { dx = 0, dy = -1 }, { dx = 0, dy = 1 }

-- Lava's burn (0x08016D80, 0x08016E18): a body invisible, submerged, flashing, untouchable or bubbled is spared
-- (0x88000206); the sparks' row 1, the fire spark.
local LAVA_BURN = panel_types.burn {
    damage = 50,
    spared_by = { invisible = true, submerged = true, flashing = true, untouchable = true, bubbled = true },
    spark = sparks.fire,
}

-- The splash of a body a sea panel holds at a move's end (effect 0x63: 0x0801715E).
local SPLASH = new.effect { sprite = splash_sprite, anim = 0, palette = 0, steps = 22 }

return {
    -- The flags the types set besides the engine's (solid, cracked), each its bit of the flags word: what each
    -- type's `flags` and the panel conditions name.
    type_flags = {
        poison = 0x100,
        magnet = 0x200,
        grass = 0x400,
        ice = 0x800,
        lava = 0x1000,
        holy = 0x2000,
        broken = 0x4000,
        missing = 0x8000,
        on_field = 0x10000,
        sea = 0x20000,
    },
    types = {
        missing = { flags = { missing = true, on_field = true } },
        broken = { flags = { broken = true, on_field = true } },
        normal = { flags = { solid = true, on_field = true } },
        cracked = { flags = { solid = true, cracked = true, on_field = true } },
        poison = {
            flags = { solid = true, poison = true, on_field = true },
            trail_sound = asset.sound("panel-poison"),
            stand = panel_types.poison,
        },
        magnet = {
            flags = { solid = true, magnet = true, on_field = true },
            trail_sound = asset.sound("immobilizer"),
            cleared_by = Element.wood,
            -- By the direction of the move: none, up, down, back, forward, other.
            carries_by_move = { {}, { F, U, B, D }, { B, D, F, U }, { U, B, D, F }, { D, F, U, B }, { D, F, U, B } },
            move_end = panel_types.magnet,
            slide = panel_types.carries,
        },
        -- A fire hit counts once more on a body standing on grass, an elec one on the sea (0x08016AF6).
        grass = {
            flags = { solid = true, grass = true, on_field = true },
            trail_sound = asset.sound("grass"),
            cleared_by = Element.fire,
            doubles = Element.fire,
            stand = panel_types.grass(9),
        },
        ice = {
            flags = { solid = true, ice = true, on_field = true },
            trail_sound = asset.sound("freeze"),
            move_end = panel_types.ice_slides,
            slide = panel_types.ice,
        },
        lava = {
            flags = { solid = true, lava = true, on_field = true },
            trail_sound = asset.sound("panel-volcano"),
            expires = 960,
            burn = LAVA_BURN,
            cleared_by = Element.aqua,
        },
        holy = {
            flags = { solid = true, holy = true, on_field = true },
            trail_sound = asset.sound("panel-change"),
            damage_shift = 1,
        },
        sea = {
            flags = { solid = true, on_field = true, sea = true },
            trail_sound = asset.sound("sand-worm"),
            expires = 960,
            stand = panel_types.drains("fire"),
            move_end = panel_types.holds(20, SPLASH),
            slide = panel_types.stops_a_slide,
            submerges = true,
            doubles = Element.elec,
        },
    },
    -- EXE5's panel types by its own numbers (a panel trail's byte, NaviStats +0x12, names one: the cards' water a sea,
    -- magnet a magnet panel).
    numbers = { "missing", "broken", "normal", "cracked", "poison", "magnet", "grass", "ice", "lava", "holy", "sea" },
    -- The types the engine's own code needs: the missing panel, which no type change reaches; what a break and a
    -- crack make (1 and 3); the normal panel, what a mend, an expiry and a clearing leave (0x0800A998, 0x08016D14:
    -- 2).
    roles = { missing = PanelType.missing, broken = PanelType.broken, cracked = PanelType.cracked, normal = PanelType.normal },
    start_visible = {
        { false, false, false, false, false, false, false, false },
        { false, true, true, true, true, true, true, false },
        { false, true, true, true, true, true, true, false },
        { false, true, true, true, true, true, true, false },
        { false, false, false, false, false, false, false, false },
    },
    front_edges = {
        { false, false, false, false, false, false, false, false },
        { false, false, false, false, false, false, false, false },
        { false, false, false, false, false, false, false, false },
        { false, true, true, true, true, true, true, false },
        { false, false, false, false, false, false, false, false },
    },
    step = {
        grounded = {
            solid = true,
            own_area = true,
            reserved = false,
            own_body = false,
            own_other_body = false,
            enemy_other_body = false,
            neutral = false,
            blocker = false,
        },
        floor_free = {
            own_area = true,
            reserved = false,
            own_body = false,
            own_other_body = false,
            enemy_other_body = false,
            neutral = false,
            blocker = false,
        },
    },
    dash_step = {
        grounded = { solid = true, own_area = true, occupied = false },
        floor_free = { own_area = true, occupied = false },
    },
    any_side_step = {
        grounded = {
            solid = true,
            enemy_body = false,
            own_other_body = false,
            enemy_other_body = false,
            neutral = false,
        },
        floor_free = { enemy_body = false, own_other_body = false, enemy_other_body = false, neutral = false },
    },
    mend = { normal = 600, battle_mode_1 = 600 },
    -- A reservation doesn't mark its holder (0x0801865C sets the panel's alone), and a destroyed holder's stay
    -- (EXE5's destroys, 0x080138B6 and 0x080138F2, release none).
    reservations = "unmarked",
    -- The flags' bits a type owns, which a crack, a break or poison clears (0x0800AFF8 and its kin), the sea's
    -- 0x20000 among them.
    type_mask = {
        solid = true,
        cracked = true,
        poison = true,
        magnet = true,
        grass = true,
        ice = true,
        lava = true,
        holy = true,
        sea = true,
    },
    -- What each panel is drawn as is in the panel (+6 its type, +7 its owner), which its refresh writes (0x0800AFE8):
    -- a change shows at once, and a dimmed tick, which runs no panel update, leaves a blink as it is.
    drawn = "in_panel",
}
