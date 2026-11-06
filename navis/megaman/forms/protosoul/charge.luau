--!strict
-- ProtoSoul's charged shot (`protosoul/charge`): the original's weapon routine 3 (0x0800F60C). It is WideSwrd's
-- slash (EXE5's action 0x13 as its subtype 1: the chip's own action, chips/wideswrd), not loaded as a chip, with 80
-- damage and 10 more per point of buster Attack plus one (0x0800FE5E), and its own counter byte.

local wideswrd = require("../../../../chips/wideswrd").wideswrd

local charge = {}

local COUNTER = 20
-- 0x0800F60C
local function setup(navi: Object): Action
    navi.attack_element = Element.null
    navi.charged = 0
    navi.attack_lockout = 0
    navi.extra = 0
    navi.attack_word = damage_word.of { amount = 80 + 10 * (battle.navi(navi.alliance).attack + 1), counter = COUNTER, cant_counter = true }
    return assert(wideswrd.action)
end

charge.weapon = new.weapon {
    -- The charge table's row 3 (0x0801CA8A); Charge 5 reads on into row 4's first entry.
    charge_ticks = { 80, 75, 70, 65, 60, 180 },
    setup = setup,
}

return charge
