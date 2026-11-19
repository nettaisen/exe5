--!strict
-- SearchMan's scope, EXE5's (effect object #0x43, 0x080E5208): @exelib/searchman/scope with EXE5's looks (the scope,
-- and the sight that Satelity's controller, navis/searchman/controller, sends out), its sounds (0x10E as it moves,
-- which 0x080E52D4 loads as 15 + 255; the power-up's) and its sweep (0x080E5416: from the first column past its
-- user's area to the far edge).

local common = require("@exelib/searchman/scope")
local search_scope_sprite = asset.sprite("search_scope")
local sight_sprite = asset.sprite("sight")

return common.make {
    id = "searchman/scope",
    scope = search_scope_sprite,
    sight = sight_sprite,
    move_sound = asset.sound("erase_man"),
    lock_sound = asset.sound("mark"),
    bonus_sound = asset.sound("ok_8b"),
    columns = common.exe5_columns,
}
