--!strict
-- Collision types (docs/engine/field-collision-damage.md §3.3): what an object is (its self type) and what it
-- reaches (its target type), by its members (of the object's side, `own_`, or the other's, `enemy_`: side 1's
-- word side 0's mirrored), from EXE5's table (0x0801636C, EXE6's `byte_8019C7C`: 80 rows to EXE6's 89): EXE6's
-- types by their names and rows, with EXE5's words, EXE6's past the table's end left out. EXE5's are EXE6's but for
-- the 0x80 bit (`reaches_float_shoe`), which EXE6 adds to the self type of every attack and object, and row 0x3D
-- (EXE5 gives it its sides' bits: exe5-map.md §15). `row_offset` as EXE6's.
-- Written by tools/exe5/gen_rules.py (bn6battle-verify) from the EXE5 ROM; people own it now.

local collision = {}

-- Row 0x04 (EXE6's with reaches_float_shoe).
collision.attack = new.collision { flags = { "own_attack" }, row_offset = 0x20 }
-- Row 0x0a (EXE6's with reaches_float_shoe).
collision.thrown = new.collision { flags = { "own_attack", "reaches_submerged" }, row_offset = 0x50 }
-- Row 0x07 (EXE6's with reaches_float_shoe).
collision.slash = new.collision { flags = { "own_attack", "sword" }, row_offset = 0x38 }
-- Row 0x1c (EXE6's with reaches_float_shoe).
collision.thrown_slash = new.collision { flags = { "own_attack", "sword", "reaches_submerged" }, row_offset = 0xe0 }
-- Row 0x0b (EXE6's with reaches_float_shoe).
collision.piercing = new.collision { flags = { "own_attack", "piercing" }, row_offset = 0x58 }
-- Row 0x05.
collision.hits_navis = new.collision {
    flags = { "enemy_object", "enemy_body", "enemy_other_body", "neutral" },
    row_offset = 0x28,
}
-- Row 0x14.
collision.hit_by_other_side = new.collision {
    flags = { "enemy_attack", "enemy_object", "enemy_body", "enemy_other_body", "neutral" },
    row_offset = 0xa0,
}
-- Row 0x0d.
collision.hit_by_other_side_or_blockers = new.collision {
    flags = { "enemy_attack", "enemy_object", "enemy_body", "enemy_other_body", "neutral", "reaches_set_objects" },
    row_offset = 0x68,
}
-- Row 0x16 (EXE6's with reaches_float_shoe).
collision.piercing_break = new.collision { flags = { "own_attack", "piercing", "break" }, row_offset = 0xb0 }
-- Row 0x0c (EXE6's with reaches_float_shoe).
collision.own_object = new.collision { flags = { "own_object", "hits_while_dimmed" }, row_offset = 0x60 }
-- Row 0x4e (EXE6's with reaches_float_shoe).
collision.own_thrown_body = new.collision {
    flags = { "own_other_body", "hits_while_dimmed", "reaches_submerged" },
    row_offset = 0x270,
}
-- Row 0x4f (EXE6's with reaches_float_shoe).
collision.neutral_object = new.collision {
    flags = { "neutral", "hits_while_dimmed", "reaches_submerged", "break" },
    row_offset = 0x278,
}
-- Row 0x0f.
collision.everything = new.collision {
    flags = {
        "own_attack",
        "enemy_attack",
        "own_object",
        "enemy_object",
        "own_body",
        "enemy_body",
        "own_other_body",
        "enemy_other_body",
        "neutral",
        "break",
    },
    row_offset = 0x78,
}
-- Row 0x18.
collision.hit_by_other_attacks = new.collision { flags = { "enemy_attack", "enemy_object" }, row_offset = 0xc0 }
-- Row 0x33.
collision.mine = new.collision {
    flags = { "own_attack", "enemy_attack", "reaches_set_objects", "reaches_submerged", "piercing", "break" },
    row_offset = 0x198,
}
-- Row 0x2a.
collision.hits_both_sides = new.collision {
    flags = { "own_object", "enemy_object", "own_body", "enemy_body", "enemy_other_body", "neutral" },
    row_offset = 0x150,
}
-- Row 0x01 (EXE6's with reaches_float_shoe).
collision.navi = new.collision { flags = { "own_body", "own_navi", "hits_while_dimmed" }, row_offset = 0x8 }
-- Row 0x02.
collision.navi_target = new.collision {
    flags = { "enemy_attack", "enemy_object", "enemy_body", "enemy_other_body", "neutral", "pull" },
    row_offset = 0x10,
}
-- Row 0x10 (EXE6's with reaches_float_shoe).
collision.floating_navi = new.collision {
    flags = { "own_body", "own_navi", "floating", "hits_while_dimmed" },
    row_offset = 0x80,
}
-- Row 0x15 (EXE6's with reaches_float_shoe).
collision.thrown_break = new.collision { flags = { "own_attack", "reaches_submerged", "break" }, row_offset = 0xa8 }
-- Row 0x17 (EXE6's with reaches_float_shoe).
collision.thrown_piercing_break = new.collision {
    flags = { "own_attack", "reaches_submerged", "piercing", "break" },
    row_offset = 0xb8,
}
-- Row 0x1e (EXE6's with reaches_float_shoe).
collision.pull = new.collision { flags = { "no_guard_spark", "pull" }, row_offset = 0xf0 }
-- Row 0x06 (EXE6's with reaches_float_shoe).
collision.breaking = new.collision { flags = { "own_attack", "break" }, row_offset = 0x30 }
-- Row 0x08 (EXE6's with reaches_float_shoe).
collision.chip_destruction = new.collision { flags = { "own_attack", "chip_destruction" }, row_offset = 0x40 }
-- Row 0x12 (EXE6's with reaches_float_shoe).
collision.pushing = new.collision { flags = { "own_attack", "pushing" }, row_offset = 0x90 }
-- Row 0x19 (EXE6's with reaches_float_shoe).
collision.curse = new.collision { flags = { "own_attack", "reaches_submerged", "piercing" }, row_offset = 0xc8 }
-- Row 0x25 (EXE6's with reaches_float_shoe).
collision.attack_480 = new.collision { flags = { "own_attack", "dark" }, row_offset = 0x128 }
-- Row 0x47 (EXE6's with reaches_float_shoe).
collision.attack_a0 = new.collision { flags = { "own_attack", "wind" }, row_offset = 0x238 }
-- Row 0x0e (EXE6's with reaches_float_shoe).
collision.neutral_body = new.collision { flags = { "neutral", "hits_while_dimmed", "break" }, row_offset = 0x70 }
-- Row 0x3d (EXE6's without own_attack).
collision.probe = new.collision { flags = { "own_attack", "reaches_float_shoe" }, row_offset = 0x1e8 }
-- Row 0x00.
collision.nothing = new.collision { flags = {}, row_offset = 0x0 }
-- Row 0x13 (EXE6's with reaches_float_shoe).
collision.own_body = new.collision { flags = { "own_other_body", "hits_while_dimmed" }, row_offset = 0x98 }
-- Row 0x4a (EXE6's with reaches_float_shoe).
collision.second_drill = new.collision { flags = { "own_attack", "dark", "break" }, row_offset = 0x250 }
-- Row 0x32 (EXE6's with reaches_float_shoe).
collision.guard_breaking = new.collision {
    flags = { "own_attack", "no_guard_spark", "breaks_guard" },
    row_offset = 0x190,
}
-- Row 0x2c (EXE6's with reaches_float_shoe).
collision.drain = new.collision {
    flags = { "own_attack", "no_guard_spark", "reaches_submerged", "piercing" },
    row_offset = 0x160,
}
-- Row 0x30 (EXE6's with reaches_float_shoe).
collision.breaking_drain = new.collision {
    flags = { "own_attack", "no_guard_spark", "reaches_submerged", "piercing", "break" },
    row_offset = 0x180,
}
-- Row 0x03.
collision.collision_03 = new.collision {
    flags = { "enemy_attack", "enemy_object", "enemy_other_body", "neutral", "drain" },
    row_offset = 0x18,
}
-- Row 0x09 (EXE6's with reaches_float_shoe).
collision.collision_09 = new.collision { flags = { "own_attack", "drain" }, row_offset = 0x48 }
-- Row 0x11 (EXE6's with reaches_float_shoe).
collision.collision_11 = new.collision { flags = { "own_attack", "sword", "dark" }, row_offset = 0x88 }
-- Row 0x1a (EXE6's with reaches_float_shoe).
collision.collision_1a = new.collision {
    flags = { "own_attack", "chip_destruction", "reaches_submerged", "piercing", "break" },
    row_offset = 0xd0,
}
-- Row 0x1b (EXE6's with reaches_float_shoe).
collision.collision_1b = new.collision { flags = { "own_attack", "no_guard_spark", "wind" }, row_offset = 0xd8 }
-- Row 0x1d (EXE6's with reaches_float_shoe).
collision.collision_1d = new.collision {
    flags = { "own_attack", "chip_destruction", "reaches_submerged", "piercing" },
    row_offset = 0xe8,
}
-- Row 0x1f (EXE6's with reaches_float_shoe).
collision.collision_1f = new.collision { flags = { "own_attack", "reaches_set_objects", "break" }, row_offset = 0xf8 }
-- Row 0x20 (EXE6's with reaches_float_shoe).
collision.collision_20 = new.collision { flags = { "own_attack", "pushing", "reaches_submerged" }, row_offset = 0x100 }
-- Row 0x21 (EXE6's with reaches_float_shoe).
collision.collision_21 = new.collision {
    flags = { "own_attack", "reaches_set_objects", "reaches_submerged", "break" },
    row_offset = 0x108,
}
-- Row 0x22 (EXE6's with reaches_float_shoe).
collision.collision_22 = new.collision {
    flags = {
        "own_attack",
        "enemy_attack",
        "reaches_set_objects",
        "ground_only",
        "reaches_submerged",
        "piercing",
        "break",
    },
    row_offset = 0x110,
}
-- Row 0x23.
collision.collision_23 = new.collision { flags = { "blocker" }, row_offset = 0x118 }
-- Row 0x24 (EXE6's with reaches_float_shoe).
collision.collision_24 = new.collision {
    flags = { "own_attack", "pushing", "dark", "reaches_submerged" },
    row_offset = 0x120,
}
-- Row 0x26 (EXE6's with reaches_float_shoe).
collision.collision_26 = new.collision {
    flags = { "own_attack", "enemy_attack", "reaches_set_objects", "reaches_submerged" },
    row_offset = 0x130,
}
-- Row 0x27 (EXE6's with reaches_float_shoe).
collision.collision_27 = new.collision {
    flags = { "own_attack", "enemy_attack", "reaches_set_objects", "ground_only", "break" },
    row_offset = 0x138,
}
-- Row 0x28 (EXE6's with reaches_float_shoe).
collision.collision_28 = new.collision { flags = { "own_attack", "sword", "piercing", "break" }, row_offset = 0x140 }
-- Row 0x29 (EXE6's with reaches_float_shoe).
collision.collision_29 = new.collision {
    flags = { "own_other_body", "hits_while_dimmed", "break" },
    row_offset = 0x148,
}
-- Row 0x2d (EXE6's with reaches_float_shoe).
collision.collision_2d = new.collision {
    flags = { "own_attack", "no_guard_spark", "reaches_submerged", "break" },
    row_offset = 0x168,
}
-- Row 0x2e (EXE6's with reaches_float_shoe).
collision.collision_2e = new.collision {
    flags = { "own_attack", "no_guard_spark", "piercing", "break" },
    row_offset = 0x170,
}
-- Row 0x2f (EXE6's with reaches_float_shoe).
collision.collision_2f = new.collision {
    flags = { "own_attack", "no_guard_spark", "reaches_submerged" },
    row_offset = 0x178,
}
-- Row 0x31 (EXE6's with reaches_float_shoe).
collision.collision_31 = new.collision {
    flags = { "own_attack", "no_guard_spark", "breaks_guard", "piercing" },
    row_offset = 0x188,
}
-- Row 0x35 (EXE6's with reaches_float_shoe).
collision.collision_35 = new.collision {
    flags = { "own_body", "own_navi", "hits_while_dimmed", "break" },
    row_offset = 0x1a8,
}
-- Row 0x36 (EXE6's with reaches_float_shoe).
collision.collision_36 = new.collision { flags = { "own_attack", "no_guard_spark", "break" }, row_offset = 0x1b0 }
-- Row 0x37 (EXE6's with reaches_float_shoe).
collision.collision_37 = new.collision {
    flags = { "own_other_body", "hits_while_dimmed", "reaches_submerged", "break" },
    row_offset = 0x1b8,
}
-- Row 0x38.
collision.collision_38 = new.collision {
    flags = { "own_body", "enemy_body", "own_other_body", "enemy_other_body", "neutral" },
    row_offset = 0x1c0,
}
-- Row 0x39 (EXE6's with reaches_float_shoe).
collision.collision_39 = new.collision {
    flags = { "own_body", "own_navi", "floating", "hits_while_dimmed", "break" },
    row_offset = 0x1c8,
}
-- Row 0x3a (EXE6's with reaches_float_shoe).
collision.collision_3a = new.collision {
    flags = { "own_body", "own_navi", "hits_while_dimmed", "reaches_submerged", "break" },
    row_offset = 0x1d0,
}
-- Row 0x3b (EXE6's with reaches_float_shoe).
collision.collision_3b = new.collision { flags = { "own_object", "hits_while_dimmed", "break" }, row_offset = 0x1d8 }
-- Row 0x3c (EXE6's with reaches_float_shoe).
collision.collision_3c = new.collision {
    flags = { "own_attack", "no_guard_spark", "reaches_submerged", "break" },
    row_offset = 0x1e0,
}
-- Row 0x3e (EXE6's with reaches_float_shoe).
collision.collision_3e = new.collision {
    flags = { "own_other_body", "floating", "hits_while_dimmed" },
    row_offset = 0x1f0,
}
-- Row 0x3f (EXE6's with reaches_float_shoe).
collision.collision_3f = new.collision {
    flags = { "own_body", "own_navi", "floating", "hits_while_dimmed", "reaches_submerged", "break" },
    row_offset = 0x1f8,
}
-- Row 0x40 (EXE6's with reaches_float_shoe).
collision.collision_40 = new.collision { flags = { "own_object", "hits_while_dimmed", "sword" }, row_offset = 0x200 }
-- Row 0x41.
collision.collision_41 = new.collision { flags = { "enemy_body" }, row_offset = 0x208 }
-- Row 0x42 (EXE6's with reaches_float_shoe).
collision.collision_42 = new.collision { flags = { "own_attack", "sword", "chip_destruction" }, row_offset = 0x210 }
-- Row 0x43 (EXE6's with reaches_float_shoe).
collision.collision_43 = new.collision { flags = { "reaches_set_objects" }, row_offset = 0x218 }
-- Row 0x44 (EXE6's with reaches_float_shoe).
collision.collision_44 = new.collision {
    flags = { "own_object", "reaches_set_objects", "hits_while_dimmed" },
    row_offset = 0x220,
}
-- Row 0x45 (EXE6's with reaches_float_shoe).
collision.collision_45 = new.collision {
    flags = { "own_attack", "sword", "reaches_submerged", "break" },
    row_offset = 0x228,
}
-- Row 0x46 (EXE6's with reaches_float_shoe).
collision.collision_46 = new.collision {
    flags = { "own_attack", "hits_while_dimmed", "no_guard_spark", "wind" },
    row_offset = 0x230,
}
-- Row 0x48 (EXE6's with reaches_float_shoe).
collision.hitbox = new.collision { flags = { "own_attack", "enemy_attack", "reaches_set_objects" }, row_offset = 0x240 }
-- Row 0x4b (EXE6's with reaches_float_shoe).
collision.collision_4b = new.collision {
    flags = { "own_attack", "pushing", "dark", "reaches_submerged" },
    row_offset = 0x258,
}
-- Row 0x4c (EXE6's with reaches_float_shoe).
collision.collision_4c = new.collision {
    flags = { "own_other_body", "hits_while_dimmed", "no_guard_spark", "break" },
    row_offset = 0x260,
}
-- Row 0x4d.
collision.collision_4d = new.collision {
    flags = { "enemy_attack", "enemy_object", "enemy_body", "enemy_other_body", "pull" },
    row_offset = 0x268,
}
-- Row 0x2b: a 12-panel thunder ball's, DarkThnd's (0x080C9FA0) (EXE6 names none).
collision.collision_2b = new.collision { flags = { "own_attack", "dark", "reaches_submerged" }, row_offset = 0x158 }
-- Row 0x34: Blinder's flash (0x080E3134) (EXE6's with reaches_float_shoe, which EXE6 names none).
collision.collision_34 = new.collision { flags = { "own_attack", "no_guard_spark", "piercing" }, row_offset = 0x1a0 }

return collision
