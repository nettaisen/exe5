--!strict
-- CrakOut, DublCrak and TripCrak: the crakout series (each chip's own comment above its definition).
-- Their records are written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local crack = require("@self/crack")

-- CrakOut (EXE5 chip 0x05b): action 0x1B, cracks on the panel ahead (chips/crack_out/crack).
local crack_out: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 4,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    -- (0x080C7818's row 0: the panel ahead.)
    action = crack.action({ { 0, 0 } }),
    auto_battle = { class = "at_once" },
}

-- DublCrak (EXE5 chip 0x05c): action 0x1B, cracks on the panel ahead and the one behind it (chips/crack_out/crack).
local double_crack: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 7,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    -- (Row 1: the panel ahead and the one behind it.)
    action = crack.action({ { 0, 0 }, { 1, 0 } }),
    auto_battle = { class = "at_once" },
}

-- TripCrak (EXE5 chip 0x05d): action 0x1B, cracks on the column ahead (chips/crack_out/crack).
local triple_crack: Chip = {
    codes = { "*" },
    element = Element.null,
    family = Family.null,
    class = ChipClass.standard,
    rarity = 0,
    mb = 10,
    damage = 0,
    counter = 0,
    lockout = 0,
    flags = { standard_library = true, library = true },
    extra_flags = { free_slot_in = true },
    slot_in_limit = 3,
    -- (Row 2: the column ahead.)
    action = crack.action({ { 0, 0 }, { 0, -1 }, { 0, 1 } }),
    auto_battle = { class = "at_once" },
}

return { crack_out = crack_out, double_crack = double_crack, triple_crack = triple_crack }
