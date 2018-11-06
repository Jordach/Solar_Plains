-- naturum
-- replacement for farming_plus
-- License: what's a license

-- things to alias from farming plus:

--[[

    hoes

    wheat, seeds, flour, toast
    potatos
    carrots
    pumpkins
    melons
    berry bushes (alias the actual plantables, not things)
    cocoa
    corn
    cotton -> rename to flax and hemp respectively
    cucumbers
    rhubarb
    sugar
    tomatos
    strawberries (the food, not nodes)

]]

-- add the crushing hammer

--[[

    list of known in world recipes:

    stone -> cobble
    cobble -> gravel
    gravel -> sand
    sand -> dust

]]

-- compost barrel

--[[

    compost barrel recipes:

    dust + water = clay
    8 compostable items + time = 1 dirt
    water + lava + iron compost barrel = obsidian

]]

-- berry bushes

--[[

    starfruit (only grows during day, rare)
    moonfruit (only grows at night, rare)
    blueberries
    raspberries
    blackberries
    grapes

]]

-- salt ore

-- used for making crisps and such

-- cookware (reuseable)

--[[

    knife? see below
    chopping board (knife included?)
    frying pan
    saucepan
    bowl
    mixing spoon
    baking tray

]]

-- to add:

--[[

    coffee (and lava coffee)
    coffee machine

]]

-- Init all the TINGS

naturum = {}

-- kickstart our ~~workbench~~ sub components

dofile(minetest.get_modpath("naturum").."/grow_lib.lua")
dofile(minetest.get_modpath("naturum").."/mapgen.lua")
dofile(minetest.get_modpath("naturum").."/wheat.lua")
dofile(minetest.get_modpath("naturum").."/farmland.lua")
--dofile(minetest.get_modpath("naturum").."/potato.lua")
--dofile(minetest.get_modpath("naturum").."/carrot.lua")
--dofile(minetest.get_modpath("naturum").."/pumpkin.lua")
--dofile(minetest.get_modpath("naturum").."/melon.lua")
--dofile(minetest.get_modpath("naturum").."/cocoa.lua")
--dofile(minetest.get_modpath("naturum").."/corn.lua")
--dofile(minetest.get_modpath("naturum").."/cucumber.lua")
--dofile(minetest.get_modpath("naturum").."/rhubarb.lua")
--dofile(minetest.get_modpath("naturum").."/sugar.lua")
--dofile(minetest.get_modpath("naturum").."/tomato.lua")
--dofile(minetest.get_modpath("naturum").."/crammer.lua")
--dofile(minetest.get_modpath("naturum").."/berries.lua")
--dofile(minetest.get_modpath("naturum").."/melon.lua")
--dofile(minetest.get_modpath("naturum").."/coffee.lua")
--dofile(minetest.get_modpath("naturum").."/salt.lua")

--dofile(minetest.get_modpath("naturum").."/utensils.lua")
--dofile(minetest.get_modpath("naturum").."/crafting.lua")
--dofile(minetest.get_modpath("naturum").."/food.lua")