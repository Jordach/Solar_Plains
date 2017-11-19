
local S = farming.intllib

-- melon
minetest.register_craftitem("farming:melon_slice", {
	description = S("Melon Slice"),
	inventory_image = "farming_melon_slice.png",
	on_place = function(itemstack, placer, pointed_thing)
		return farming.place_seed(itemstack, placer, pointed_thing, "farming:melon_1", false)
	end,
	on_use = minetest.item_eat(2),
})

minetest.register_craft({
	output = "farming:melon_8",
	recipe = {
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
		{"farming:melon_slice", "farming:melon_slice", "farming:melon_slice"},
	}
})

minetest.register_craft({
	output = "farming:melon_slice 9",
	recipe = {
		{"", "farming:melon_8", ""},
	}
})

-- melon definition
local crop_def = {
	drawtype = "mesh",
	mesh = "farming_melon_1.x",
	tiles = {"farming_melon.png"},
	paramtype = "light",
	sunlight_propagates = true,
	waving = 1,
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

minetest.register_node("farming:melon_1", table.copy(crop_def))

-- stage 2
crop_def.mesh = "farming_melon_2.x"
minetest.register_node("farming:melon_2", table.copy(crop_def))

-- stage 3
crop_def.mesh = "farming_melon_3.x"
minetest.register_node("farming:melon_3", table.copy(crop_def))

-- stage 4
crop_def.mesh = "farming_melon_4.x"
minetest.register_node("farming:melon_4", table.copy(crop_def))

-- stage 5
crop_def.mesh = "farming_melon_5.x"
minetest.register_node("farming:melon_5", table.copy(crop_def))

-- stage 6
crop_def.mesh = "farming_melon_6.x"
minetest.register_node("farming:melon_6", table.copy(crop_def))

-- stage 7
crop_def.mesh = "farming_melon_7.x"
minetest.register_node("farming:melon_7", table.copy(crop_def))

-- stage 8 (final)
crop_def.mesh = "farming_melon_8.x"
crop_def.walkable = true
crop_def.groups = {snappy = 1, oddly_breakable_by_hand = 1, flammable = 2, plant = 1}
crop_def.drop = "farming:melon_slice 9"
minetest.register_node("farming:melon_8", table.copy(crop_def))
