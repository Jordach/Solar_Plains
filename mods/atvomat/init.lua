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

atvomat.ingot_sort = {}

atvomat.ingot_block_sort = {}

atvomat.ore_sort = {}

atvomat.dye_sort = {}

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

atvomat.ingot_sort = {

	"core:iron_ingot",
	"core:copper_ingot",
	"core:ironze_ingot",
	"core:gold_ingot",
	"core:silver_ingot",
	"core:mese_crystal",
	"core:diamond"

}

atvomat.ingot_block_sort = {

	"core:iron_block",
	"core:copper_block",
	"core:ironze_block",
	"core:gold_block",
	"core:silver_block",
	"core:mese",
	"core:diamond_block",

}

atvomat.ore_sort = {

	"core:iron_ore",
	"core:copper_ore",
	"core:gold_ore",
	"core:silver_ore",
	"core:mese_ore",
	"core:diamond_ore",

}

atvomat.dye_sort = {

	"dye:red"
	"dye:orange"
	"dye:yellow"
	"dye:lime"
	"dye:green"
	"dye:dark_green"
	"dye:cyan"
	"dye:blue"
	"dye:magenta"
	"dye:purple"
	"dye:violet"
	"dye:white"
	"dye:light_grey"
	"dye:grey"
	"dye:black"

}