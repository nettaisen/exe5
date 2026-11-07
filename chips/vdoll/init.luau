--!strict
-- VDoll (EXE5 chip 0x067): a doll (./doll) lobbed three panels ahead, that poisons the panel it lands on and, hurt
-- there, curses one of the other side's panels with the damage it took (./curse): EXE5's throw (action 0x12, subtype
-- 8: lib/bombs, holding the bomb, the attachment table's row 4, 0x080EBCA0) of the doll (0x080D5926).
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local bombs = require("../lib/bombs")
local doll = require("@self/doll")

local chip: Chip = {
    codes = { "O", "T", "Z" },
    element = Element.null,
    family = Family.summon,
    class = "standard",
    rarity = 3,
    mb = 58,
    damage = 10,
    counter = 10,
    lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    action = bombs.throw { held = bombs.held, thrower = doll.thrower() },
    auto_battle = { class = "three_ahead_open" },
}

return { vdoll = chip }
