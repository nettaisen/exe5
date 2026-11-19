--!strict
-- EXE5's TankCans (action 0x46, 0x080EEF4A): EXE6's tank cannon and shell (@exelib/tank_cannon: the same code) with EXE5's
-- look: the cannon (the attachment table's row 0x25, EXE6's 0x14: the same look), the shell (attack object #0x3C,
-- 0x080CC9EC: its collision row 0, EXE6's), its edge blast EXE5's effect 0x47 hitting as an attack (EXE6's thrown,
-- 0x080CCB40) and unshifted, its sounds and effects.

local attachment = require("../../objects/attachment")
local action = require("@exelib/tank_cannon/action")
local collision = require("../../rules/collision")
local shell = require("@exelib/tank_cannon/shell")
local explosion_sprite = asset.sprite("explosion")
local shell_burst_sprite = asset.sprite("shell_burst")
local tank_blast_sprite = asset.sprite("tank_blast")
local tank_cannon_sprite = asset.sprite("tank_cannon")

local tank_cannon = {}

tank_cannon.kind = shell.make_kind("tank_cannon/shell", {
    is = collision.attack,
    hits = collision.hits_navis,
    sound = asset.sound("cannon"),
    hit_sound = asset.sound("burst"),
    blast = new.effect { sprite = tank_blast_sprite, anim = 0, palette = 0, steps = 17 },
    blast_is = collision.attack,
    explosion = new.effect { sprite = explosion_sprite, anim = 0, palette = 0, steps = 22 },
    burst = new.effect { sprite = shell_burst_sprite, anim = 0, palette = 0, steps = 27 },
})

-- The tank cannon (the attachment table's row 0x25), which Colonel's C-Cannon holds too (navis/colonel/chip).
local CANNON = attachment.look { sprite = tank_cannon_sprite, palette = 0, attach_point = 8 }
tank_cannon.cannon = CANNON

-- The TankCans' action (`id`: the key compat names it by, if it does), its shell flying as `flies` says (the attack's parameters: MegaMan's B↓Ccann
-- loads TankCan1 and takes the cracking away, navis/megaman/weapons/chips).
function tank_cannon.make_action(flies: ShellSpec, id: string?): Action
    return action.action { id = id, cannon = CANNON, attachment = attachment.kind, kind = tank_cannon.kind, shell = flies }
end

-- The TankCans' action: their shell (the records' parameters: row 0, hit modifier 0x4B; cracking).
tank_cannon.action = tank_cannon.make_action({ hit_mod = { flinch = true, flash = true, back_far = true, drag = true }, cracks = true, shift = 0 })

return tank_cannon
