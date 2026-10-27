--!strict
-- What is a version's own, which the pack takes from a ROM of that version (its US ROM: Team ProtoMan's
-- `MEGAMAN5_TP_BRBE`, Team Colonel's `MEGAMAN5_TC_BRKE`; Team ProtoMan's is the base version). The same code reaches
-- them in every ROM, so the places are the other modules'; here is which of them are a version's.
--
-- - The version chips: EXE5 interleaves the teams' Giga chips, unlike EXE6 (`VERSION_CHIPS`).
-- - The team navis' own chips, whose pictures each team's ROM has in its own palettes (`OWN_CHIPS`).
-- - The emotion window's soul faces, the team navis' faces and emblems, and the soul icons' palette (hud.luau's and
--   custom.luau's: the six souls and navis of each team are its ROM's).
-- - The portraits each team's ROM has a placeholder for (sprites.luau's).
-- - The songs that play otherwise in Team Colonel's ROM (init.luau's sound).

local versions = {}

-- The versions, as the pack has what is a version's own under (`-protoman`, `-colonel`, as EXE6's packs name theirs
-- `-falzar`/`-gregar`; its base version first).
versions.PROTOMAN = "protoman"
versions.COLONEL = "colonel"

-- Each version's US ROM: the pack has a version's own from it.
function versions.rom(set: Set, version: string?): Rom
    return if version == versions.COLONEL then set.BRKE else set.BRBE
end

-- The version chips, by chip, from the original libraries. EXE5 interleaves the teams' Giga chips, unlike EXE6.
local VERSION_CHIPS: { [number]: string } = {
    [0x12D] = versions.PROTOMAN,
    [0x12E] = versions.PROTOMAN,
    [0x12F] = versions.PROTOMAN,
    [0x130] = versions.COLONEL,
    [0x131] = versions.COLONEL,
    [0x132] = versions.COLONEL,
    [0x133] = versions.PROTOMAN,
    [0x134] = versions.PROTOMAN,
    [0x135] = versions.COLONEL,
    [0x136] = versions.COLONEL,
    [0x139] = versions.COLONEL,
    [0x13A] = versions.PROTOMAN,
}

-- The team navis' own chips (the custom screen's table of them, 0x08025EA0: two halfwords a navi, navis 1 to 12, each
-- the chip's id under its code), each with its navi's team's version. The two US ROMs hold an own chip's picture and
-- icon alike but under different palettes: a console shows its own team's navis' chips in the palette its ROM has for
-- them, and never shows the other team's (their navis aren't its PET's). So an own chip's picture is its team's ROM's,
-- on any console.
local OWN_CHIPS: { [number]: string } = {
    [0x191] = versions.PROTOMAN,
    [0x192] = versions.PROTOMAN,
    [0x195] = versions.PROTOMAN,
    [0x196] = versions.PROTOMAN,
    [0x198] = versions.PROTOMAN,
    [0x19A] = versions.PROTOMAN,
    [0x19D] = versions.COLONEL,
    [0x19E] = versions.COLONEL,
    [0x1A1] = versions.COLONEL,
    [0x1A2] = versions.COLONEL,
    [0x1A5] = versions.COLONEL,
    [0x1A6] = versions.COLONEL,
}

-- The version chip `id` belongs to; none for a chip of both.
function versions.chip_version(id: number): string?
    return VERSION_CHIPS[id]
end

-- The team whose navi's own chip `id` is; none for any other chip.
function versions.own_chip_version(id: number): string?
    return OWN_CHIPS[id]
end

return versions
