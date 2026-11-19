--!strict
-- EXE5's partycust programs (docs/design/content-model-v2.md §4.0), by id: the tables of the modules that define them
-- as one, which the game's init.luau returns as its `partycust_programs`. Written by tools/content/index.py (the
-- verification workspace) from the modules that are there: run it again rather than edit this, also to settle a merge
-- conflict in it.

local merge = require("@exelib/merge")

return merge {
    -- PartyCust programs.
    require("@self/party_attack_1"),
    require("@self/party_attack_2"),
    require("@self/party_attack_3"),
    require("@self/party_battle_pack_1"),
    require("@self/party_battle_pack_2"),
    require("@self/party_chip_30"),
    require("@self/party_chip_40"),
    require("@self/party_chip_50"),
    require("@self/party_hp_100"),
    require("@self/party_hp_200"),
    require("@self/party_hp_300"),
    require("@self/party_hp_50"),
    require("@self/party_support"),
}
