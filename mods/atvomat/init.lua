-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

atvomat = {} -- i like global namespaces for people who like making silly dependancies

dofile(minetest.get_modpath("atvomat").."/breaker.lua") -- automated block breaker
dofile(minetest.get_modpath("atvomat").."/compressor.lua") -- compresses ingots/gems into block form
dofile(minetest.get_modpath("atvomat").."/crusher.lua") -- crushes ore blocks, and other blocks
dofile(minetest.get_modpath("atvomat").."/logger.lua") -- automatically kills and plants trees
dofile(minetest.get_modpath("atvomat").."/mover.lua") -- takes and inserts items into containers
dofile(minetest.get_modpath("atvomat").."/scrapper.lua") -- destroys items every now and then
dofile(minetest.get_modpath("atvomat").."/sorter.lua") -- sorts items all the time, everytime
dofile(minetest.get_modpath("atvomat").."/switchsort.lua") -- sends items elsewhere if it cant put items into the container
dofile(minetest.get_modpath("atvomat").."/tools.lua") -- engineers tools.

-- crafting recipes here, meatbag

atvomat.compressor_recipes = {}

atvomat.crusher_recipes = {}

atvomat.logger_control = {}

-- items that can be compressed, format is input, amount -> output, amount

atvomat.compressor_recipes["iron"] =    {"core:iron_ingot",   9,  "core:iron_block",    1}
atvomat.compressor_recipes["copper"] =  {"core:copper_ingot", 9,  "core:copper_block",  1}
atvomat.compressor_recipes["ironze"] =  {"core:ironze_ingot", 9,  "core:ironze_block",  1}
atvomat.compressor_recipes["gold"] =    {"core:gold_ingot",   9,  "core:gold_block",    1}
atvomat.compressor_recipes["silver"] =  {"core:silver_ingot", 9,  "core:silver_block",  1}
atvomat.compressor_recipes["mese"] =    {"core:mese_crystal", 9,  "core:mese",          1}
atvomat.compressor_recipes["diamond"] = {"core:diamond",      9,  "core:diamond_block", 1}

-- crusher recipes, input, amount -> output, amount

atvomat.crusher_recipes["cobble"] =  {"core:stone",       1, "core:cobble",       1}
atvomat.crusher_recipes["gravel"] =  {"core:cobble",      1, "core:gravel",       1}
atvomat.crusher_recipes["sand"]   =  {"core:gravel",      1, "core:sand",         1}
atvomat.crusher_recipes["clay"]   =  {"core:dirt",        1, "core:clay",         1}

--atvomat.crusher_recipes["brick"] = {"core:bricks",      1, "core:brick",        4}

atvomat.crusher_recipes["iron"]   =  {"core:iron_ore",    1, "core:iron_dust",    4}
atvomat.crusher_recipes["copper"] =  {"core:copper_ore",  1, "core:copper_dust",  4}
atvomat.crusher_recipes["gold"] =    {"core:gold_ore",    1, "core:gold_dust",    4}
atvomat.crusher_recipes["silver"] =  {"core:silver_ore",  1, "core:silver_dust",  4}
atvomat.crusher_recipes["mese"] =    {"core:mese_ore",    1, "core:mese_crystal", 4}
atvomat.crusher_recipes["diamond"] = {"core:diamond_ore", 1, "core:diamond",      4}

-- dyes (15 colours currently)
atvomat.crusher_recipes["reddye"] =       {"", 1,  "dye:red",        4}
atvomat.crusher_recipes["orangedye"] =    {"", 1,  "dye:orange",     4}
atvomat.crusher_recipes["yellowdye"] =    {"", 1,  "dye:yellow",     4}
atvomat.crusher_recipes["limedye"] =      {"", 1,  "dye:lime",       4}
atvomat.crusher_recipes["greendye"] =     {"", 1,  "dye:green",      4}
atvomat.crusher_recipes["darkgreendye"] = {"", 1,  "dye:dark_green", 4}
atvomat.crusher_recipes["cyandye"] =      {"", 1,  "dye:cyan",       4}
atvomat.crusher_recipes["bluedye"] =      {"", 1,  "dye:blue",       4}
atvomat.crusher_recipes["magenta"] =      {"", 1,  "dye:magenta",    4}
atvomat.crusher_recipes["purple"] =       {"", 1,  "dye:purple",     4}
atvomat.crusher_recipes["violet"] =       {"", 1,  "dye:violet",     4}
atvomat.crusher_recipes["white"] =        {"", 1,  "dye:white",      4}
atvomat.crusher_recipes["lightgrey"] =    {"", 1,  "dye:light_grey", 4}
atvomat.crusher_recipes["grey"] =         {"", 1,  "dye:grey",       4}
atvomat.crusher_recipes["black"] =        {"", 1,  "dye:black",      4}

-- logger control, register trees here, format: tree_log, leaves, sapling_name

-- note, evergreen trees are currently unsupported.

atvomat.logger_control["oak"]    = {"core:oak_log",    "core:oak_leaves",    "core:oak_sapling"}
atvomat.logger_control["birch"]  = {"core:birch_log",  "core:birch_leaves",  "core:birch_sapling"}
atvomat.logger_control["cherry"] = {"core:cherry_log", "core:cherry_leaves", "core:cherry_sapling"}

-- sorting control card for sorting blocks, format: "name:ingot", "etc", "etc", "etc"

-- will migrate these to a format which can be paired over instead of ipairs.

-- actually, consider the following

-- atvomat.itemtype_sort["item:name"] = ""

atvomat.ingot_sort = {} -- register ingots and gems

atvomat.ingot_sort["core:iron_ingot"] = ""
atvomat.ingot_sort["core:copper_ingot"] = ""
atvomat.ingot_sort["core:ironze_ingot"] = ""
atvomat.ingot_sort["core:gold_ingot"] = ""
atvomat.ingot_sort["core:silver_ingot"] = ""
atvomat.ingot_sort["core:mese_crystal"] = ""
atvomat.ingot_sort["core:diamond"] = ""

atvomat.ingot_block_sort = {} -- register ingot and gem blocks

atvomat.ingot_block_sort["core:iron_block"] = ""
atvomat.ingot_block_sort["core:copper_block"] = ""
atvomat.ingot_block_sort["core:ironze_block"] = ""
atvomat.ingot_block_sort["core:gold_block"] = ""
atvomat.ingot_block_sort["core:silver_block"] = ""
atvomat.ingot_block_sort["core:mese"] = ""
atvomat.ingot_block_sort["core:diamond_block"] = ""

atvomat.ore_sort = {} -- register ores

atvomat.ore_sort["core:iron_ore"] = ""
atvomat.ore_sort["core:copper_ore"] = ""
atvomat.ore_sort["core:gold_ore"] = ""
atvomat.ore_sort["core:silver_ore"] = ""
atvomat.ore_sort["core:mese_ore"] = ""
atvomat.ore_sort["core:diamond_ore"] = ""
atvomat.ore_sort["core:coal_ore"] = ""

atvomat.dye_sort = {} -- register dyes

atvomat.dye_sort["dye:red"] = ""
atvomat.dye_sort["dye:orange"] = ""
atvomat.dye_sort["dye:yellow"] = ""
atvomat.dye_sort["dye:lime"] = ""
atvomat.dye_sort["dye:green"] = ""
atvomat.dye_sort["dye:dark_green"] = ""
atvomat.dye_sort["dye:cyan"] = ""
atvomat.dye_sort["dye:blue"] = ""
atvomat.dye_sort["dye:brown"] = ""
atvomat.dye_sort["dye:magenta"] = ""
atvomat.dye_sort["dye:purple"] = ""
atvomat.dye_sort["dye:violet"] = ""
atvomat.dye_sort["dye:white"] = ""
atvomat.dye_sort["dye:light_grey"] = ""
atvomat.dye_sort["dye:grey"] = ""
atvomat.dye_sort["dye:black"] = ""

atvomat.wood_sort = {} -- register logs, planks, leaves and saplings

atvomat.wood_sort["core:oak_log"] = ""
atvomat.wood_sort["core:oak_log_grassy"] = ""
atvomat.wood_sort["core:oak_leaves"] = ""
atvomat.wood_sort["core:oak_planks"] = ""
atvomat.wood_sort["core:oak_sapling"] = ""

atvomat.wood_sort["core:pine_log"] = ""
atvomat.wood_sort["core:pine_log_grassy"] = ""
atvomat.wood_sort["core:pine_needles"] = ""
atvomat.wood_sort["core:pine_needles_snowy"] = ""
atvomat.wood_sort["core:pine_planks"] = ""
atvomat.wood_sort["core:pine_sapling"] = ""

atvomat.wood_sort["core:cherry_log"] = ""
atvomat.wood_sort["core:cherry_log_grassy"] = ""
atvomat.wood_sort["core:cherry_leaves"] = ""
atvomat.wood_sort["core:cherry_planks"] = ""
atvomat.wood_sort["core:cherry_sapling"] = ""
atvomat.wood_sort["core:fallen_cherry_leaves"] = ""

atvomat.wood_sort["core:birch_log"] = ""
atvomat.wood_sort["core:birch_log_grassy"] = ""
atvomat.wood_sort["core:birch_leaves"] = ""
atvomat.wood_sort["core:birch_sapling"] = ""
atvomat.wood_sort["core:birch_planks"] = ""

atvomat.farm_sort = {} -- register food, seeds, and plant matter

atvomat.farm_sort["farming:cocoa_beans"] = ""
atvomat.farm_sort["farming:cookie"] = ""
atvomat.farm_sort["farming:chocolate_dark"] = ""
atvomat.farm_sort["farming:coffee_beans"] = ""
atvomat.farm_sort["farming:drinking_cup"] = ""
atvomat.farm_sort["farming:coffee_cup"] = ""
atvomat.farm_sort["farming:coffee_cup_hot"] = ""
atvomat.farm_sort["farming:corn"] = ""
atvomat.farm_sort["farming:corn_cob"] = ""
atvomat.farm_sort["farming:bottle_ethanol"] = ""
atvomat.farm_sort["farming:seed_cotton"] = ""
atvomat.farm_sort["farming:cotton"] = ""
atvomat.farm_sort["farming:string"] = ""
atvomat.farm_sort["farming:cucumber"] = ""
atvomat.farm_sort["farming:donut"] = ""
atvomat.farm_sort["farming:donut_chocolate"] = ""
atvomat.farm_sort["farming:donut_apple"] = ""
atvomat.farm_sort["farming:grapes"] = ""
atvomat.farm_sort["farming:trellis"] = ""
atvomat.farm_sort["farming:melon_slice"] = ""
atvomat.farm_sort["farming:melon_8"] = ""
atvomat.farm_sort["farming:potato"] = ""
atvomat.farm_sort["farming:baked_potato"] = ""
atvomat.farm_sort["farming:pumpkin"] = ""
atvomat.farm_sort["farming:pumpkin_slice"] = ""
atvomat.farm_sort["farming:jackolantern"] = ""
atvomat.farm_sort["farming:pumpkin_bread"] = ""
atvomat.farm_sort["farming:pumpkin_dough"] = ""
atvomat.farm_sort["farming:raspberries"] = ""
atvomat.farm_sort["farming:smoothie_raspberry"] = ""
atvomat.farm_sort["farming:rhubarb"] = ""
atvomat.farm_sort["farming:rhubarb_pie"] = ""
atvomat.farm_sort["farming:sugar"] = ""
atvomat.farm_sort["core:papyrus"] = ""
atvomat.farm_sort["core:cactus"] = ""
atvomat.farm_sort["farming:carrot"] = ""
atvomat.farm_sort["farming:carrot_gold"] = ""
atvomat.farm_sort["farming:blueberries"] = ""
atvomat.farm_sort["farming:muffin_blueberry"] = ""
atvomat.farm_sort["farming:beans"] = ""
atvomat.farm_sort["farming:beanpole"] = ""
atvomat.farm_sort["farming:seed_barley"] = ""
atvomat.farm_sort["farming:barley"] = ""
atvomat.farm_sort["farming:flour"] = ""
atvomat.farm_sort["farming:seed_wheat"] = ""
atvomat.farm_sort["farming:wheat"] = ""
atvomat.farm_sort["farming:straw"] = ""
atvomat.farm_sort["farming:flour"] = ""
atvomat.farm_sort["farming:bread"] = ""
atvomat.farm_sort["farming:toast"] = ""
atvomat.farm_sort["farming:tomato"] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""
-- atvomat.farm_sort[""] = ""

atvomat.tool_sort = {} -- todo, write a function that gets all registered tools except hands.

atvomat.fuel_sort = {} -- todo, write a small function worth a million dollars to add burntime items to the list.

-- functions to fill tool_sort and fuel_sort:

local function find_fuel_items()

	for k, v in pairs(minetest.registered_items) do
	
		local burntime = minetest.get_craft_result({method = "fuel", width = 1, items = {ItemStack(k)}}).time
		
		if burntime == 0 then
		
			-- do shit all, we want the name of the item and making sure it has a goddamn burntime that isn't 0.
			
		else
	
			atvomat.fuel_sort[k] = ""
		
		end
	
		
	end
	
end

minetest.after(1, find_fuel_items)

local function find_tools()

	for k, v in pairs(minetest.registered_items) do
	
		local itemtype = minetest.registered_items[k].type
		
		if itemtype == "tool" then
		
			atvomat.tool_sort[k] = ""
			
		else
		
			--bugger off, type returns item or node for anything else.
			
		end
	
	end

end

minetest.after(1.2, find_tools)

-- register craftitems as sorter cards

--[[

Order of preference of sorting cards:

Wood
Ore
Ingot
Block
Tools
Dye
Farm
Fuel
Eject

]]--

minetest.register_craftitem("atvomat:ore_sorter_card", {

	description = "Sorts Ores",
	inventory_image = "atvomat_card_ore.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:ingot_sorter_card", {

	description = "Sorts Ingots and Gems (Not Ingot and Gem Blocks)",
	inventory_image = "atvomat_card_ingot.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:block_sorter_card", {

	description = "Sorts Ingot and Gem Blocks (Not Ingots and Gems)",
	inventory_image = "atvomat_card_block.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:dye_sorter_card", {

	description = "Sorts Dyes",
	inventory_image = "atvomat_card_dye.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:wood_sorter_card", {

	description = "Sorts Planks, Logs, Leaves and Saplings",
	inventory_image = "atvomat_card_wood.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:fuel_sorter_card", {

	description = "Sorts Fuels",
	inventory_image = "atvomat_card_fuel.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:farm_sorter_card", {

	description = "Sorts Seeds, Food and Farming Resources",
	inventory_image = "atvomat_card_farm.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:tool_sorter_card", {

	description = "Sorts Tools and Hoes.",
	inventory_image = "atvomat_card_tool.png",
	
	groups = {sorter_card=1},

})

minetest.register_craftitem("atvomat:eject_card", {

	description = "Ejects extra items to the selected face.",
	inventory_image = "atvomat_card_eject.png",
	
	groups = {sorter_card=1},

})