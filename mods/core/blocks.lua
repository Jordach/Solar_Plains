--base mapgen items

minetest.register_node("core:dirt", {
	tiles = {"core_dirt.png"},
	description = "Dirt",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, soil=1, solid=1},
	sounds = mcore.sound_dirt,
})

minetest.register_node("core:mud", {
	tiles = {"core_dirt.png"},
	description = "Mud (Doesn't grow grass!)",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, soil=1},
	sounds = mcore.sound_dirt,
})

minetest.register_node("core:grass", {
	tiles = {"core_grass.png", "core_dirt.png", "core_dirt.png^core_grass_side.png"},
	description = "Dirt with Grass",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, soil=1, solid=1},
	sounds = mcore.sound_grass,
})

minetest.register_node("core:grass_wildland", {
	tiles = {"core_grass_wild.png", "core_dirt.png", "core_dirt.png^core_grass_wild_side.png"},
	description = "Dirt with Grass",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, soil=1, solid=1},
	sounds = mcore.sound_grass,
})

minetest.register_node("core:grasstest", {
	tiles = {"core_grass.png"},
	description = "Dirt with Grass",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, soil=1},
	sounds = mcore.sound_grass,
})

minetest.register_node("core:stone", {
	tiles = {"core_stone.png"},
	description = "Stone",
	is_ground_content = true,
	drop = "core:cobble",
	groups = {cracky=3, solid=1, stone=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:obsidian", {
	tiles = {"core_obsidian.png"},
	description = "Obsidian",
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:obsidian_brick", {
	tiles = {"core_obsidian_brick_top.png", "core_obsidian_brick_top.png", "core_obsidian_brick.png", "core_obsidian_brick.png", "core_obsidian_brick_bottom.png", "core_obsidian_brick_bottom.png"},
	description = "Obsidian Brick",
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:obsidian_glass", {
	tiles = {"core_obsidian_glass.png"},
	description = "Obsidian Glass",
	drawtype = "glasslike",
	paramtype = "light",
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})


minetest.register_node("core:basalt", {
	tiles = {"core_basalt.png"},
	description = "Basalt",
	is_ground_content = true,
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:basalt_brick", {
	tiles = {"core_basalt_brick_top.png", "core_basalt_brick_top.png", "core_basalt_brick.png", "core_basalt_brick.png", "core_basalt_brick_bottom.png", "core_basalt_brick_bottom.png"},
	description = "Basalt Brick",
	is_ground_content = true,
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})


minetest.register_node("core:firestone", {
	tiles = {"core_firestone.png"},
	description = "Fire Stone",
	is_ground_content = true,
	drop = "core:firestone",
	groups = {cracky=2, stone=1},
	light_source = 8,
	paramtype = "light",
	sounds = mcore.sound_stone,
})

minetest.register_node("core:icestone", {
	tiles = {"core_ice_stone.png"},
	description = "Zero Ice",
	light_source = 2,
	paramtype = "light",
	is_ground_content = true,
	drop = "core:icestone",
	groups = {cracky=2, solid=1, stone=1, slippery=3},
	sounds = mcore.sound_glass,
})

minetest.register_node("core:gstone", {
	tiles = {"core_stone.png"}, -- needs texture for glowing, maybe make it a crystal?
	description = "Stone",
	is_ground_content = true,
	drop = "core:cobble",
	groups = {cracky=3}, -- for now it's unobtainable other than creative, which isn't even working yet.
	paramtype = "light",
	light_source = 14,
	sounds = mcore.sound_stone,
})

minetest.register_node("core:cobble", {
	tiles = {"core_cobble.png"},
	description = "Cobblestone",
	is_ground_content = true,
	drop = "core:cobble",
	groups = {cracky=2, solid=1, stone=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:mossycobble", {
	tiles = {"core_cobble_mossy.png"},
	description = "Mossy Cobblestone",
	is_ground_content = true,
	drop = "core:mossycobble",
	groups = {cracky=2, solid=1, stone=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:sand", {
	tiles = {"core_sand.png"},
	description = "Sand",
	is_ground_content = true,
	drop = "core:sand",
	groups = {crumbly=3, falling_node=1},
	sounds = mcore.sound_sand,
})

minetest.register_node("core:gravel", {
	tiles = {"core_gravel.png"},
	description = "Gravel",
	is_ground_content = true,
	drop = "core:gravel",
	groups = {crumbly=2, falling_node=1},
	sounds = mcore.sound_sand,
})

minetest.register_node("core:clay", {
	tiles = {"core_clay_block.png"},
	description = "Clay",
	is_ground_content = true,
	drop = "core:clay_lump 4",
	groups = {crumbly=2, falling_node=1},
	sounds = mcore.sound_sand,
})

minetest.register_node("core:sandstone", {
	tiles = {"core_sandstone.png"},
	description = "Stone",
	is_ground_content = true,
	groups = {cracky=2, solid=1, stone=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:grass_snow", {
	tiles = {"core_snow.png", "core_dirt.png", "core_dirt.png^core_snow_side.png"},
	description = "Dirt with Snowy Grass",
	is_ground_content = true,
	drop = "core:dirt",
	groups = {crumbly=3, solid=1, soil=1, slippery=1},
	sounds = mcore.sound_snow,
})

minetest.register_node("core:snow", {
	tiles = {"core_snow.png"},
	inventory_image = "core_snowball.png",
	wield_image = "core_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.25, 0.5},
		},
	},
	groups = {crumbly = 3, falling_node = 1, puts_out_fire = 1, slippery=1},
	
	sounds = mcore.sound_snow;
	walkable = false,
	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "core:grass" then
			minetest.set_node(pos, {name = "core:grass_snow"})
		end
	end,
})

minetest.register_node("core:snowblock", {
	description = "Snow Block",
	tiles = {"core_snow.png"},
	is_ground_content = true,
	paramtype = "light",
	groups = {crumbly=3, puts_out_fire=1, solid=1, slippery=2},
	sounds = mcore.sound_snow,
})

minetest.register_node("core:ice", {
	description = "Ice",
	tiles = {"core_ice.png"},
	is_ground_content = true,
	paramtype = "light",
	drawtype = "glasslike",
	groups = {cracky=2, puts_out_fire=1, solid=1, slippery=4},
	sounds = mcore.sound_glass,
})

--

minetest.register_node("core:glass", {
	tiles = {"core_glass.png"},
	description = "Glass",
	groups = {oddly_breakable_by_hand = 3},
	sounds = mcore.sound_glass,
	drawtype = "glasslike",
	paramtype = "light",
})

-- liquids

minetest.register_node("core:water_source", {
	description = "Water Source (Can Self Replish)",
	drawtype = "liquid",
	tiles = {
		{
			name = "core_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
		},
	},
	special_tiles = {
		{
			name = "core_water_source_animated.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 2,
			},
			backface_culling = true,
		},
	},
	--alpha = 153,
	use_texture_alpha = true,
	paramtype = "light",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "core:water_flowing",
	liquid_alternative_source = "core:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 153, r = 18, g = 78, b = 137},
	groups = {water = 3, source = 1, puts_out_fire = 1, can_grow = 1},
})

minetest.register_node("core:water_flowing", {
	description = "Flowing Water",
	drawtype = "flowingliquid",
	tiles = {"core_water.png"},
	special_tiles = {
		{
			name = "core_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
		{
			name = "core_water_flowing_animated.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 0.8,
			},
		},
	},
	--alpha = 153,
	use_texture_alpha = true,
	paramtype = "light",
	paramtype2 = "flowingliquid",
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "core:water_flowing",
	liquid_alternative_source = "core:water_source",
	liquid_viscosity = 1,
	post_effect_color = {a = 153, r = 18, g = 78, b = 137},
	groups = {water = 3, flowing = 1, puts_out_fire = 1, can_grow = 1, not_in_creative_inventory = 1},
})

-- lava

minetest.register_node("core:lava_source", {
	description = "Lava Source",
	drawtype = "liquid",
	tiles = {
		{
			name = "core_lava_source_anim.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 8,
			},
		},
	},
	special_tiles = {
		-- New-style lava source material (mostly unused)
		{
			name = "core_lava_source_anim.png",
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 8,
			},
			backface_culling = false,
		},
	},
	paramtype = "light",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "source",
	liquid_alternative_flowing = "core:lava_flowing",
	liquid_alternative_source = "core:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1},
})

minetest.register_node("core:lava_flowing", {
	description = "Flowing Lava",
	drawtype = "flowingliquid",
	tiles = {"core_lava.png"},
	special_tiles = {
		{
			name = "core_lava_flowing_anim.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
		{
			name = "core_lava_flowing_anim.png",
			backface_culling = true,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 3.3,
			},
		},
	},
	paramtype = "light",
	paramtype2 = "flowingliquid",
	light_source = 14,
	walkable = false,
	pointable = false,
	diggable = false,
	buildable_to = true,
	is_ground_content = false,
	drop = "",
	drowning = 1,
	liquidtype = "flowing",
	liquid_alternative_flowing = "core:lava_flowing",
	liquid_alternative_source = "core:lava_source",
	liquid_viscosity = 7,
	liquid_renewable = false,
	damage_per_second = 4 * 2,
	post_effect_color = {a = 191, r = 255, g = 64, b = 0},
	groups = {lava = 3, liquid = 2, igniter = 1,
		not_in_creative_inventory = 1},
})

-- trees

minetest.register_node("core:pine_log", {
	description = "Pine Log",
	tiles = {"core_pine_log_top.png", "core_pine_log_top.png", "core_pine_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:pine_log_grassy", {
	description = "Pine Log (Grassy)",
	tiles = {"core_pine_log_top.png", "core_pine_log_top.png", "core_pine_log.png^core_long_grass_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:pine_needles", {
	description = "Pine Needles",
	tiles = {"core_pine_needles.png"},
	special_tiles = {"core_pine_needles.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:pine_sapling"},
				rarity = 16,
			},
			{
				items = {"core:pine_needles"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:pine_needles_snowy", {
	description = "Pine Needles (Snowy)",
	tiles = {"core_pine_needles_snowy.png"},
	special_tiles = {"core_pine_needles_snowy.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:pine_sapling"},
				rarity = 16,
			},
			{
				items = {"core:pine_needles_snowy"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:pine_planks", {
	description = "Pine Planks",
	tiles = {"core_pine_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

-- oak

minetest.register_node("core:oak_log", {
	description = "Oak Log",
	tiles = {"core_oak_log_top.png", "core_oak_log_top.png", "core_oak_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:oak_log_grassy", {
	description = "Oak Log (Grassy)",
	tiles = {"core_oak_log_top.png", "core_oak_log_top.png", "core_oak_log.png^core_long_grass_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:oak_leaves", {
	description = "Oak Leaves",
	tiles = {"core_oak_leaves.png"},
	special_tiles = {"core_oak_leaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:oak_sapling"},
				rarity = 16,
			},
			{
				items = {"core:oak_leaves"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:oak_planks", {
	description = "Oak Planks",
	tiles = {"core_oak_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

-- cherry

minetest.register_node("core:cherry_log", {
	description = "Cherry Log",
	tiles = {"core_cherry_log_top.png", "core_cherry_log_top.png", "core_cherry_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:cherry_log_grassy", {
	description = "Cherry Log (Grassy)",
	tiles = {"core_cherry_log_top.png", "core_cherry_log_top.png", "core_cherry_log.png^core_long_grass_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:cherry_leaves", {
	description = "Cherry Leaves",
	tiles = {"core_cherry_leaves.png"},
	special_tiles = {"core_cherry_leaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:cherry_sapling"},
				rarity = 16,
			},
			{
				items = {"core:cherry_leaves"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:cherry_planks", {
	description = "Cherry Planks",
	tiles = {"core_cherry_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

minetest.register_node("core:fallen_cherry_leaves", {
	description = "Fallen Cherry Leaves",
	tiles = {"core_cherry_leaves.png"},
	drawtype = "mesh",
	mesh = "planar_flower.b3d",
	groups = {snappy=3, attached_node=1},
	--use_texture_alpha = true,
	paramtype = "light",
	buildable_to = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
	after_place_node = default.after_place_leaves,
})

-- birch

minetest.register_node("core:birch_log", {
	description = "Birch Log",
	tiles = {"core_birch_log_top.png", "core_birch_log_top.png", "core_birch_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:birch_log_grassy", {
	description = "Birch Log",
	tiles = {"core_birch_log_top.png", "core_birch_log_top.png", "core_birch_log.png^core_long_grass_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:birch_leaves", {
	description = "Birch Leaves",
	tiles = {"core_birch_leaves.png"},
	special_tiles = {"core_birch_leaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:birch_sapling"},
				rarity = 16,
			},
			{
				items = {"core:birch_leaves"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:birch_planks", {
	description = "Birch Planks",
	tiles = {"core_birch_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

-- saplings

minetest.register_node("core:oak_sapling", {
	description = "Oak Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_oak_sapling.png"},
	waving = 1,
	walkable = false,
	paramtype2 = "meshoptions",
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("core:pine_sapling", {
	description = "Pine Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_pine_sapling.png"},
	waving = 1,
	walkable = false,
	paramtype2 = "meshoptions",
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("core:birch_sapling", {
	description = "Birch Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_birch_sapling.png"},
	waving = 1,
	walkable = false,
	paramtype2 = "meshoptions",
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("core:cherry_sapling", {
	description = "Cherry Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_cherry_sapling.png"},
	paramtype2 = "meshoptions",
	waving = 1,
	walkable = false,
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("core:acacia_sapling", {
	description = "Acacia Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_cherry_sapling.png"},
	waving = 1,
	paramtype2 = "meshoptions",
	walkable = false,
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("core:wimba_sapling", {
	description = "Wimba Sapling",
	drawtype = "plantlike",
	paramtype = "light",
	tiles = {"core_wimba_sapling.png"},
	waving = 1,
	walkable = false,
	groups = {snappy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_plants,
	paramtype2 = "meshoptions",
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- acacia

minetest.register_node("core:acacia_log", {
	description = "Acacia Log",
	tiles = {"core_acacia_log_top.png", "core_acacia_log_top.png", "core_acacia_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:acacia_log_grassy", {
	description = "Acacia Log (Grassy)",
	tiles = {"core_acacia_log_top.png", "core_acacia_log_top.png", "core_acacia_log.png^core_long_grass_wild_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:acacia_leaves", {
	description = "Acacia Leaves",
	tiles = {"core_acacia_leaves.png"},
	special_tiles = {"core_acacia_leaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:acacia_sapling"},
				rarity = 16,
			},
			{
				items = {"core:acacia_leaves"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:acacia_planks", {
	description = "Acacia Planks",
	tiles = {"core_acacia_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

-- a wimba way a wimba way

minetest.register_node("core:wimba_log", {
	description = "Wimba Log",
	tiles = {"core_wimba_log_top.png", "core_wimba_log_top.png", "core_wimba_log.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:wimba_log_grassy", {
	description = "Wimba Log (Grassy)",
	tiles = {"core_wimba_log_top.png", "core_wimba_log_top.png", "core_wimba_log.png^core_long_grass_wild_1.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	groups = {tree=1, choppy=3, flammable=2, solid=1, nodec=1},
	on_place = mcore.sensible_facedir,
	sounds = mcore.sound_wood,
})

minetest.register_node("core:wimba_leaves", {
	description = "Wimba Leaves",
	tiles = {"core_wimba_leaves.png"},
	special_tiles = {"core_wimba_leaves.png"},
	drawtype = "allfaces_optional",
	waving = 1,
	visual_scale = 1.3,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy=3, leafdecay=3, flammable=2},
	drop = {
		max_items = 1,
		items = {
			{
				items = {"core:wimba_sapling"},
				rarity = 16,
			},
			{
				items = {"core:wimba_leaves"},
			}
		}
	},
	after_place_node = default.after_place_leaves,
	sounds = mcore.sound_plants,
})

minetest.register_node("core:wimba_planks", {
	description = "Wimba Planks",
	tiles = {"core_wimba_planks.png"},
	groups = {choppy=3, flammable=2, solid=1, planks=1},
	sounds = mcore.sound_wood,
})

minetest.register_node("core:vine", {
	description = "Vines",
	tiles = {"core_vine.png"},
	groups = {snappy=3, flammable=2, attached_node=1},
	drawtype = "plantlike",
	paramtype = "light",
	sunlight_propagates = true,
	climbable = true,
	walkable = false,
})

-- leafdecay definitions

default.register_leafdecay({
	trunks = {"core:oak_log"},
	leaves = {"core:oak_leaves"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"core:birch_log"},
	leaves = {"core:birch_leaves"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"core:pine_log"},
	leaves = {"core:pine_needles_snowy", "core:pine_needles"},
	radius = 5,
})

default.register_leafdecay({
	trunks = {"core:cherry_log"},
	leaves = {"core:cherry_leaves", "core:fallen_cherry_leaves"},
	radius = 3,
})

default.register_leafdecay({
	trunks = {"core:acacia_log"},
	leaves = {"core:acacia_leaves"},
	radius = 5,
})

default.register_leafdecay({
	trunks = {"core:wimba_log"},
	leaves = {"core:wimba_leaves"},
	radius = 5,
})

-- cacti

minetest.register_node("core:cactus", {
	description = "Cactus",
	tiles = {"core_cactus.png"},
	is_ground_content = false,
	drawtype = "mesh",
	paramtype = "light",
	mesh = "core_cactus.b3d",
	groups = {choppy=3, flammable=2, attached_node=1},
	sounds = mcore.sound_wood,
	damage_per_second = 1,
	
})

minetest.register_node("core:grass_1", {
	description = "Long Grass",
	tiles = {"core_long_grass_1.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	visual_scale = 1.0,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local nname = "core:grass_" .. math.random(1,3)
		local stack = ItemStack(nname)
		local ret = minetest.item_place_node(stack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return ItemStack("core:grass_1 "..itemstack:get_count() - (1 - ret:get_count()))
	end,
	
})

minetest.register_node("core:grass_wild_1", {
	description = "Wildlands Long Grass",
	tiles = {"core_long_grass_wild_1.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	visual_scale = 1.0,
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local nname = "core:grass_wild_" .. math.random(1,3)
		local stack = ItemStack(nname)
		local ret = minetest.item_place_node(stack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return ItemStack("core:grass_wild_1 "..itemstack:get_count() - (1 - ret:get_count()))
	end,
	
})


for i=2, 3 do
	
	minetest.register_node("core:grass_"..i, {
		description = "Long Grass",
		tiles = {"core_long_grass_"..i..".png"},
		waving = 1,
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		visual_scale = 1.0,
		walkable = false,
		buildable_to = true,
		drop = "core:grass_1",
		sunlight_propagates = true,
		groups = {not_in_creative_inventory=1, attached_node=1, snappy=3},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		sounds = mcore.sound_plants,
	})
	
	minetest.register_node("core:grass_wild_"..i, {
		description = "Wildlands Long Grass",
		tiles = {"core_long_grass_wild_"..i..".png"},
		waving = 1,
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		visual_scale = 1.0,
		walkable = false,
		buildable_to = true,
		drop = "core:grass_wild_1",
		sunlight_propagates = true,
		groups = {not_in_creative_inventory=1, attached_node=1, snappy=3},
		selection_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
		},
		sounds = mcore.sound_plants,
	})
	
end

-- plants

minetest.register_node("core:papyrus", {
	description = "Papyrus",
	tiles = {"core_papyrus.png"},
	drawtype = "plantlike",
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3, stick=1},
	selection_box = {
			type = "fixed",
			fixed = {-0.35, -0.5, -0.35, 0.35, 0.5, 0.35},
	},
	sounds = mcore.sound_plants,
})

minetest.register_node("core:bamboo", {
	description = "Bamboo",
	tiles = {"core_bamboo.png"},
	drawtype = "mesh",
	paramtype = "light",
	mesh = "core_bamboo.b3d",
	paramtype = "light",
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3, planks=1},
	selection_box = {
			type = "fixed",
			fixed = {-0.35, -0.5, -0.35, 0.35, 0.5, 0.35},
	},
	sounds = mcore.sound_wood,
})

-- ores

minetest.register_node("core:coal_ore", {
	description = "Coal Ore",
	tiles = {"core_ore_coal.png"},
	groups = {cracky=3, solid=1, ore=1},
	sounds = mcore.sound_stone,
	drop = {
		max_items = 3,
		items = {
			{items = {"core:coal_lump 1"}, rarity=1},
			{items = {"core:coal_lump 1"}, rarity=5},
			{items = {"core:coal_lump 1"}, rarity=6},
		},
	},
})

minetest.register_node("core:copper_ore", {
	description = "Copper Ore",
	tiles = {"core_ore_copper.png"},
	groups = {cracky=3, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:iron_ore", {
	description = "Iron Ore",
	tiles = {"core_ore_iron.png"},
	groups = {cracky=2, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:silver_ore", {
	description = "Silver Ore",
	tiles = {"core_ore_silver.png"},
	groups = {cracky=2, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:gold_ore", {
	description = "Gold Ore",
	tiles = {"core_ore_gold.png"},
	groups = {cracky=1, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:mese_ore", {
	description = "Mese Ore",
	tiles = {"core_ore_mese.png"},
	groups = {cracky=1, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

minetest.register_node("core:mese", {
	description = "Mese Block",
	tiles = {"core_mese.png"},
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})


minetest.register_node("core:diamond_ore", {
	description = "Diamond Ore",
	tiles = {"core_ore_diamond.png"},
	groups = {cracky=1, solid=1, ore=1},
	sounds = mcore.sound_stone,
})

-- register ingot and gem blocks except MESE

minetest.register_node("core:copper_block", {
	description = "Block of Copper",
	tiles = {"core_copper_block.png"},
	groups = {cracky=3, solid=1},
	sounds = mcore.sound_metallic,
})

minetest.register_node("core:iron_block", {
	description = "Block of Iron",
	tiles = {"core_iron_block.png"},
	groups = {cracky=2, solid=1},
	sounds = mcore.sound_metallic,
})

minetest.register_node("core:silver_block", {
	description = "Block of Silver",
	tiles = {"core_silver_block.png"},
	groups = {cracky=2, solid=1},
	sounds = mcore.sound_metallic,
})

minetest.register_node("core:gold_block", {
	description = "Block of Gold",
	tiles = {"core_gold_block.png"},
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_metallic,
})

minetest.register_node("core:ironze_block", {
	description = "Block of Ironze?!",
	tiles = {"core_ironze_block.png"},
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_metallic,
})


minetest.register_node("core:diamond_block", {
	description = "Block of Diamond",
	tiles = {"core_diamond_block.png"},
	groups = {cracky=1, solid=1},
	sounds = mcore.sound_stone,
})

-- torches and light sources

minetest.register_node("core:torch", {
	description = "Torch",
	drawtype = "nodebox",
	tiles = {"core_torch_top.png", "core_torch_bottom.png", "core_torch_side.png"},
	wield_scale = {x = 1, y = 1, z = 1.25},
	paramtype = "light",
	paramtype2 = "wallmounted",
	sunlight_propagates = true,
	is_ground_content = false,
	wield_image = "core_torch_wield.png",
	inventory_image = "core_torch_wield.png",
	walkable = false,
	light_source = 14,
	selection_box = {
		type = "wallmounted",
		wall_top = {-0.0625, 0.5, -0.0625, 0.0625, -0.0625, 0.0625},
		wall_bottom = {-0.0625, -0.5, -0.0625, 0.0625, 0+0.0625, 0.0625},
		wall_side =	{-0.5, -0.5, -0.0625, -0.375, 0.0625, 0.0625},
	},
	groups = {choppy=2,dig_immediate=3,flammable=1,attached_node=1,hot=2},
	legacy_wallmounted = true,
	sounds = mcore.sound_wood,
	node_box = {
		type = "wallmounted",
		wall_top = {-0.0625, 0.5, -0.0625, 0.0625, -0.0625, 0.0625},
		wall_bottom = {-0.0625, -0.5, -0.0625, 0.0625, 0+0.0625, 0.0625},
		wall_side =	{-0.5, -0.5, -0.0625, -0.375, 0.0625, 0.0625},
	},
})


-- metadata nodes

mcore.chest_formspec = 
	"size[8,9]" ..
	"list[current_name;main;0,0;8,4;]" ..
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]"..
	"background[-0.45,-0.5;8.9,10;core_chest_interface.png]"..
	"listcolors[#573b2e;#de9860;#ffffff;#3f2832;#ffffff]"

	

minetest.register_node("core:chest", {
	description = "Chest",
	drawtype = "mesh",
	mesh = "chest_unlocked.b3d",
	tiles = {"core_chest_uv.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	is_ground_content = false,

	collision_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
		}
	},
	
	sounds = mcore.sound_wood,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", mcore.chest_formspec)
		local inv = meta:get_inventory()
		inv:set_size("main", 8*4)
		
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main")
	end,
	on_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		minetest.log("action", player:get_player_name() ..
			" moves stuff in chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes " .. stack:get_name() ..
			" from chest at " .. minetest.pos_to_string(pos))
	end,
})

function mcore.get_locked_chest_formspec(pos)
	local spos = pos.x .. "," .. pos.y .. "," .. pos.z
	local formspec =
		"size[8,9]" ..
		"list[nodemeta:" .. spos .. ";main;0,0.3;8,4;]" ..
		"list[current_player;main;0,4.85;8,1;]" ..
		"list[current_player;main;0,6.08;8,3;8]" ..
		"listring[nodemeta:" .. spos .. ";main]" ..
		"listring[current_player;main]"
		--default.get_hotbar_bg(0,4.85)
 return formspec
end

function mcore.has_locked_chest_privilege(meta, player)
	if player then
		if minetest.check_player_privs(player, "protection_bypass") then
			return true
		end
	else
		return false
	end

	if player:get_player_name() ~= meta:get_string("owner") then
		return false
	end

	return true
end

minetest.register_node("core:chest_locked", {
	description = "Locked Chest",
	drawtype = "mesh",
	mesh = "chest_locked.b3d",
	tiles = {"core_chest_uv.png"},
	groups = {choppy = 2, oddly_breakable_by_hand = 2},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.4375, -0.5, -0.4375, 0.4375, 0.375, 0.4375},
		}
	},
	
	sounds = mcore.sound_wood,

	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", placer:get_player_name() or "")
		meta:set_string("infotext", "Locked Chest (owned by " ..
				meta:get_string("owner") .. ")")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("owner", "")
		local inv = meta:get_inventory()
		inv:set_size("main", 8 * 4)
	end,
	can_dig = function(pos,player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		return inv:is_empty("main") and mcore.has_locked_chest_privilege(meta, player)
	end,
	allow_metadata_inventory_move = function(pos, from_list, from_index,
			to_list, to_index, count, player)
		local meta = minetest.get_meta(pos)
		if not mcore.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return count
	end,
    allow_metadata_inventory_put = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not mcore.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    allow_metadata_inventory_take = function(pos, listname, index, stack, player)
		local meta = minetest.get_meta(pos)
		if not mcore.has_locked_chest_privilege(meta, player) then
			return 0
		end
		return stack:get_count()
	end,
    on_metadata_inventory_put = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" moves " .. stack:get_name() ..
			" to locked chest at " .. minetest.pos_to_string(pos))
	end,
    on_metadata_inventory_take = function(pos, listname, index, stack, player)
		minetest.log("action", player:get_player_name() ..
			" takes " .. stack:get_name()  ..
			" from locked chest at " .. minetest.pos_to_string(pos))
	end,
	on_rightclick = function(pos, node, clicker, itemstack, pointed_thing)
		local meta = minetest.get_meta(pos)
		if mcore.has_locked_chest_privilege(meta, clicker) then
			minetest.show_formspec(
				clicker:get_player_name(),
				"core:chest_locked",
				mcore.get_locked_chest_formspec(pos)
			)
		end
		return itemstack
	end,
})

-- furnace

mcore.furnace = {}

function mcore.furnace.active_formspec(fuel_percent, item_percent)
	local formspec =
		"size[8,8.5]"..
		"list[current_name;src;2.75,0.5;1,1;]"..
		"list[current_name;fuel;2.75,2.5;1,1;]"..
		"image[2.75,1.5;1,1;core_furnace_fire_bg.png^[lowpart:"..
		(100-fuel_percent)..":core_furnace_fire_fg.png]"..
		"image[3.75,1.5;1,1;core_furnace_arrow_bg.png^[lowpart:"..
		(item_percent)..":core_furnace_arrow_fg.png^[transformR270]"..
		"list[current_name;dst;4.75,0.96;2,2;]"..
		"list[current_player;main;0,4.25;8,1;]"..
		"list[current_player;main;0,5.5;8,3;8]"..
		"listring[current_name;dst]"..
		"listring[current_player;main]"..
		"listring[current_name;src]"..
		"listring[current_player;main]"..
		"listring[current_name;fuel]"..
		"listring[current_player;main]"
	return formspec
end

mcore.furnace.inactive_formspec =
	"size[8,8.5]"..
	"list[current_name;src;2.75,0.5;1,1;]"..
	"list[current_name;fuel;2.75,2.5;1,1;]"..
	"image[2.75,1.5;1,1;core_furnace_fire_bg.png]"..
	"image[3.75,1.5;1,1;core_furnace_arrow_bg.png^[transformR270]"..
	"list[current_name;dst;4.75,0.96;2,2;]"..
	"list[current_player;main;0,4.25;8,1;]"..
	"list[current_player;main;0,5.5;8,3;8]"..
	"listring[current_name;dst]"..
	"listring[current_player;main]"..
	"listring[current_name;src]"..
	"listring[current_player;main]"..
	"listring[current_name;fuel]"..
	"listring[current_player;main]"
	
function mcore.furnace.can_dig(pos, player)
	local meta = minetest.get_meta(pos);
	local inv = meta:get_inventory()
	return inv:is_empty("fuel") and inv:is_empty("dst") and inv:is_empty("src")
end

function mcore.furnace.allow_metadata_inventory_put(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	if listname == "fuel" then
		if minetest.get_craft_result({method="fuel", width=1, items={stack}}).time ~= 0 then
			if inv:is_empty("src") then
				meta:set_string("infotext", "Furnace is empty")
			end
			return stack:get_count()
		else
			return 0
		end
	elseif listname == "src" then
		return stack:get_count()
	elseif listname == "dst" then
		return 0
	end
end

function mcore.furnace.allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
	local meta = minetest.get_meta(pos)
	local inv = meta:get_inventory()
	local stack = inv:get_stack(from_list, from_index)
	return mcore.furnace.allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

function mcore.furnace.allow_metadata_inventory_take(pos, listname, index, stack, player)
	if minetest.is_protected(pos, player:get_player_name()) then
		return 0
	end
	return stack:get_count()
end

function mcore.furnace.swap_node(pos, name)
	local node = minetest.get_node(pos)
	if node.name == name then
		return
	end
	node.name = name
	minetest.swap_node(pos, node)
end

function mcore.furnace.furnace_node_timer(pos, elapsed)
	--
	-- Inizialize metadata
	--
	local meta = minetest.get_meta(pos)
	local fuel_time = meta:get_float("fuel_time") or 0
	local src_time = meta:get_float("src_time") or 0
	local fuel_totaltime = meta:get_float("fuel_totaltime") or 0

	local inv = meta:get_inventory()
	local srclist, fuellist

	local cookable, cooked
	local fuel

	local update = true
	while update do
		update = false

		srclist = inv:get_list("src")
		fuellist = inv:get_list("fuel")

		--
		-- Cooking
		--

		-- Check if we have cookable content
		local aftercooked
		cooked, aftercooked = minetest.get_craft_result({method = "cooking", width = 1, items = srclist})
		cookable = cooked.time ~= 0

		-- Check if we have enough fuel to burn
		if fuel_time < fuel_totaltime then
			-- The furnace is currently active and has enough fuel
			fuel_time = fuel_time + elapsed
			-- If there is a cookable item then check if it is ready yet
			if cookable then
				src_time = src_time + elapsed
				if src_time >= cooked.time then
					-- Place result in dst list if possible
					if inv:room_for_item("dst", cooked.item) then
						inv:add_item("dst", cooked.item)
						if minetest.get_item_group(cooked.item:get_name(), "cooking_multiplier") == 1 then
							if math.random(1,5) == 1 then
								if inv:room_for_item("dst", cooked.item) then
									inv:add_item("dst", cooked.item)
								else
									minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, cooked.item:get_name())
								end
							end
							if math.random(1,6) == 1 then
								if inv:room_for_item("dst", cooked.item) then
									inv:add_item("dst", cooked.item)
								else
									minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, cooked.item:get_name())
								end
							end
						end
						inv:set_stack("src", 1, aftercooked.items[1])
						src_time = src_time - cooked.time
						update = true
					end
				end
			end
		else
			-- Furnace ran out of fuel
			if cookable then
				-- We need to get new fuel
				local afterfuel
				fuel, afterfuel = minetest.get_craft_result({method = "fuel", width = 1, items = fuellist})

				if fuel.time == 0 then
					-- No valid fuel in fuel list
					fuel_totaltime = 0
					src_time = 0
				else
					-- Take fuel from fuel list
					inv:set_stack("fuel", 1, afterfuel.items[1])
					update = true
					fuel_totaltime = fuel.time + (fuel_time - fuel_totaltime)
					src_time = src_time + elapsed
				end
			else
				-- We don't need to get new fuel since there is no cookable item
				fuel_totaltime = 0
				src_time = 0
			end
			fuel_time = 0
		end

		elapsed = 0
	end

	if fuel and fuel_totaltime > fuel.time then
		fuel_totaltime = fuel.time
	end
	if srclist[1]:is_empty() then
		src_time = 0
	end

	--
	-- Update formspec, infotext and node
	--
	local formspec = mcore.furnace.inactive_formspec
	local item_state
	local item_percent = 0
	if cookable then
		item_percent = math.floor(src_time / cooked.time * 100)
		if item_percent > 100 then
			item_state = "100% (output full)"
		else
			item_state = item_percent .. "%"
		end
	else
		if srclist[1]:is_empty() then
			item_state = "Empty"
		else
			item_state = "Not cookable"
		end
	end

	local fuel_state = "Empty"
	local active = "inactive "
	local result = false

	if fuel_totaltime ~= 0 then
		active = "active "
		local fuel_percent = math.floor(fuel_time / fuel_totaltime * 100)
		fuel_state = fuel_percent .. "%"
		formspec = mcore.furnace.active_formspec(fuel_percent, item_percent)
		mcore.furnace.swap_node(pos, "core:furnace_active")
		-- make sure timer restarts automatically
		result = true
	else
		if not fuellist[1]:is_empty() then
			fuel_state = "0%"
		end
		mcore.furnace.swap_node(pos, "core:furnace")
		-- stop timer on the inactive furnace
		minetest.get_node_timer(pos):stop()
	end

	local infotext = "Furnace " .. active .. "(Item: " .. item_state .. "; Fuel: " .. fuel_state .. ")"

	--
	-- Set meta values
	--
	meta:set_float("fuel_totaltime", fuel_totaltime)
	meta:set_float("fuel_time", fuel_time)
	meta:set_float("src_time", src_time)
	meta:set_string("formspec", formspec)
	meta:set_string("infotext", infotext)

	return result
end

function mcore.get_inventory_drops(pos, inventory, drops)
	local inv = minetest.get_meta(pos):get_inventory()
	local n = #drops
	for i = 1, inv:get_size(inventory) do
		local stack = inv:get_stack(inventory, i)
		if stack:get_count() > 0 then
			drops[n+1] = stack:to_table()
			n = n + 1
		end
	end
end

-- furnace node

minetest.register_node("core:furnace", {
	description = "Furnace",
	tiles = {
		"core_furnace_top.png", "core_furnace_top.png",
		"core_furnace_top.png", "core_furnace_top.png",
		"core_furnace_top.png", "core_furnace_front.png"
	},
	paramtype2 = "facedir",
	groups = {cracky=2},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = mcore.sound_stone,

	can_dig = mcore.furnace.can_dig,

	on_timer = mcore.furnace.furnace_node_timer,

	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", mcore.furnace.inactive_formspec)
		local inv = meta:get_inventory()
		inv:set_size('src', 1)
		inv:set_size('fuel', 1)
		inv:set_size('dst', 4)
	end,

	on_metadata_inventory_move = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	on_metadata_inventory_put = function(pos)
		-- start timer function, it will sort out whether furnace can burn or not.
		minetest.get_node_timer(pos):start(1.0)
	end,
	
	allow_metadata_inventory_put = mcore.furnace.allow_metadata_inventory_put,
	allow_metadata_inventory_move = mcore.furnace.allow_metadata_inventory_move,
	allow_metadata_inventory_take = mcore.furnace.allow_metadata_inventory_take,
})

minetest.register_node("core:furnace_active", {
	description = "Furnace",
	tiles = {
		"core_furnace_top.png", "core_furnace_top.png",
		"core_furnace_top.png", "core_furnace_top.png",
		"core_furnace_top.png", "core_furnace_front_active.png"
	},
	paramtype2 = "facedir",
	light_source = 8,
	drop = "core:furnace",
	groups = {cracky=2, not_in_creative_inventory=1},
	legacy_facedir_simple = true,
	is_ground_content = false,
	sounds = mcore.sound_stone,
	on_timer = mcore.furnace.furnace_node_timer,

	can_dig = mcore.furnace.can_dig,

	allow_metadata_inventory_put = mcore.furnace.allow_metadata_inventory_put,
	allow_metadata_inventory_move = mcore.furnace.allow_metadata_inventory_move,
	allow_metadata_inventory_take = mcore.furnace.allow_metadata_inventory_take,
})

-- utility functions

function mcore.register_fence(name, def)
	minetest.register_craft({
		output = name .. " 4",
		recipe = {
			{ def.material, 'group:stick', def.material },
			{ def.material, 'group:stick', def.material },
		}
	})

	-- Allow almost everything to be overridden
	
	-- items in this table appear to be unable to be overridden
	
	local default_fields = {
		paramtype = "light",
		drawtype = "nodebox",
		node_box = {
			type = "connected",
			fixed = {{-1/8, -1/2, -1/8, 1/8, 1/2, 1/8}},
			-- connect_top =
			-- connect_bottom =
			connect_front = {{-1/16,  5/16, -1/2,   1/16,  7/16, -1/8},
							 {-1/16, -3/16, -1/2,   1/16, -1/16, -1/8}},
			connect_left =  {{-1/2,   5/16, -1/16, -1/8,   7/16,  1/16},
							 {-1/2,  -3/16, -1/16, -1/8,  -1/16,  1/16}},
			connect_back =  {{-1/16,  5/16,  1/8,   1/16,  7/16,  1/2},
							 {-1/16, -3/16,  1/8,   1/16, -1/16,  1/2}},
			connect_right = {{1/8,    5/16, -1/16,  1/2,   7/16,  1/16},
							 {1/8,   -3/16, -1/16,  1/2,  -1/16,  1/16}},
		},
		connects_to = {"group:fence", "group:wood", "group:tree", "group:solid"},
		--inventory_image = def.inventory_image,
		--wield_image = def.wield_image,
		tiles = {def.texture},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {},
	}
	
	-- insert missing table values into the def table for node def
	
	for k, v in pairs(default_fields) do
		if not def[k] then
			def[k] = v
		end
	end

	-- Always add to the fence group, even if no group provided
	def.groups.fence = 1

	def.texture = nil
	def.material = nil

	minetest.register_node(name, def)
end

-- fences

mcore.register_fence("core:fence_oak", {
	description = "Oak Fence",
	texture = "core_oak_planks.png",
	material = "core:oak_planks",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = mcore.sound_wood,
})

mcore.register_fence("core:fence_birch", {
	description = "Birch Fence",
	texture = "core_birch_planks.png",
	material = "core:birch_planks",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = mcore.sound_wood,
})

mcore.register_fence("core:fence_pine", {
	description = "Pine Fence",
	texture = "core_pine_planks.png",
	material = "core:pine_planks",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = mcore.sound_wood,
})

mcore.register_fence("core:fence_cherry", {
	description = "Cherry Fence",
	texture = "core_cherry_planks.png",
	material = "core:cherry_planks",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = mcore.sound_wood,
})

mcore.register_fence("core:fence_acacia", {
	description = "Acacia Fence",
	texture = "core_acacia_planks.png",
	material = "core:acacia_planks",
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2},
	sounds = mcore.sound_wood,	
})