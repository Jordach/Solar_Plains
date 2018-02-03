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

--[[

table of good looking sky colours:

	winter twilight:
	
	local side_col = "#14184b" 
		
	local side_mid_col = "#14384b"
		
	local side_ovl = "#31746a"
	
	sunrise and sunset:
	
	local side_col = "#ffc875" 
	
	local side_mid_col = "#ff7c1f"
	
	local side_ovl = "#e65800"
	
	daytime:
	
	
	
]]--

minetest.register_chatcommand("starbox", {

	description = "debug starbox",
	
	func = function(name)
	
		local player = minetest.get_player_by_name(name)
		
		-- top of skybox	
		local side_col = "#b8d7ff" 
		
		-- middle blend part of skybox
		local side_mid_col = "#63a3f7"
		
		-- bottom of skybox
		local side_ovl = "#3d80d9" 
		
		-- string for skybox sides
		local side_str = "(sky_test_side.png^[multiply:" .. side_mid_col .. ")^(sky_test_side_ovl.png^[multiply:" .. side_ovl .. ")^(sky_test_side_ovl_2.png^[multiply:" .. side_col .. ")"
		
		player:set_sky(side_col, "skybox", {"sky_test_top.png^[multiply:" .. side_col, 
																"sky_test_bottom.png^[multiply:" .. side_ovl,
																side_str,
																side_str,
																side_str,
																side_str}, true)
		
	player:set_clouds({
		
		density = atmos.weather_clouds[3],
		color = atmos.weather_cloud_colour[3],
		thickness = atmos.weather_cloud_thicc[3],
		height = atmos.weather_cloud_height[3],
		
	})
		
	player:override_day_night_ratio(1)
	
	end,
	
})