-- naturum
-- replacement for farming_plus
-- License: what's a license

for i=1, 8 do
	local rare = 8 - (i - 1) * 7 / (8 - 1)
	local drop = {
		items = {
			{items = {"naturum:wheat"}, rarity = rare},
			{items = {"naturum:wheat"}, rarity = rare * 2},
			{items = {"naturum:wheat_seeds"}, rarity = rare},
			{items = {"naturum:wheat_seeds"}, rarity = rare * 2},
		}
	}

	minetest.register_node("naturum:wheat_" .. i, {
		description = "wheat_phase_" .. i,
		tiles = {"farming_wheat_" .. i .. ".png"},
		drawtype = "plantlike",
		paramtype = "light",
		paramtype2 = "meshoptions",
		sounds = mcore.sound_plants,
		walkable = false,
		drop = drop,
		waving = 1,
		groups = {snappy=3, flammable=2, attached_node=1},
	})
	
	if i < 8 then
		naturum.plant_grow_stage(140, 1, "naturum:wheat_"..i, 140, "naturum:wheat_"..i+1, "naturum:soil", "naturum:soil_wet", true)
	end

end

minetest.register_craftitem("naturum:wheat_seeds", {
	description = "Wheat Seeds",
	inventory_image = "farming_wheat_seed.png",
	groups = {seed=1},

	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing.type ~= "node" then
			return
		end
		
		local node = minetest.get_node_or_nil(pointed_thing.under)
		local npos
		local nodedef = minetest.registered_nodes[node.name]

		if nodedef and nodedef.buildable_to then
			npos = pointed_thing.under
		else
			npos = pointed_thing.above
			node = minetest.get_node_or_nil(pointed_thing.above)

			local above_node = minetest.registered_nodes[node.name]

			if not above_node.buildable_to then
				return itemstack
			end
		end

		local is_soil = minetest.get_item_group(node, "soil")

		if is_soil == 0 then
			itemstack:take_item()
			minetest.set_node(npos, {name = "naturum:wheat_1", param2 = mcore.options("croplike", false, true, false)})
			minetest.get_node_timer(npos):start(140+math.random(-20, 20))
		end
		return itemstack
	end,

})

minetest.register_craftitem("naturum:wheat", {
	description = "Wheat",
	inventory_image = "farming_wheat.png",
})

minetest.register_craftitem("naturum:flour", {
	description = "Flour",
	inventory_image = "farming_flour.png",
})

minetest.register_craftitem("naturum:bread", {
	description = "Bread",
	inventory_image = "farming_bread.png",
	on_use = minetest.item_eat(5)
})

minetest.register_craftitem("naturum:toast", {
	description = "Toast",
	inventory_image = "farming_toast.png",
	on_use = minetest.item_eat(7)

})


minetest.register_craft({
	type = "shapeless",
	output = "naturum:wheat_seeds 2",
	recipe = {
		"naturum:wheat",
	},
})

minetest.register_craft({
	output = "naturum:flour 4",
	recipe = {
		{"naturum:wheat", "naturum:wheat"},
		{"naturum:wheat", "naturum:wheat"},
	}
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:bread",
	recipe = "farming:flour",
})

minetest.register_craft({
	type = "cooking",
	cooktime = 15,
	output = "farming:toast",
	recipe = "farming:bread",
})