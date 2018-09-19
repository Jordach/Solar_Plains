-- tools;

-------------------------------------------

-- wooden tier;

minetest.register_craft({
	output = "core:wooden_pickaxe",
	recipe = {
		{"group:planks", "group:planks", "group:planks"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:wooden_shovel",
	recipe = {
		{"", "group:planks", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:wooden_axe",
	recipe = {
		{"group:planks", "group:planks", ""},
		{"group:planks", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:wooden_sword",
	recipe = {
		{"", "group:planks", ""},
		{"", "group:planks", ""},
		{"", "group:stick", ""},
	}
})


-- stone tier;

minetest.register_craft({
	output = "core:stone_pickaxe",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:stone_shovel",
	recipe = {
		{"", "group:stone", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:stone_axe",
	recipe = {
		{"group:stone", "group:stone", ""},
		{"group:stone", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:stone_sword",
	recipe = {
		{"", "group:stone", ""},
		{"", "group:stone", ""},
		{"", "group:stick", ""},
	}
})

-- iron tier;

minetest.register_craft({
	output = "core:iron_pickaxe",
	recipe = {
		{"core:iron_ingot", "core:iron_ingot", "core:iron_ingot"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:iron_shovel",
	recipe = {
		{"", "core:iron_ingot", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:iron_axe",
	recipe = {
		{"core:iron_ingot", "core:iron_ingot", ""},
		{"core:iron_ingot", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:iron_sword",
	recipe = {
		{"", "core:iron_ingot", ""},
		{"", "core:iron_ingot", ""},
		{"", "group:stick", ""},
	}
})

-- ironze tier;

minetest.register_craft({
	output = "core:ironze_pickaxe",
	recipe = {
		{"core:ironze_ingot", "core:ironze_ingot", "core:ironze_ingot"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:ironze_shovel",
	recipe = {
		{"", "core:ironze_ingot", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:ironze_axe",
	recipe = {
		{"core:ironze_ingot", "core:ironze_ingot", ""},
		{"core:ironze_ingot", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:ironze_sword",
	recipe = {
		{"", "core:ironze_ingot", ""},
		{"", "core:ironze_ingot", ""},
		{"", "group:stick", ""},
	}
})

-- mese tier;

minetest.register_craft({
	output = "core:mese_pickaxe_1 1 65535",
	recipe = {
		{"core:mese_crystal", "core:mese_crystal", "core:mese_crystal"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:mese_shovel_1 1 65535",
	recipe = {
		{"", "core:mese_crystal", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:mese_axe_1 1 65535",
	recipe = {
		{"core:mese_crystal", "core:mese_crystal", ""},
		{"core:mese_crystal", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:mese_sword_1 1 65535",
	recipe = {
		{"", "core:mese_crystal", ""},
		{"", "core:mese_crystal", ""},
		{"", "group:stick", ""},
	}
})


-- diamond tier;

minetest.register_craft({
	output = "core:diamond_pickaxe",
	recipe = {
		{"core:diamond", "core:diamond", "core:diamond"},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:diamond_shovel",
	recipe = {
		{"", "core:diamond", ""},
		{"", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:diamond_axe",
	recipe = {
		{"core:diamond", "core:diamond", ""},
		{"core:diamond", "group:stick", ""},
		{"", "group:stick", ""},
	}
})

minetest.register_craft({
	output = "core:diamond_sword",
	recipe = {
		{"", "core:diamond", ""},
		{"", "core:diamond", ""},
		{"", "group:stick", ""},
	}
})

-- blocks;

minetest.register_craft({
	output = "core:torch 6",
	recipe = {
		{"core:coal_lump"},
		{"group:stick"},
	}
})

minetest.register_craft({
	output = "core:chest",
	recipe = {
		{"group:planks", "group:planks", "group:planks"},
		{"group:planks", "", "group:planks"},
		{"group:planks", "group:planks", "group:planks"},
	}
})

minetest.register_craft({
	output = "core:furnace",
	recipe = {
		{"group:stone", "group:stone", "group:stone"},
		{"group:stone", "", "group:stone"},
		{"group:stone", "group:stone", "group:stone"},
	}
})

minetest.register_craft({
	output = "core:chest_locked",
	recipe = {
		{"group:planks", "group:planks", "group:planks"},
		{"group:planks", "core:iron_ingot", "group:planks"},
		{"group:planks", "group:planks", "group:planks"},
	}
})

-- alloy ironze

minetest.register_craft({
	output = "core:uncooked_ironze_ingot 2",
	recipe = {
		{"core:iron_ingot", "core:copper_ingot"},
		{"core:copper_ingot", "core:copper_ingot"},
	}
})

-----------------------------------

-- planks

minetest.register_craft({
	type = "shapeless",
	output = "core:oak_planks 6",
	recipe = {
		"core:oak_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:oak_planks 6",
	recipe = {
		"core:oak_log_grassy",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:pine_planks 6",
	recipe = {
		"core:pine_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:pine_planks 6",
	recipe = {
		"core:pine_log_grassy",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:birch_planks 6",
	recipe = {
		"core:birch_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:birch_planks 6",
	recipe = {
		"core:birch_log_grassy",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:cherry_planks 6",
	recipe = {
		"core:cherry_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:cherry_planks 6",
	recipe = {
		"core:cherry_log_grassy",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:acacia_planks 6",
	recipe = {
		"core:acacia_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:acacia_planks 6",
	recipe = {
		"core:acacia_log_grassy",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:wimba_planks 6",
	recipe = {
		"core:wimba_log",
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:wimba_planks 6",
	recipe = {
		"core:wimba_log_grassy",
	},
})

-- craft some grassy versions of logs

minetest.register_craft({
	type = "shapeless",
	output = "core:oak_log_grassy 1",
	recipe = {
		"core:oak_log",
		"core:grass_1"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:pine_log_grassy 1",
	recipe = {
		"core:pine_log",
		"core:grass_1"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:birch_log_grassy 1",
	recipe = {
		"core:birch_log",
		"core:grass_1"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:cherry_log_grassy 1",
	recipe = {
		"core:cherry_log",
		"core:grass_1"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:acacia_log_grassy 1",
	recipe = {
		"core:acacia_log",
		"core:grass_wild_1"
	},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:wimba_log_grassy 1",
	recipe = {
		"core:wimba_log",
		"core:grass_wild_1"
	},
})


-- sticks

minetest.register_craftitem("core:stick", {
	description = "A Stick",
	inventory_image = "core_stick.png",
	groups = {furnace_fuel=1, stick=1},
})


minetest.register_craft({
	type = "shapeless",
	output = "core:stick 8",
	recipe = {
		"group:planks",
	},
})

-- stones

minetest.register_craft({

	output = "core:basalt_brick 4",
	recipe = {
	
		{"core:basalt", "core:basalt"},
		{"core:basalt", "core:basalt"},
	
	},
	

})

minetest.register_craft({

	output = "core:basalt 4",
	recipe = {
	
		{"core:basalt_brick", "core:basalt_brick"},
		{"core:basalt_brick", "core:basalt_brick"},
	
	},
	

})

minetest.register_craft({

	output = "core:obsidian_brick 4",
	recipe = {
	
		{"core:obsidian", "core:obsidian"},
		{"core:obsidian", "core:obsidian"},
	
	},

})

minetest.register_craft({

	output = "core:obsidian 4",
	recipe = {
	
		{"core:obsidian_brick", "core:obsidian_brick"},
		{"core:obsidian_brick", "core:obsidian_brick"},
	
	},

})

----------

-- ores

minetest.register_craftitem("core:coal_lump", {
	description = "Lump of Coal",
	inventory_image = "core_coal_lump.png",
	groups = {coal=1, furnace_fuel=1},
})

minetest.register_craft({
	type = "cooking",
	output = "core:stone",
	recipe = "core:cobble",
})

-- ingots :)

minetest.register_craftitem("core:copper_ingot", {
	description = "Copper Ingot",
	inventory_image = "core_copper_ingot.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

minetest.register_craftitem("core:iron_ingot", {
	description = "Iron Ingot",
	inventory_image = "core_iron_ingot.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

minetest.register_craftitem("core:uncooked_ironze_ingot", {
	description = "Uncooked Ironze Ingot...what?!",
	inventory_image = "core_ironze_uncooked_ingot.png",
	groups = {cooking_multiplier=1},
})

minetest.register_craftitem("core:ironze_ingot", {
	description = "Ironze Ingot...WHAT?!",
	inventory_image = "core_ironze_ingot.png",
	groups = {cooking_multiplier=1},
})

minetest.register_craftitem("core:silver_ingot", {
	description = "Silver Ingot",
	inventory_image = "core_silver_ingot.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

minetest.register_craftitem("core:gold_ingot", {
	description = "Gold Ingot",
	inventory_image = "core_gold_ingot.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

-- ingot and gem cooking

minetest.register_craft({
	type = "cooking",
	output = "core:copper_ingot",
	recipe = "core:copper_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "core:iron_ingot",
	recipe = "core:iron_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "core:ironze_ingot",
	recipe = "core:uncooked_ironze_ingot",
})


minetest.register_craft({
	type = "cooking",
	output = "core:silver_ingot",
	recipe = "core:silver_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "core:gold_ingot",
	recipe = "core:gold_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "core:mese_crystal",
	recipe = "core:mese_ore",
})

minetest.register_craft({
	type = "cooking",
	output = "core:diamond",
	recipe = "core:diamond_ore",
})

-- glass

minetest.register_craft({
	type = "cooking",
	output = "core:glass",
	recipe = "core:sand",
})

minetest.register_craft({
	type = "cooking",
	output = "core:obsidian_glass",
	recipe = "core:obsidian",
})


-- gemstones and crystals

minetest.register_craftitem("core:mese_crystal", {
	description = "MESE Crystal",
	inventory_image = "core_mese_crystal.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

minetest.register_craftitem("core:diamond", {
	description = "Diamond",
	inventory_image = "core_diamond.png",
	groups = {cooking_multiplier=1}, -- note: used for cooking ore in furnace, not crafting!
})

-- register crafting for ingot blocks and gems

minetest.register_craft({

	output = "core:copper_block",
	
	recipe = {
	
		{"core:copper_ingot", "core:copper_ingot", "core:copper_ingot"},
		{"core:copper_ingot", "core:copper_ingot", "core:copper_ingot"},
		{"core:copper_ingot", "core:copper_ingot", "core:copper_ingot"},
	
	},

})

minetest.register_craft({

	output = "core:iron_block",
	
	recipe = {
	
		{"core:iron_ingot", "core:iron_ingot", "core:iron_ingot"},
		{"core:iron_ingot", "core:iron_ingot", "core:iron_ingot"},
		{"core:iron_ingot", "core:iron_ingot", "core:iron_ingot"},
	
	},

})

minetest.register_craft({

	output = "core:ironze_block",
	
	recipe = {
	
		{"core:ironze_ingot", "core:ironze_ingot", "core:ironze_ingot"},
		{"core:ironze_ingot", "core:ironze_ingot", "core:ironze_ingot"},
		{"core:ironze_ingot", "core:ironze_ingot", "core:ironze_ingot"},
	
	},

})

minetest.register_craft({

	output = "core:silver_block",
	
	recipe = {
	
		{"core:silver_ingot", "core:silver_ingot", "core:silver_ingot"},
		{"core:silver_ingot", "core:silver_ingot", "core:silver_ingot"},
		{"core:silver_ingot", "core:silver_ingot", "core:silver_ingot"},
	
	},

})

minetest.register_craft({

	output = "core:gold_block",
	
	recipe = {
	
		{"core:gold_ingot", "core:gold_ingot", "core:gold_ingot"},
		{"core:gold_ingot", "core:gold_ingot", "core:gold_ingot"},
		{"core:gold_ingot", "core:gold_ingot", "core:gold_ingot"},
	
	},

})

minetest.register_craft({

	output = "core:mese",
	
	recipe = {
	
		{"core:mese_crystal", "core:mese_crystal", "core:mese_crystal"},
		{"core:mese_crystal", "core:mese_crystal", "core:mese_crystal"},
		{"core:mese_crystal", "core:mese_crystal", "core:mese_crystal"},
	
	},

})

minetest.register_craft({

	output = "core:diamond_block",
	
	recipe = {
	
		{"core:diamond", "core:diamond", "core:diamond"},
		{"core:diamond", "core:diamond", "core:diamond"},
		{"core:diamond", "core:diamond", "core:diamond"},
			
	},

})

-- make storage blocks return their gems and ingots;

minetest.register_craft({
	type = "shapeless",
	output = "core:copper_ingot 9",
	recipe = {"core:copper_block"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:iron_ingot 9",
	recipe = {"core:iron_block"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:ironze_ingot 9",
	recipe = {"core:ironze_block"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:silver_ingot 9",
	recipe = {"core:silver_block"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:gold_ingot 9",
	recipe = {"core:gold_block"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:mese_crystal 9",
	recipe = {"core:mese"},
})

minetest.register_craft({
	type = "shapeless",
	output = "core:diamond 9",
	recipe = {"core:diamond_block"},
})



-- fuels

minetest.register_craft({
	type = "fuel",
	recipe = "core:coal_lump",
	burntime = 40,
})

