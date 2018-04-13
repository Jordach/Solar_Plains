
--[[
	Big thanks to PainterlyPack.net for allowing me to use these textures
]]

local S = farming.intllib

-- pumpkin
minetest.register_node("farming:pumpkin", {
	description = S("Pumpkin"),
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png"
	},
	groups = {
		choppy = 1, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = {
		items = {
			{items = {'farming:pumpkin_slice 9'}, rarity = 1},
		}
	},
	sounds = mcore.sound_wood,
})

-- pumpkin slice
minetest.register_craftitem("farming:pumpkin_slice", {
	description = S("Pumpkin Slice"),
	inventory_image = "farming_pumpkin_slice.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:pumpkin_1", true)
	end,
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "farming:pumpkin",
	recipe = {
		{"farming:pumpkin_slice", "farming:pumpkin_slice", "farming:pumpkin_slice"},
		{"farming:pumpkin_slice", "farming:pumpkin_slice", "farming:pumpkin_slice"},
		{"farming:pumpkin_slice", "farming:pumpkin_slice", "farming:pumpkin_slice"},
	}
})

minetest.register_craft({
	output = "farming:pumpkin_slice 9",
	recipe = {
		{"", "farming:pumpkin", ""},
	}
})

-- jack 'o lantern
minetest.register_node("farming:jackolantern", {
	description = S("Jack 'O Lantern"),
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_off.png"
	},
	paramtype2 = "facedir",
	groups = {choppy = 1, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = mcore.sound_wood,
	on_punch = function(pos, node, puncher)
		node.name = "farming:jackolantern_on"
		minetest.swap_node(pos, node)
	end,
})

minetest.register_node("farming:jackolantern_on", {
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_side.png",
		"farming_pumpkin_face_on.png"
	},
	light_source = 14,
	paramtype2 = "facedir",
	groups = {
		choppy = 1, oddly_breakable_by_hand = 1, flammable = 2,
		not_in_creative_inventory = 1
	},
	sounds = mcore.sound_wood,
	drop = "farming:jackolantern",
	on_punch = function(pos, node, puncher)
		node.name = "farming:jackolantern"
		minetest.swap_node(pos, node)
	end,
})

minetest.register_craft({
	output = "farming:jackolantern",
	recipe = {
		{"", "", ""},
		{"", "core:torch", ""},
		{"", "farming:pumpkin", ""},
	}
})

-- pumpkin bread
minetest.register_craftitem("farming:pumpkin_bread", {
	description = S("Pumpkin Bread"),
	inventory_image = "farming_pumpkin_bread.png",
	on_use = minetest.item_eat(8)
})

minetest.register_craftitem("farming:pumpkin_dough", {
	description = S("Pumpkin Dough"),
	inventory_image = "farming_pumpkin_dough.png",
})

minetest.register_craft({
	output = "farming:pumpkin_dough",
	type = "shapeless",
	recipe = {"farming:flour", "farming:pumpkin_slice", "farming:pumpkin_slice"}
})

minetest.register_craft({
	type = "cooking",
	output = "farming:pumpkin_bread",
	recipe = "farming:pumpkin_dough",
	cooktime = 10
})

-- pumpkin definition
local crop_def = {
	drawtype = "mesh",
	mesh = "farming_melon_2.b3d",
	tiles = {"farming_pumpkin_tiny.png^[colorize:#265c42aa"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	drop = "",
	selection_box = farming.select,
	groups = {
		snappy = 3, flammable = 2, plant = 1, attached_node = 1,
		not_in_creative_inventory = 1, growing = 1
	},
	sounds = mcore.sound_plants,
}

-- stage 1
minetest.register_node("farming:pumpkin_1", table.copy(crop_def))

-- stage 2
crop_def.mesh = "farming_melon_3.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4288"}
minetest.register_node("farming:pumpkin_2", table.copy(crop_def))

-- stage 3 
crop_def.mesh = "farming_melon_4.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4277"}
minetest.register_node("farming:pumpkin_3", table.copy(crop_def))

-- stage 4
crop_def.mesh = "farming_melon_5.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4266"}
minetest.register_node("farming:pumpkin_4", table.copy(crop_def))

-- stage 5
crop_def.mesh = "farming_melon_6.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4255"}
minetest.register_node("farming:pumpkin_5", table.copy(crop_def))

-- stage 6
crop_def.mesh = "farming_melon_7.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4244"}
minetest.register_node("farming:pumpkin_6", table.copy(crop_def))

-- stage 7
crop_def.mesh = "farming_melon_8.b3d"
crop_def.tiles = {"farming_pumpkin_tiny.png^[colorize:#265c4233"}
minetest.register_node("farming:pumpkin_7", table.copy(crop_def))

-- stage 8 (final)

minetest.register_node("farming:pumpkin_8", {
	description = S("Pumpkin"),
	tiles = {
		"farming_pumpkin_top.png",
		"farming_pumpkin_top.png",
		"farming_pumpkin_side.png"
	},
	groups = {
		choppy = 1, oddly_breakable_by_hand = 1,
		flammable = 2, plant = 1
	},
	drop = {
		items = {
			{items = {'farming:pumpkin_slice 9'}, rarity = 1},
		}
	},
	sounds = mcore.sound_wood,
})

minetest.register_alias("farming:pumpkin", "farming:pumpkin_8")