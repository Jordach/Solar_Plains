minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=3,z=4},
	tool_capabilities = {
		full_punch_interval = 0.9,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=6.00, [2]=3.00, [3]=1.50}, uses=0, maxlevel=1},
			snappy = {times={[3]=5.00}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0},
			choppy = {times={[3]=6.00}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
})

-- items

minetest.register_craftitem("core:clay_lump", {
	description = "Clay Lump",
	inventory_image = "core_clay_lump.png",
	wield_image = "core_clay_lump.png",
})

-- wood tier

minetest.register_tool("core:wooden_pickaxe", {
	description = "Wooden Pickaxe",
	inventory_image = "core_wooden_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=9.00, [2]=4.00, [3]=1.50}, uses=0, maxlevel=1}
		},
		damage_groups = {fleshy=1},
	}
})

minetest.register_tool("core:wooden_shovel", {
	description = "Wooden Shovel",
	inventory_image = "core_wooden_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	}
})

minetest.register_tool("core:wooden_axe", {
	description = "Wooden Axe",
	inventory_image = "core_wooden_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
			snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	}
	
})

minetest.register_tool("core:wooden_sword", {
	description = "Wooden Sword",
	inventory_image = "core_wooden_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	},
	
})

-- stone tier

minetest.register_tool("core:stone_pickaxe", {
	description = "Stone Pickaxe",
	inventory_image = "core_stone_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=6.00, [2]=2.00, [3]=0.75}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_shovel", {
	description = "Stone Shovel",
	inventory_image = "core_stone_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_axe", {
	description = "Stone Axe",
	inventory_image = "core_stone_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
			snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_sword", {
	description = "Stone Sword",
	inventory_image = "core_stone_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

-- iron tier

minetest.register_tool("core:iron_pickaxe", {
	description = "Iron Pickaxe",
	inventory_image = "core_iron_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:iron_shovel", {
	description = "Iron Shovel",
	inventory_image = "core_iron_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:iron_axe", {
	description = "Iron Axe",
	inventory_image = "core_iron_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=1024, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:iron_sword", {
	description = "Iron Sword",
	inventory_image = "core_iron_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=6},
	},
	
})

-- ironze tier

minetest.register_tool("core:ironze_pickaxe", {
	description = "Ironze Pickaxe",
	inventory_image = "core_ironze_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:ironze_shovel", {
	description = "Ironze Shovel",
	inventory_image = "core_ironze_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:ironze_axe", {
	description = "Ironze Axe",
	inventory_image = "core_ironze_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
			snappy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:ironze_sword", {
	description = "Ironze Sword",
	inventory_image = "core_ironze_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=6},
	},
	
})

-- mese tier;

minetest.register_tool("core:mese_pickaxe", {
	description = "MESE Pickaxe",
	inventory_image = "core_mese_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=1.50, [2]=0.50, [3]=0.25}, uses=2048, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:mese_shovel", {
	description = "MESE Shovel",
	inventory_image = "core_mese_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=2048, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:mese_axe", {
	description = "MESE Axe",
	inventory_image = "core_mese_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=2048, maxlevel=0},
			snappy = {times={[1]=0.25, [2]=0.12, [3]=0.06}, uses=2048*2, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:mese_sword", {
	description = "MESE Sword",
	inventory_image = "core_mese_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=2048, maxlevel=0},
		},
		damage_groups = {fleshy=8},
	},
	
})

-- diamond tier

minetest.register_tool("core:diamond_pickaxe", {
	description = "Diamond Pickaxe",
	inventory_image = "core_diamond_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=1.50, [2]=0.50, [3]=0.25}, uses=4096, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:diamond_shovel", {
	description = "Diamond Shovel",
	inventory_image = "core_diamond_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=4096, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:diamond_axe", {
	description = "Diamond Axe",
	inventory_image = "core_diamond_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=4096, maxlevel=0},
			snappy = {times={[1]=0.25, [2]=0.12, [3]=0.06}, uses=4096*2, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:diamond_sword", {
	description = "Diamond Sword",
	inventory_image = "core_diamond_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=4096, maxlevel=0},
		},
		damage_groups = {fleshy=8},
	},
	
})