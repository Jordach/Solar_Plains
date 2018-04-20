minetest.register_node("plants:daisy", {
	description = "Daisy Patch",
	tiles = {"plants_daisys.png"},
	drawtype = "mesh",
	mesh = "planar_flower.b3d",
	groups = {snappy=3, flora=1, attached_node=1},
	--use_texture_alpha = true,
	paramtype = "light",
	buildable_to = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
})

minetest.register_node("plants:daisy2", {
	description = "Daisy Patch",
	tiles = {"core_long_grass_2.png"},
	drawtype = "mesh",
	mesh = "extruder_mesh_plant1.b3d",
	groups = {snappy=3, flora=1, attached_node=1},
	--use_texture_alpha = true,
	paramtype = "light",
	buildable_to = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
})

-- register global dyes
-- notes: use flowerbeds for registering the nicer looking farmable flowers.
-- these are registered as :dye:colour

minetest.register_craftitem(":dye:red", {

	description = "Red Dye",
	inventory_image = "dye_red.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:brown", {

	description = "Brown Dye",
	inventory_image = "dye_brown.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:yellow", {

	description = "Red Dye",
	inventory_image = "dye_yellow.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:orange", {

	description = "Orange Dye",
	inventory_image = "dye_orange.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:green", {

	description = "Green Dye",
	inventory_image = "dye_green.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:dark_green", {

	description = "Dark Green Dye",
	inventory_image = "dye_dark_green.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:cyan", {

	description = "Cyan Dye",
	inventory_image = "dye_cyan.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:sky_blue", {

	description = "Sky Blue Dye",
	inventory_image = "dye_sky_blue.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:sea_blue", {

	description = "Sea Blue Dye",
	inventory_image = "dye_sea_blue.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:cherry", {

	description = "Cherry Dye",
	inventory_image = "dye_cherry.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:purple", {

	description = "Purple Dye",
	inventory_image = "dye_purple.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:violet", {

	description = "Violet Dye",
	inventory_image = "dye_violet.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:white", {

	description = "White Dye",
	inventory_image = "dye_white.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:light_grey", {

	description = "Light Grey Dye",
	inventory_image = "dye_light_grey.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:dark_grey", {

	description = "Dark Grey Dye",
	inventory_image = "dye_dark_grey.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:black", {

	description = "Black Dye",
	inventory_image = "dye_black.png",
	groups = {dye = 1},

})