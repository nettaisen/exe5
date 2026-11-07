--!strict
-- Phoenix (EXE5 chip 0x139): The phoenix drops 18 fireballs on the field's middle columns, then heals its user's side (./controller,
-- ./phoenix). Past the navi chips' block: AntiNavi lets it through.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = Version.colonel,
    codes = { "P" },
    element = Element.fire,
    family = Family.fire,
    class = ChipClass.giga,
    -- A save can collect it (rules/folder): Team Colonel's library lists it, where this record's flags are Team
    -- ProtoMan's ROM's, which doesn't.
    collectible = true,
    rarity = 4,
    mb = 95,
    damage = 150,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true },
    slot_in_limit = 1,
    dimming = controller.hook,
    auto_battle = { class = "at_once" },
}

return { phoenix = chip }
