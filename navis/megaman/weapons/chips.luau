--!strict
-- The weapon routines that fire a chip, which the patch cards name for MegaMan's B button, charged shot and B+Back
-- special (docs/design/exe5-map.md §15.14): each loads a chip as the attack (0x0800FE78, EXE6's `loc_80126EA`'s place:
-- the chip record's damage, hit parameter, lockout, element, subtype and parameters; no bonus; not charged) and
-- starts the chip's use. Each weapon is its routine (`megaman/<chip>`), its charge time the charge table's row
-- (0x0801CA6C) by Charge 0 to 5, Charge 5 reading on into the next row's first entry.
--
-- Three do more than load: MettGuard's and CrsShld's B+Back (0x6A, 0x6B) wait 40 ticks before the next chip (their
-- lockout, over the record's), and Ccann's charged shot (0x5F) takes TankCan1's shell's cracking away (its second
-- parameter 0: the edge blast leaves the panels whole), the TankCans' action with that shell.

local air_hockey = require("../../../chips/air_hockey").air_hockey
local black_bomb = require("../../../chips/black_bomb").black_bomb
local boomerang = require("../../../chips/boomerang").boomerang
local cannon_ball = require("../../../chips/cannon_ball").cannon_ball
local circle_gun = require("../../../chips/circle_gun").circle_gun
local crakout_chips = require("../../../chips/crack_out")
local crsshld_chips = require("../../../chips/curse_shield")
local drilarm_chips = require("../../../chips/drill_arm")
local dark_sword = require("../../../chips/dark_sword").dark_sword
local guard_chips = require("../../../chips/guard")
local katana_chips = require("../../../chips/katana")
local long_sword = require("../../../chips/long_sword").long_sword
local mini_bomb = require("../../../chips/mini_bomb").mini_bomb
local moonbld_chips = require("../../../chips/moon_blade")
local poltergeist = require("../../../chips/poltergeist").poltergeist
local pulsar_chips = require("../../../chips/pulsar")
local sea_seed = require("../../../chips/sea_seed").sea_seed
local sword = require("../../../chips/sword").sword
local tank_cannon = require("../../../chips/tank_cannon/tank_cannon")
local tankcan_chips = require("../../../chips/tank_cannon")
local thunder = require("../../../chips/thunder").thunder
local tornado_chips = require("../../../chips/tornado")
local wide_blade = require("../../../chips/wide_blade").wide_blade
local widesht_chips = require("../../../chips/wide_shot")
local wide_sword = require("../../../chips/wide_sword").wide_sword
local yo_yo = require("../../../chips/yo_yo").yo_yo

local chips = {}

-- The weapon `id` that loads `chip` (0x0800FE78) and starts its use, charging for `ticks` (its row).
local function fires(id: string, chip: Chip, ticks: { number }): Weapon
    return new.weapon {
        id = id,
        charge_ticks = ticks,
        setup = function(navi: Object): Chip
            navi:load_chip_attack(chip)
            return chip
        end,
    }
end

-- A guard's B+Back: the chip loaded, and 40 ticks before the next chip; the chip's own action (action 0x1F, EXE5's
-- guard: the routine names it, the chip's record does too).
local GUARD_LOCKOUT = 40
local function guards(id: string, chip: Chip, ticks: { number }): Weapon
    return new.weapon {
        id = id,
        charge_ticks = ticks,
        setup = function(navi: Object): Chip
            navi:load_chip_attack(chip)
            navi.attack_lockout = GUARD_LOCKOUT
            return chip
        end,
    }
end

-- ---- Charged shots ----------------------------------------------------------------------------------------------------

chips.long_sword = fires("megaman/long_sword", long_sword, { 80, 75, 70, 65, 60, 120 }) -- 0x48, B↓LongS
chips.thunder = fires("megaman/thunder", thunder, { 120, 115, 110, 105, 100, 60 }) -- 0x49, B↓Thundr
chips.yo_yo = fires("megaman/yo_yo", yo_yo, { 80, 75, 70, 65, 60, 70 }) -- 0x4B, B↓YoYo
chips.katana = fires("megaman/katana_1", katana_chips.katana_1, { 90, 85, 80, 75, 70, 70 }) -- 0x4D, B↓Katana
chips.pulsar = fires("megaman/pulsar_1", pulsar_chips.pulsar_1, { 110, 105, 100, 95, 90, 130 }) -- 0x50, B↓Pulsar
chips.poltergeist = fires("megaman/poltergeist", poltergeist, { 130, 125, 120, 115, 110, 80 }) -- 0x51, B↓Poltr
chips.wide_sword = fires("megaman/wide_sword", wide_sword, { 80, 75, 70, 65, 60, 70 }) -- 0x52, B↓WideS
-- (0x53: B↓MiniBm and B-Bomb.)
chips.mini_bomb = fires("megaman/mini_bomb", mini_bomb, { 70, 65, 60, 55, 50, 100 })
chips.cannon_ball = fires("megaman/cannon_ball", cannon_ball, { 100, 95, 90, 85, 80, 120 }) -- 0x54, B↓CanBal
chips.tornado = fires("megaman/tornado", tornado_chips.tornado, { 120, 115, 110, 105, 100, 60 }) -- 0x55, B↓Trnado
chips.moon_blade = fires("megaman/moon_blade_1", moonbld_chips.moon_blade_1, { 100, 95, 90, 85, 80, 140 }) -- 0x58, B↓MonBld
chips.air_hockey = fires("megaman/air_hockey", air_hockey, { 140, 135, 130, 125, 120, 150 }) -- 0x59, B↓AirHoc
chips.circle_gun = fires("megaman/circle_gun", circle_gun, { 150, 145, 140, 135, 130, 120 }) -- 0x5A, B↓CircG
chips.drill_arm = fires("megaman/drill_arm_1", drilarm_chips.drill_arm_1, { 120, 115, 110, 105, 100, 100 }) -- 0x5B, B↓DrlArm
chips.wide_blade = fires("megaman/wide_blade", wide_blade, { 100, 95, 90, 85, 80, 160 }) -- 0x5C, B↓WideB
chips.black_bomb = fires("megaman/black_bomb", black_bomb, { 160, 155, 150, 145, 140, 100 }) -- 0x5D, B↓BlkBom
chips.sea_seed = fires("megaman/sea_seed", sea_seed, { 100, 95, 90, 85, 80, 100 }) -- 0x5E, B↓SeaSed
chips.dark_sword = fires("megaman/dark_sword", dark_sword, { 180, 175, 170, 165, 160, 40 }) -- 0x60, B↓DarkS
chips.boomerang = fires("megaman/boomerang", boomerang, { 120, 115, 110, 105, 100, 120 }) -- 0x66, B↓Boomer
chips.wide_shot = fires("megaman/wide_shot_1", widesht_chips.wide_shot_1, { 120, 115, 110, 105, 100, 110 }) -- 0x67, B↓Wshot

-- 0x5F, B↓Ccann: TankCan1, its shell not cracking (the parameter's second byte 0).
local CCANN = tank_cannon.make_action({ hit_mod = { flinch = true, flash = true, back_far = true, drag = true }, cracks = false, shift = 0 }, "megaman/tank_cannon_1/action")
chips.tank_cannon = new.weapon {
    id = "megaman/tank_cannon_1",
    charge_ticks = { 100, 95, 90, 85, 80, 180 },
    setup = function(navi: Object): Action
        navi:load_chip_attack(tankcan_chips.tank_cannon_1)
        return CCANN
    end,
}

-- ---- B buttons -----------------------------------------------------------------------------------------------------

chips.sword = fires("megaman/sword", sword, { 80, 75, 70, 65, 60, 60 }) -- 0x64, B-Sword
chips.crack_out = fires("megaman/crack_out", crakout_chips.crack_out, { 50, 45, 40, 35, 30, 100 }) -- 0x57, B-Crack

-- ---- B+Back specials -----------------------------------------------------------------------------------------------

chips.mettguard = guards("megaman/guard_1", guard_chips.guard_1, { 60, 55, 50, 45, 40, 60 }) -- 0x6A, B+←Guard
chips.curse_shield = guards("megaman/curse_shield_1", crsshld_chips.curse_shield_1, { 60, 55, 50, 45, 40, 2052 }) -- 0x6B, B+←CurS

return chips
