--!strict
-- Statuses (0x0801CEC4, EXE6's `off_80209EC`: four groups, paralysis, confusion, blindness and
-- immobilization, by level; their bytes are compat's): what a hit's status does to its target, and the HP
-- bug's drain periods (0x0800E02C, EXE6's values). The timers are 2 bytes further into the collision
-- record than EXE6's (paralysis at +0x1E), and each raises its timer's request. Rows past a group's end
-- read the next groups' rows, named for what they read, as EXE6's; those past the table's end, which
-- nothing inflicts, it leaves out.
-- Written by tools/exe5/gen_rules.py (bn6battle-verify) from the EXE5 ROM; people own it now.

local status = {
    paralyze_90 = new.status {
        id = "paralyze-90",
        duration = 90,
        timer = StatusKind.paralyze,
    },
    paralyze_120 = new.status {
        id = "paralyze-120",
        duration = 120,
        timer = StatusKind.paralyze,
    },
    paralyze_150 = new.status {
        id = "paralyze-150",
        duration = 150,
        timer = StatusKind.paralyze,
    },
    paralyze_4 = new.status {
        id = "paralyze-4",
        duration = 4,
        timer = StatusKind.paralyze,
    },
    paralyze_300 = new.status {
        id = "paralyze-300",
        duration = 300,
        timer = StatusKind.paralyze,
    },
    paralyze_600 = new.status {
        id = "paralyze-600",
        duration = 600,
        timer = StatusKind.paralyze,
    },
    confuse_480_past_paralyze = new.status {
        id = "confuse-480-past-paralyze",
        duration = 480,
        timer = StatusKind.confuse,
    },
    confuse_720_past_paralyze = new.status {
        id = "confuse-720-past-paralyze",
        duration = 720,
        timer = StatusKind.confuse,
    },
    confuse_960_past_paralyze = new.status {
        id = "confuse-960-past-paralyze",
        duration = 960,
        timer = StatusKind.confuse,
    },
    confuse_4_past_paralyze = new.status {
        id = "confuse-4-past-paralyze",
        duration = 4,
        timer = StatusKind.confuse,
    },
    confuse_300_past_paralyze = new.status {
        id = "confuse-300-past-paralyze",
        duration = 300,
        timer = StatusKind.confuse,
    },
    confuse_600_past_paralyze = new.status {
        id = "confuse-600-past-paralyze",
        duration = 600,
        timer = StatusKind.confuse,
    },
    blind_480_past_paralyze = new.status {
        id = "blind-480-past-paralyze",
        duration = 480,
        timer = StatusKind.blind,
    },
    blind_720_past_paralyze = new.status {
        id = "blind-720-past-paralyze",
        duration = 720,
        timer = StatusKind.blind,
    },
    blind_1200_past_paralyze = new.status {
        id = "blind-1200-past-paralyze",
        duration = 1200,
        timer = StatusKind.blind,
    },
    blind_4_past_paralyze = new.status {
        id = "blind-4-past-paralyze",
        duration = 4,
        timer = StatusKind.blind,
    },
    confuse_480 = new.status {
        id = "confuse-480",
        duration = 480,
        timer = StatusKind.confuse,
    },
    confuse_720 = new.status {
        id = "confuse-720",
        duration = 720,
        timer = StatusKind.confuse,
    },
    confuse_960 = new.status {
        id = "confuse-960",
        duration = 960,
        timer = StatusKind.confuse,
    },
    confuse_4 = new.status {
        id = "confuse-4",
        duration = 4,
        timer = StatusKind.confuse,
    },
    confuse_300 = new.status {
        id = "confuse-300",
        duration = 300,
        timer = StatusKind.confuse,
    },
    confuse_600 = new.status {
        id = "confuse-600",
        duration = 600,
        timer = StatusKind.confuse,
    },
    blind_480_past_confuse = new.status {
        id = "blind-480-past-confuse",
        duration = 480,
        timer = StatusKind.blind,
    },
    blind_720_past_confuse = new.status {
        id = "blind-720-past-confuse",
        duration = 720,
        timer = StatusKind.blind,
    },
    blind_1200_past_confuse = new.status {
        id = "blind-1200-past-confuse",
        duration = 1200,
        timer = StatusKind.blind,
    },
    blind_4_past_confuse = new.status {
        id = "blind-4-past-confuse",
        duration = 4,
        timer = StatusKind.blind,
    },
    blind_300_past_confuse = new.status {
        id = "blind-300-past-confuse",
        duration = 300,
        timer = StatusKind.blind,
    },
    blind_600_past_confuse = new.status {
        id = "blind-600-past-confuse",
        duration = 600,
        timer = StatusKind.blind,
    },
    immobilize_2_past_confuse = new.status {
        id = "immobilize-2-past-confuse",
        duration = 2,
        timer = StatusKind.immobilize,
    },
    immobilize_60_past_confuse = new.status {
        id = "immobilize-60-past-confuse",
        duration = 60,
        timer = StatusKind.immobilize,
    },
    immobilize_120_past_confuse = new.status {
        id = "immobilize-120-past-confuse",
        duration = 120,
        timer = StatusKind.immobilize,
    },
    immobilize_4_past_confuse = new.status {
        id = "immobilize-4-past-confuse",
        duration = 4,
        timer = StatusKind.immobilize,
    },
    blind_480 = new.status {
        id = "blind-480",
        duration = 480,
        timer = StatusKind.blind,
    },
    blind_720 = new.status {
        id = "blind-720",
        duration = 720,
        timer = StatusKind.blind,
    },
    blind_1200 = new.status {
        id = "blind-1200",
        duration = 1200,
        timer = StatusKind.blind,
    },
    blind_4 = new.status {
        id = "blind-4",
        duration = 4,
        timer = StatusKind.blind,
    },
    blind_300 = new.status {
        id = "blind-300",
        duration = 300,
        timer = StatusKind.blind,
    },
    blind_600 = new.status {
        id = "blind-600",
        duration = 600,
        timer = StatusKind.blind,
    },
    immobilize_2_past_blind = new.status {
        id = "immobilize-2-past-blind",
        duration = 2,
        timer = StatusKind.immobilize,
    },
    immobilize_60_past_blind = new.status {
        id = "immobilize-60-past-blind",
        duration = 60,
        timer = StatusKind.immobilize,
    },
    immobilize_120_past_blind = new.status {
        id = "immobilize-120-past-blind",
        duration = 120,
        timer = StatusKind.immobilize,
    },
    immobilize_4_past_blind = new.status {
        id = "immobilize-4-past-blind",
        duration = 4,
        timer = StatusKind.immobilize,
    },
    immobilize_300_past_blind = new.status {
        id = "immobilize-300-past-blind",
        duration = 300,
        timer = StatusKind.immobilize,
    },
    immobilize_600_past_blind = new.status {
        id = "immobilize-600-past-blind",
        duration = 600,
        timer = StatusKind.immobilize,
    },
    immobilize_2 = new.status {
        id = "immobilize-2",
        duration = 2,
        timer = StatusKind.immobilize,
    },
    immobilize_60 = new.status {
        id = "immobilize-60",
        duration = 60,
        timer = StatusKind.immobilize,
    },
    immobilize_120 = new.status {
        id = "immobilize-120",
        duration = 120,
        timer = StatusKind.immobilize,
    },
    immobilize_4 = new.status {
        id = "immobilize-4",
        duration = 4,
        timer = StatusKind.immobilize,
    },
    immobilize_300 = new.status {
        id = "immobilize-300",
        duration = 300,
        timer = StatusKind.immobilize,
    },
    immobilize_600 = new.status {
        id = "immobilize-600",
        duration = 600,
        timer = StatusKind.immobilize,
    },
    -- EXE5's per-form tick table (0x080EB1E8) runs none of EXE6's `sub_80F0608` (the Fire charge, a form's
    -- height): MegaMan's (0x080F04CE) steps GyroSoul's overlay (rules/souls). Its hit intake (0x080178EC) takes a
    -- hit's NaviCust bug (0x0801103E) before the HP bug drains (0x0800DFEC), and a drain bug's argument goes by its
    -- flags (bit 4 adds, bit 5 subtracts, else it raises the level).
    rules = {
        -- The NaviCust's HP bug drains a point every so many ticks by its level (0x0800DFEC, EXE6's), held while the
        -- battle is paused; the custom screen's while the side's screen is up (0x0800E034: the status's bits 5, the
        -- table at 0x0800E084, EXE6's values).
        hp_drain = { periods = { 0, 40, 35, 30, 25, 20, 15, 10 }, stops_while_paused = true },
        custom_drain = {
            periods = { 0, 40, 30, 20, 10, 5, 3, 2 },
            status = { selecting = true, custom_screen = true },
        },
        form_tick = false,
        form_keeps_back_special = false,
        -- The mercy flash hides the navi while its timer's bit 1 is clear (0x080137B6; EXE6's while it is set).
        flash_hides_on_clear = true,
        -- Its status block (0x08017CC8 on) runs the flash's timer first, whatever the battle's flags (0x080173C4),
        -- then the slides, a drag and a flinch, which end a paralysis unless a counter just made it.
        reactions = "flash_timer_first",
        -- Its reaction actions mark the action in use, ground and count (0x08014132 on), as EXE6's.
        reaction_actions = "marked",
        -- A drag takes SuperArmor's pose, else the flinch's, with no paralyzed one (0x08014304); at its end the navi
        -- stands, whatever the paralysis (0x080144CE).
        drag = { poses = { super_armor = 0, otherwise = 1 }, ending = "stands" },
        bugs_before_drain = true,
        -- DarkInvs's no-charge drive: its ticks count down at the intake's end (0x0800DBE0) and their end asks for the
        -- stun strike (action 0x49, the drive's end: chips/darkinvs); the last 180 ticks flicker gray (0x080136E0).
        no_charge_drive = true,
        -- EXE5's loss of HP (object_subtractHP, 0x0800C6E0; applyDamageToPlayer, 0x080185A2): a player's loss drains
        -- its side's gauge too, a loss to 0 asks the rules' `hp_emptied` (0x0802C16C: a dark MegaMan, emotion 5,
        -- holds at 1 HP once a battle and asks for his last stand, the roles' `volley`; ./emotion/dark_survival), and
        -- a hit shows (white, its sounds) by their answer, the register that check leaves.
        hp_loss = "gauge",
        -- A player hears its own navi's hit as `own_hit`, another's as `hit`, as EXE6's.
        hit_sound = "by_console",
        -- A barrier stands still while paused; wind, or the hit flags 0xA20, pop it (EXE6's code).
        barrier = { stops_while_paused = true, wind = "pops" },
        -- Its defensive chips (0x08029A60): AntiDmg, or the trap the navi's status arms, catches a hit of any damage
        -- (one of none passes); AntiSwrd any sword's hit (the hit flags 0x2000). A caught hit leaves the navi's pending
        -- requests (0x08029AE0 zeroes the hit alone): a move that ended on ice that tick slides.
        anti_traps = { damage_min = 1, armed_swallows_below = false, sword_spares = {}, drops_requests = {} },
        -- A chip-destroying hit (hit flag 0x10: 0x0801709A) takes a player's whole hand, the cursor back at its first
        -- chip. (EXE5's leaves the navi's chip requests, and one pending uses chip 0xFFFF's record, past the chip table:
        -- the engine ends it instead, docs/design/exe5-map.md §15.6.)
        chip_destruction = "hand",
        -- EXE5's emotions (0x0801270C): in battle mode 1 Full Synchro or normal (0x080127C0); else (0x08012740) a navi
        -- in a soul reads as normal (the soul's own face), then anger is read before a mood of 0 (a dark MegaMan's,
        -- evil), then Full Synchro, and a mood under 65 is worried; no held tired or exhausted state is read.
        -- Its mood setter (0x080127D6) leaves a mood of 0, and anger's end goes through it (0x08011A94). (Its anger
        -- tick, 0x08011A14, passes over the actor records of AI index 23, ShadowMan's SplitUp shadow's: an
        -- identity's `never_angers`, which no navi a player operates has.)
        emotion = {
            mood_held = "at_zero",
            anger_end = "through_setter",
            -- In that order: the first case that holds is the side's emotion.
            order = {
                { emotion = "full_synchro", when = { { battle_mode = 1, mood = Mood.full_synchro } } },
                { emotion = "normal", when = { { battle_mode = 1 }, { in_form = true } } },
                { emotion = "angry", when = { { angry = true } } },
                { emotion = "evil", when = { { mood = 0 } } },
                { emotion = "full_synchro", when = { { mood = Mood.full_synchro } } },
                { emotion = "worried", when = { { mood_below = 65 } } },
                { emotion = "normal" },
            },
            -- What the framework does by them: Full Synchro and anger double the next damaging chip (Full Synchro
            -- its palette and aura besides); an evil navi plays the framework's worn-out role (EXE6's very tired
            -- navi's): its buster deals 1, and anger doesn't start.
            roles = { full_synchro = "full_synchro", angry = "angry", evil = "worn_out" },
            -- A counter hit marks the counter and the counterer's rules hear it (0x08016FDC: ./emotion), as EXE6's;
            -- otherwise what a tick's hits counted raises the hitter's mood as a recovery does (0x08012802: a mood of 0
            -- or 0xFF stays, to 0xFE at most), where EXE6's gives nothing. A chip's use leaves Full Synchro at 0x80
            -- and sounds anger's boost too (after 0x0801026C, as EXE6's).
            hit_mood = "counter_mark",
            hitter_gain = "short_of_full",
            full_synchro_spent = 0x80,
            anger_boost_sound = true,
            -- A tick's hits of 300 damage or more ask for anger, as 120 ticks stunned do (0x080119C4, as EXE6's).
            anger_damage = 300,
        },
        -- The weakness request (a dark chip used in a soul, 0x08010070) breaks any form to the base form (0x080122C8).
        form_break = "any_form",
        -- A weakness hit doesn't ask for it: its status routine (0x08017BF2) shows the hit's mark and has no such step,
        -- so a navi hit on its weakness, in a soul or not, goes on as it was.
        weakness_hit_breaks_form = false,
        -- That mark (0x08017254) shows over the damage that tick's hits left of the element the navi's is weak to (the
        -- accumulator its table, 0x08017284, names by the navi's element: the elements rule's weakness table read the
        -- other way; none for null), whichever hit came last: its hit kernel stores no multiplier of a hit.
        weakness_mark = "weak_element_damage",
        -- While the battle is paused a navi runs its pause handler in place of its action, as EXE6's.
        paused_navi = "pause_handler",
        -- Its status timers hold while paused (0x0800CB50, as EXE6's).
        timers_while_paused = false,
        -- Its idle (0x080F0254) leaves the navi's pose, as EXE6's.
        idle_stands = false,
        -- Its idle hands the step it would take to the rules (0x080F03E4: the auto battle AI under the no-charge
        -- drive, else its state's reset: ./auto_battle's `controller`).
        idle_asks_controller = true,
        -- In a link battle a navi's body hits for 10, its damage as it is set up (0x080119AC, EXE6's `sub_80142B0`);
        -- its status reset (0x08011B3C) doesn't set it again (EXE6's `sub_80142C2` has no counterpart).
        link_body_damage = { damage = 10, again_at_reset = false },
    },
}

return status
