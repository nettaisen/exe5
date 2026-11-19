--!strict
-- EXE5's energy burst (attack object #0x11, EXE6's code: @exelib/energy_bomb/burst), EXE5's kind; its look and collision
-- types EXE6's: what EnergBom's and MegEnBom's bomb leaves where it lands (`burst.leave`).

local collision = require("../../rules/collision")
local common = require("@exelib/energy_bomb/burst")
local energy_burst_sprite = asset.sprite("energy_burst")

return common.make {
    id = "energy_bomb/burst",
    sprite = energy_burst_sprite,
    sound = asset.sound("energy_burst"),
    target = collision.hits_navis,
    self_type = collision.thrown,
}
