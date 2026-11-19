--!strict
-- The DS's Double Attacks (docs/design/exe5ds-map.md §5), the chips whose `double_attack` the party battle's switch
-- fires (rules/double_attacks), in the DS's order (its chips 0x160 on). Each module defines its chip, the attack its
-- navis make (lib/double_attack) and what it draws; the chips' index (chips/init.luau) has them too.

return {
    require("@self/double_hero").double_hero,
    require("@self/magnet_zan").magnet_zan,
    require("@self/magnet_air_raid").magnet_air_raid,
    require("@self/double_vulcan").double_vulcan,
    require("@self/cross_scope").cross_scope,
    require("@self/chemical_bomb").chemical_bomb,
    require("@self/blind_rain_rush").blind_rain_rush,
    require("@self/broken_shoot").broken_shoot,
    require("@self/engetsu_sappou").engetsu_sappou,
    require("@self/knight_throw").knight_throw,
    require("@self/kokubankeshi_bomb").kokubankeshi_bomb,
    require("@self/gama_otoshi").gama_otoshi,
}
