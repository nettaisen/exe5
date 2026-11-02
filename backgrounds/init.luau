--!strict
-- EXE5's backgrounds' definitions (the root's `backgrounds`): each background's music, the battle theme a round drawn
-- on it plays where the player picked none (docs/app.md §1, "The battle's music"). Each is the theme most of the
-- original's battles on it start (their settings' byte 2; a battle draws the background its settings state, or with
-- 0xFF its map's): the random encounters of the maps that draw it (0x0810F5CC; the encounter lists 0x0801C96C, virus
-- battles but for a conditional navi), the battles their scripts start (list0, 0x08113BF0, by cutscene command 0x53,
-- map-script command 0x26 and the net's coordinate triggers) and the liberations' (list1, 0x081147A4). Lan's HP has
-- no encounters, and its three scripted battles are virus battles (records 23 to 25). A comp or dungeon that ends in
-- a story navi's battle has the boss battles' (the user's pick: by count every one would be the virus battles', its
-- encounters outnumbering them).

return {
    asset.background("acdc-area", { music = asset.sound("virus-battle") }),
    asset.background("comp", { music = asset.sound("virus-battle") }),
    asset.background("comp-alt", { music = asset.sound("virus-battle") }),
    asset.background("dexs-hp", { music = asset.sound("virus-battle") }),
    -- DrillComp4's navi battle ends its dungeon.
    asset.background("drill-comp", { music = asset.sound("boss-battle") }),
    asset.background("end-area", { music = asset.sound("virus-battle") }),
    -- FactoryComp1 to 4's navi battles, one each.
    asset.background("factory-comp", { music = asset.sound("boss-battle") }),
    asset.background("gargcastle-hp", { music = asset.sound("virus-battle") }),
    -- GargoylComp3's two navi battles end its dungeon.
    asset.background("gargoyle-comp", { music = asset.sound("boss-battle") }),
    asset.background("lans-hp", { music = asset.sound("virus-battle") }),
    -- MainComp2's navi battle ends its dungeon.
    asset.background("main-comp", { music = asset.sound("boss-battle") }),
    asset.background("mayls-hp", { music = asset.sound("virus-battle") }),
    asset.background("nebula-area", { music = asset.sound("virus-battle") }),
    -- No map's: the two battles against NebulaGray (records 79 and 104, started on SoulServComp) state it.
    asset.background("nebulagray", { music = asset.sound("final-battle") }),
    asset.background("oran-area", { music = asset.sound("virus-battle") }),
    asset.background("scilab-area", { music = asset.sound("virus-battle") }),
    asset.background("scilab-hp", { music = asset.sound("virus-battle") }),
    -- ShipComp3's navi battle ends its dungeon.
    asset.background("ship-comp", { music = asset.sound("boss-battle") }),
    asset.background("soulserv-comp", { music = asset.sound("virus-battle") }),
    asset.background("undernet", { music = asset.sound("virus-battle") }),
    asset.background("visionburst", { music = asset.sound("virus-battle") }),
    asset.background("yais-hp", { music = asset.sound("virus-battle") }),
}
