--!strict
-- EXE5's soul change's first step (0x08011FAC): the navi no longer moves, flinches, is paralyzed or slides, and
-- forgets a slide request and its slide's step (flags 0x1C40 and flag2 0x10: a part of EXE6's `sub_80158FA`).
return function(navi: Object)
    navi:set_status("sliding", false)
    navi:set_status("paralyzed", false)
    navi:set_status("flinching", false)
    navi:set_status("moving", false)
    navi:set_request("slide", false)
    navi.slide_step = "start"
end
