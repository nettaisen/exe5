--!strict
-- The patch card Mr.-Match's Custom (47, ヒノケンの カスタマイズ in the Japanese games), 35 MB.

local cards = require("../rules/patch_cards/cards")

local card: PatchCard = {
    mb = 35,
    effects = {
        cards.hp(300),
        cards.body(Element.fire),
    },
}

return { ["mr-matchs-custom"] = card }
