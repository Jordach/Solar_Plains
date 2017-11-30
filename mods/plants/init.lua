minetest.register_node("plants:daisy", {
	description = "Daisy Patch",
	tiles = {"plants_daisys.png"},
	drawtype = "mesh",
	mesh = "planar_flower.b3d",
	groups = {snappy=3, flora=1},
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
	groups = {snappy=3, flora=1},
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