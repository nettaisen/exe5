--!strict
-- NumberMan's face (EXE5's actor object #0x5C, 0x080C412E; EXE5's own, NumberMan's alone: its spawner's only caller is
-- his, with its Param0 0 and Param2 1): @exelib/numberman/face, its sprite 10-06, waiting for every navi to be in.

local numberman_face_sprite = asset.sprite("numberman_face")

return require("@exelib/numberman/face").make {
    id = "numberman/face",
    sprite = numberman_face_sprite,
}
