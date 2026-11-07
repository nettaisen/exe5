--!strict
-- DethPhnx (EXE5 chip 0x13a): DeathPhoenix sets 12 fires over the enemy area, then brings the last navi chip's navi again (./controller,
-- ./phoenix). Past the navi chips' block: AntiNavi lets it through.
-- Its record is written by tools/exe5/gen_content.py (bn6battle-verify) from the EXE5 ROMs.

local controller = require("@self/controller")

local chip: Chip = {
    -- The version whose saves hold it (rules/folder; rules/builds' groups).
    version = Version.protoman,
    codes = { "D" },
    element = Element.null,
    family = Family.null,
    class = "giga",
    rarity = 4,
    mb = 93,
    damage = 150,
    counter = 20,
    cant_counter = true,
    lockout = 0,
    flags = { dimming = true, has_damage = true, navi = true, library = true },
    slot_in_limit = 1,
    dimming = controller.hook,
    auto_battle = { class = "at_once" },
}

return { dethphnx = chip }
