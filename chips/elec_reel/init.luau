--!strict
-- ElcReel1, ElcReel2 and ElcReel3: the elcreel series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local elec_reel = require("@self/elec_reel")

-- ElcReel1 (EXE5 chip 0x0a3): the navi launches a reel along its row; what it hits, it hooks with every navi around
-- it, and shocks them: EXE5's own (chips/elec_reel/elec_reel).
local elec_reel_1: Chip = {
    codes = { "C", "V", "Z" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 0,
    mb = 32,
    damage = 80,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = elec_reel.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- ElcReel2 (EXE5 chip 0x0a4): the navi launches a reel along its row; what it hits, it hooks with every navi around
-- it, and shocks them: EXE5's own (chips/elec_reel/elec_reel).
local elec_reel_2: Chip = {
    codes = { "B", "Q", "Y" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 1,
    mb = 46,
    damage = 100,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = elec_reel.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

-- ElcReel3 (EXE5 chip 0x0a5): the navi launches a reel along its row; what it hits, it hooks with every navi around
-- it, and shocks them: EXE5's own (chips/elec_reel/elec_reel).
local elec_reel_3: Chip = {
    codes = { "E", "L", "R" },
    element = Element.elec,
    family = Family.elec,
    class = ChipClass.standard,
    rarity = 2,
    mb = 60,
    damage = 120,
    counter = 10,
    lockout = 0,
    flags = { has_damage = true, library = true },
    slot_in_limit = 3,
    action = elec_reel.action,
    auto_battle = { class = "into_reach", range = "ahead_in_row" },
}

return { elec_reel_1 = elec_reel_1, elec_reel_2 = elec_reel_2, elec_reel_3 = elec_reel_3 }
