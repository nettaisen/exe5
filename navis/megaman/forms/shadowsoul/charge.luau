--!strict
-- ShadowSoul's charged shot (`shadowsoul/charge`): the original's weapon routine 0x17 (0x0800F820). It is LongSwrd's
-- slash (EXE5's action 0x13 as its subtype 2: the chip's own action, chips/longswrd), not loaded as a chip and not
-- charged, with 50 damage and 10 more per point of buster Attack plus one (0x0800FE5E), and its own counter byte.

local longswrd = require("../../../../chips/longswrd").longswrd

local charge = {}

local COUNTER = 20
-- 0x0800F820
local function setup(navi: Object): Action
    navi.attack_element = Element.null
    navi.charged = 0
    navi.attack_lockout = 0
    navi.extra = 0
    navi.attack_word = damage_word.of { amount = 50 + 10 * (battle.navi(navi.alliance).attack + 1), counter = COUNTER, cant_counter = true }
    return assert(longswrd.action)
end

charge.weapon = new.weapon {
    -- The charge table's row 0x17 (0x0801CB52); Charge 5 reads on into row 0x18's first entry.
    charge_ticks = { 70, 65, 60, 55, 50, 30 },
    setup = setup,
}

return charge
