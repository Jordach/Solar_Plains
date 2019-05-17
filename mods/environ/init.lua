-- A simple and straightfowards mod to add those little biome touches that don't exactly fit elsewhere

environ = {}

function environ.register_node_snow(lightname, medname, fullname, override, modname, lightmesh, medmesh, fullmesh)

end

function environ.register_nodebox_snow(lightname, medname, fullname, override, modname, lightbox, medbox, fullbox)

end

minetest.register_abm({
	nodenames = {"group:snow_accum", "group:solid"},
	interval = 45, --tick once every 45 seconds
	chance = 10, -- do it to every 1/3 nodes
	action = function(pos, node)
		-- check if the local area is capable of having snowfall:
		local weather = atmos.get_weather(pos)
		if weather == "snow" or weather == "hail" then
			-- get node registry of the node that snow will settle on
			local nnode = minetest.registered_nodes[minetest.get_node(pos).name]
			
			-- pre-init the variables we need to set information into
			local slight, smed, sfull
			local sdir = 0

			-- where snow is going to fall position
			local spos = table.copy(pos)
			spos.y = spos.y + 1

			-- get the name of the node so we can replace it with snow, or do nothing
			local snode = minetest.get_node(spos).name
			
			-- check if node can see the sky:
			local light = minetest.get_node_light(spos, 0.5)
			
			-- don't let snow fall since we can't actually get to the sky
			if light == nil then
				return 
			elseif light < 13 then
				return
			end
		
			-- set some default snow, in case the node with either solid or snow_accum doesn't have a set node 
			slight = "core:snow"
			smed = "core:snow_medium"
			sfull = "core:snowblock"

			-- replace the previous snow nodes if the node contains a replacement
			if nnode._snow_layer_light ~= nil then
				slight = nnode._snow_layer_light
			end
			if nnode._snow_layer_med ~= nil then
				smed = nnode._snow_layer_med
			end
			if nnode._snow_layer_full ~= nil then
				sfull = nnode._snow_layer_full
			end
			
			-- for nodes with facedir and nodeboxes or meshes, we want the fallen snow to match the rotation of the node,
			-- but only for nodes with a matching facedir
			if nnode._snow_facedir_whitelist ~= nil then
				local fnode = minetest.get_node(pos).param2
				if minetest.registered_nodes[slight].paramtype2 == "facedir" then
					for k, v in pairs(nnode._snow_facedir_whitelist) do
						if v == fnode then
							sdir = fnode
						end
					end
				elseif minetest.registered_nodes[smed].paramtype2 == "facedir" then
					for k, v in pairs(nnode._snow_facedir_whitelist) do
						if v == fnode then
							sdir = fnode
						end
					end
				elseif minetest.registered_nodes[sfull].paramtype2 == "facedir" then
					for k, v in pairs(nnode._snow_facedir_whitelist) do
						if v == fnode then
							sdir = fnode
						end
					end
				end
			end
			-- level each snow layer over time, help spread out the ABM overload
			if snode == "air" then
				minetest.after(math.random(0.5, 25.5), minetest.set_node, spos, {name = slight, param2 = sdir})
			elseif snode == slight then
				minetest.after(math.random(0.5, 25.5), minetest.set_node, spos, {name = smed, param2 = sdir})
			elseif snode == smed then
				minetest.after(math.random(0,5, 25.5), minetest.set_node, spos, {name = sfull, param2 = sdir})
			end
		elseif weather == "rain" or weather == "storm" then

		end
	end,
})

minetest.register_node(":core:snow_medium", {
	tiles = {"core_snow.png"},
	inventory_image = "core_snowball.png",
	description = "Snow",
	wield_image = "core_snowball.png",
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	drop = "core:snow 2",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.0625, 0.5},
		},
	},
	groups = {crumbly=3, falling_node=1, puts_out_fire=1, slippery=1},
	sounds = mcore.sound_snow,
	walkable = false,
	on_construct = function(pos)
		pos.y = pos.y - 1
		if minetest.get_node(pos).name == "core:grass" then
			minetest.set_node(pos, {name = "core:grass_snow"})
		end
	end,
	_snow_melts_to = "core:snow",
})

minetest.register_node("environ:puddle", {
	description = "A puddle, localised entirely in your hands,\nat this time of day, and at this time of year?",
	tiles = {"core_water.png"},
	paramtype = "light",
	buildable_to = true,
	floodable = true,
	drawtype = "nodebox",
	walkable = false,
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, -0.5+0.015625, 0.5},
		},
	},
	groups = {falling_node=1, puts_out_fire=1},
})

minetest.register_node("environ:icicles", {
	description = "Icicles, not for backstabbing.",
	tiles = {"environ_icicles.png"},
	drawtype = "mesh",
	groups = {cracky=3},
	sounds = mcore.sound_glass,
	--drawtype = "mesh",
	--mesh = "environ_icicles.b3d",

})