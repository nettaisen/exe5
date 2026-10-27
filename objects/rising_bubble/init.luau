--!strict
-- EXE5's rising bubble (effect object #0x14, EXE6's code: @exelib/rising_bubble/rising_bubble), EXE5's kind; its sprite
-- EXE6's small puff.

local common = require("@exelib/rising_bubble")
local small_puff_sprite = require("../sprites/small_puff")

local rising_bubble = {}

rising_bubble.kind = common.make_kind("rising-bubble", small_puff_sprite)

-- A bubble at `pos` in sprite palette `palette`.
function rising_bubble.spawn(pos: Vec3, palette: number): Object?
    return common.spawn(rising_bubble.kind, pos, palette)
end

return rising_bubble
