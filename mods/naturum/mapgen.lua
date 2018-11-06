-- naturum
-- replacement for farming_plus
-- License: what's a license

--[[

	How to add plants to mapgen:

	biome is a table of strings that are valid biomes for the plant to spawn in
	node is the target plant to be spawned into the world
	plant_on is the node, or table of strings that the plant can be planted onto
	fill is the ratio of the biome being filled with the selected plant
	div is the number of divisions of a 5x5x5 area of 16^3 chunks
	nearby is a node, or table of strings containing target nodes for the plant to spawn near

]]--

function naturum.register_mapgen(biome, node, plant_on, fill, div, nearby, near_num)
	minetest.register_decoration({
		deco_type = "simple",
		biomes = biome,
		height = 1,
		decoration = {node},
		spawn_by = nearby,
		sidelen = div,
		fill_ratio = fill,
		place_on = plant_on,
		num_spawn_by = near_num
	})
end