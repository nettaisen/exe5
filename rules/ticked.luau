--!strict
-- Whether the rules' `navi_tick` runs for the side's navi (its `ticked`): while it has something to do, a swing bug's
-- (./emotion: the bug a round's NaviCust, a hit's curse or a party switch brings) or an armed Chaos Unison charge's
-- (./souls/chaos_charge). (A navi keeps its slot on its side's list for its life: the swing notes it as the round
-- starts.)

local ticked = {}

function ticked.update(side: number)
    local navi = battle.player(side)
    if navi ~= nil then
        navi.ticked = battle.navi(side).emotion_bug ~= 0 or navi.b_charge_time ~= nil
    end
end

return ticked
