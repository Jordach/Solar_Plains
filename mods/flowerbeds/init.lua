-- flowerbeds; Solar Plains

-- rule 1: namespace everything;
 
flowerbeds = {}

minetest.register_node("flowerbeds:flowerbed", {

	description = "Flowerbed",
	tiles = {"flowerbeds_bed.png", "core_dirt.png", "core_dirt.png^core_grass_side.png"},
	
})

function flowerbeds.register_flower(texture, desc, node_name, sound_table, dye_colour)
	
	-- register node as a flower bed grown plant
	
	minetest.register_node("flowerbeds:grown_"..node_name, {
	
		description = desc,
		tiles = {texture},
		--sounds = sound_table,
		groups = {plant=1, snappy=3},
		drawtype = "mesh",
		mesh = "flowerbeds_plant_bed.b3d",
		paramtype = "light",
	})

	-- register a single flower, as wild ones are like this.
	
	minetest.register_node("flowerbeds:wild_"..node_name , {
	
		description = desc,
		tiles = {texture},
		groups = {plant=1, snappy=3},
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		--sounds = sound_table
		waving = 1,
		on_place = function(itemstack, placer, pointed_thing)
			local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
			return itemstack
		end,
	})
	
	
	
end

flowerbeds.register_flower("flowerbeds_lilac.png", "Lilac", "lilac", {}, "pink")

