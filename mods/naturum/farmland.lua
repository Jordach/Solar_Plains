-- naturum
-- replacement for farming_plus
-- License: MIT

local function drink_water(pos)

	local nodep, nodex = minetest.find_nodes_in_area(
		{x=pos.x-4, y=pos.y-2, z=pos.z-4},
		{x=pos.x+4, y=pos.y+1, z=pos.z+4},
		{"core:water_flowing", "core:water_source"})

	if nodex["core:water_source"] > 0 then
		return true
	elseif nodex["core:water_flowing"] > 0 then
		return true
	else
		return false
	end
end

-- water farmland

minetest.register_abm({
	nodenames = {"naturum:soil", "naturum:soil_wet"},
	interval = 5,
	chance = 4,
	action = function(pos)
		if drink_water(pos) then
			if minetest.get_node(pos).name == "naturum:soil_wet" then
				return
			else
				minetest.set_node(pos, {name = "naturum:soil_wet"})
			end
		else
			if minetest.get_node(pos).name == "naturum:soil_wet" then
				minetest.set_node(pos, {name = "naturum:soil"})
			else
				minetest.set_node(pos, {name = "core:dirt"})
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"naturum:soil", "naturum:soil_wet"},
	interval = 120,
	chance = 2,
	action = function(pos)
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		
		if minetest.get_node_light(pos) < 1 and minetest.get_item_group(minetest.get_node(pos).name, "nodec") ~= 1  then
			pos.y = pos.y - 1
			minetest.add_node(pos,{name="core:dirt"})
		end
	end,
})

minetest.register_node("naturum:soil", {
	description = "Farmland",
	tiles = {"core_dirt.png^farming_soil.png", "core_dirt.png"},
	sounds = mcore.sound_dirt,
	groups = {crumbly=3, soil=1, solid=1},
	drop = "core:dirt",
	_waila_texture = minetest.inventorycube(
		"core_dirt.png^farming_soil.png",
		"core_dirt.png",
		"core_dirt.png"
	),
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
})

minetest.register_node("naturum:soil_wet", {
	description = "Wet Farmland",
	tiles = {"core_dirt.png^farming_soil_wet.png", "core_dirt.png^farming_soil_wet_side.png"},
	sounds = mcore.sound_dirt,
	groups = {crumbly=3, soil=1, solid=1},
	drop = "core:dirt",
	_waila_texture= minetest.inventorycube(
		"core_dirt.png^farming_soil_wet.png",
		"core_dirt.png^farming_soil_wet_side.png",
		"core_dirt.png^farming_soil_wet_side.png"
	),
	drawtype = "nodebox",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	selection_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -0.5, 0.5, 0.4375, 0.5},
		}
	},
})