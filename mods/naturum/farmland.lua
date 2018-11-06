-- naturum
-- replacement for farming_plus
-- License: MIT

--timer:start(55+math.random(-20, 20))
local function drink_water(pos)
	for x=-4, 4 do
		for y=-2, -1 do
			for z=-4, 4 do
				local node = minetest.get_node({x=pos.x + x, y = pos.y + y, z = pos.z + z})
				if node.name == "core:water_flowing" then
					return true
				elseif node.name == "core:water_source" then
					return true
				end
			end
		end
	end

	return false
end

minetest.register_node("naturum:soil", {
	description = "well played, you shouldn't have this",
	tiles = {"core_dirt.png^farming_soil.png", "core_dirt.png"},
	sounds = mcore.sound_dirt,
	groups = {crumbly=3, soil=1, solid=1, dirt=1},
	drop = "core:dirt",

	on_timer = function(pos, elapsed)
		if drink_water(pos) then
			minetest.set_node(pos, {name = "naturum:soil_wet"})
			return false
		else
			return true
		end
	end,
})

minetest.register_node("naturum:soil_wet", {
	description = "well played, you shouldn't have this",
	tiles = {"core_dirt.png^farming_soil_wet.png", "core_dirt.png"},
	sounds = mcore.sound_dirt,
	groups = {crumbly=3, soil=1, solid=1, dirt=1},
	drop = "core:dirt",
})