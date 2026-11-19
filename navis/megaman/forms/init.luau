--!strict
-- EXE5's forms (docs/design/content-model-v2.md §4.0), by id: the tables of the modules that define them as one, which
-- the game's init.luau returns as its `forms`. Written by tools/content/index.py (the verification workspace) from the
-- modules that are there: run it again rather than edit this, also to settle a merge conflict in it.

local merge = require("@exelib/merge")

return merge {
    -- Forms.
    require("@self/base"),
    require("@self/colonel_soul"),
    require("@self/gyro_soul"),
    require("@self/knight_soul"),
    require("@self/magnet_soul"),
    require("@self/meddy_soul"),
    require("@self/napalm_soul"),
    require("@self/number_soul"),
    require("@self/proto_soul"),
    require("@self/search_soul"),
    require("@self/shadow_soul"),
    require("@self/toad_soul"),
    require("@self/tomahawk_soul"),
}
