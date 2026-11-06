--!strict
-- EXE5's battle flow where it differs from EXE6's (docs/design/exe5-map.md §15.3 items 7 and 13, §15.4), the arena's:
-- a custom screen's result is 49 words on the link (0x08009A5E: its NaviStats 0x60 bytes, EXE6's 0x64), so it is in
-- a tick sooner; its Team Battle custom screen (0x08025EF2, run by the custom screen mode 0x08007F50 in place of
-- EXE6's `sub_8026A28`) takes it as EXE6's does (0x080266FA, a tick after both results are in its state 8 closes it,
-- 0x08025FEC); after the reversions it opens the custom screen
-- straight away (no state 0x24); no escape check (EXE6's `sub_800AAD6` is absent); the result's banner holds at
-- least 102 ticks, 65 in a special battle. And what an EXE5 console shows otherwise (presentation, which the frontend
-- reads of a console's own game): its intro fades in from black (0x080E0698 tests a byte the open bus gives).

return {
    result_words = 49,
    sequencer_before_custom = false,
    escape_check = false,
    result_wait = { normal = 0x66, special = 65 },
    -- No low-HP music: EXE5's ROM has no tempo or pitch control (EXE6's `sub_8009158` switch is absent).
    low_hp_music = false,
    -- A win shows the winner's navi's banner only in a link battle that is an operation battle (0x080074D2: battle
    -- flag 0x40, 0x080090E8, then 0x080090C0's table); a Team Battle's and a NetBattle's shows "ENEMY DELETED", or
    -- "YOU WIN" on the judge's ruling (the roles `win` and `win_judged`). EXE6's link battles all show the navi's.
    navi_win_banner = "operation_battle",
    -- The intro returns after its init, as EXE6's.
    intro_steps_on_init = false,
    -- A turn starts with the transformation sequencer (the souls'), as EXE6's.
    sequencer_at_turn_start = true,
    -- L or R with a full gauge: the navi's input decode asks for the custom screen, which the fight reads the next
    -- tick, as EXE6's.
    custom_request = "navi_input",
    -- The battle's counts of fight ticks (BattleState +0x0E and +0x16, while neither paused nor dimmed: 0x08006EF6):
    -- 20 and 180.
    fight_cycles = { 20, 180 },
    -- Its battle effects of its own (the settings' word), which its stages and rules name besides the engine's
    -- (`full_hp`, `link`...): the folder dealt with its Regular chip and tag chips first and shuffled (EXE6's
    -- `sub_800A3E4`); the battle's end changes the light/dark value and MegaMan's maximum HP by what the side did
    -- (0x08007CA0: 0x0801289C and 0x0801299E, outside a link battle; nothing here keeps a save); the light/dark
    -- value held at 500 (0x08010EDC: ./party); dark chips fizzle (0x0801003C: ./light_dark). The engine reads
    -- none of them but through `battle.has_effect`.
    effect_bits = { shuffled_folder = 0x80, karma_changes = 0x800, karma_held = 0x20000, dark_chips_fizzle = 0x100000 },
}
