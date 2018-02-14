-- stairs, Jordach / Solar Plains redo

-- mods depend on us (to provide them with their own stairs, damn socialists!), so lets make a namespace

stairs = {}

function stairs.register_stair(subname, groups_table, images, desc, sound_table)

	groups_table.stair = 1

	minetest.register_node(":stairs:stair_" .. subname, {
	
		description = desc,
		drawtype = "mesh",
		mesh = "stairs_stair.obj",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups_table,
		sounds = sound_table,
		on_place = mcore.sensible_facedir,
		
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		collision_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0, 0.5},
				{-0.5, 0, 0, 0.5, 0.5, 0.5},
			},
		},
		
	})

end

function stairs.register_slab(subname, groups_table, images, desc, recipeitem, sound_table) -- when did we recruit brick from borderlands 2?

	groups_table.slab = 1
	
	minetest.register_node(":stairs:slab_" .. subname, {
	
		description = desc,
		drawtype = "nodebox",
		tiles = images,
		paramtype = "light",
		paramtype2 = "facedir",
		is_ground_content = false,
		groups = groups_table,
		sounds = sound_table,
		node_box = {
			type = "fixed",
			fixed = {-0.5, -0.5, -0.5, 0.5, 0, 0.5},
		},
		
		on_place = function(itemstack, placer, pointed_thing)
		
			local wielditem = itemstack:get_name()
			local under = minetest.get_node(pointed_thing.under)
			
			if under.name == wielditem and recipeitem ~= nil and placer:get_player_control().sneak == false then -- we check for an existing slab, but also check for the recipe item that generates the slab.
				
				itemstack:take_item()
				minetest.set_node(pointed_thing.under, {name=recipeitem})
				return itemstack
				
			else
			
				minetest.rotate_node(itemstack, placer, pointed_thing) -- if we cannot convert a slab into a full block, we place a slab with 3 axis rotation.
				return itemstack

			end
			
		end,
	})


end

function stairs.register_stair_and_slab(subname, recipeitem, groups_table, images, desc_stair, desc_slab, sound_table)
	
	if recipeitem ~= nil then
		
		-- recipe for stairs;
	
		minetest.register_craft({
			output = 'stairs:stair_' .. subname .. ' 8',
			recipe = {
				{recipeitem, "", ""},
				{recipeitem, recipeitem, ""},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Flipped recipe for the silly minecrafters
		minetest.register_craft({
			output = 'stairs:stair_' .. subname .. ' 8',
			recipe = {
				{"", "", recipeitem},
				{"", recipeitem, recipeitem},
				{recipeitem, recipeitem, recipeitem},
			},
		})

		-- Fuel (Stairs)
		
		-- we check what node the stair is made from and then figure out time to see how long a stair would burn for
		-- since a stair contains 75% of the original node's matter, it'll burn for a quarter of the time less,
		
		local stair_baseburntime = minetest.get_craft_result({
		
			method = "fuel",
			width = 1,
			items = {recipeitem}
			
		}).time
		
		if stair_baseburntime > 0 then
		
			minetest.register_craft({
			
				type = "fuel",
				recipe = 'stairs:stair_' .. subname,
				burntime = math.floor(stair_baseburntime * 0.75),
				
			})
			
		end
				
		-- recipe for slabs
	
		minetest.register_craft({
		
			output = 'stairs:slab_' .. subname .. ' 6',
			recipe = {
				{recipeitem, recipeitem, recipeitem},
			},
			
		})

		-- Fuel
		-- we see what the slab is made from then figure out the time in seconds to see how long a slab would burn for
		-- usually, a single slab will burn for half the time of a full size node.
		
		local slab_baseburntime = minetest.get_craft_result({
		
			method = "fuel",
			width = 1,
			items = {recipeitem}
			
		}).time
		
		if slab_baseburntime > 0 then
			minetest.register_craft({
				type = "fuel",
				recipe = 'stairs:slab_' .. subname,
				burntime = math.floor(slab_baseburntime * 0.5),
			})
			
		end
		
	end
	
	stairs.register_stair(subname, groups_table, images, desc_stair, sound_table)
	stairs.register_slab(subname, groups_table, images, desc_slab, recipeitem, sound_table)
	
end

--[[

Registering your own slabs and stairs:

Take note that your own mods depends.txt must contain the lines separated with a newline (the enter key), default, stairs

If you happen to be using Solar Plains as a base, it is: core, stairs

For this example we are using stairs.register_stair_and_slab(),

instead of stairs.register_slab() or stairs.register_stair().

stairs.register_stair_and_slab("string", "string", {table}, {table with "string"}, "string", "string", {table}) is the layout of the function]

The first argument to register_stair_and_slab is a string, it is used to form the name of the generated stair, eg;

"cobble" would become "stairs:stair_cobble" and "stairs:slab_cobble"

The second argument is a string, and is used to become the recipe of both the stair and slab nodes.

An example block for cobble would look like "core:cobble" or "default:cobble" depending on the installed subgame.

If the block has a fuel value that can be burnt in a furnace, stairs will automatically figure out the burntime of the stair and slab variants.

The third arugment is a table for dealing with node groups, digtimes and things like putting fires out or even setting fire to things.

An example group table for cobble stone would look like: {cracky = 3, solid = 1}

The fourth argument is a table, but can handle upto six different textures.

The example layout for cobble is {"cobble.png"}, but Minetest will provide that to the other six faces automatically if you only have a single item.

If you were to have a different texture on each face, it would look like the following:

{"texture1.png", "texture2.png", "texture3.png", "texture4.png", "texture5.png", "texture6.png"}

If you were to remove texture4, texture5 and texture6, three faces of the stair and slab would be texture3. This applies to all blocks and node within Minetest.

The fifth argument is a string, but is also the description for the registered stair.

An example would look like "Cobblestone Stair"

The sixth argument is a string, and like the one before it, it is the description for the registered slab.

An example would look like "Cobblestone Slab"

The seventh argument is a table, but also the function in Minetest Game that provides sound.

An example to give it stone sounds would be: default.node_sound_stone_defaults()

Remember, you need depends.txt in the same folder as this init.lua.

Without it, this mod will crash the engine when trying to use default.node_sound_stone_defaults() as it cannot access the "default." namespace.

If you want to skip certain parts, like the recipe item, just use nil.

]]

stairs.register_stair_and_slab("cobble", "core:cobble", {cracky = 3}, {"core_cobble.png"}, "Cobble Stair", "Cobble Slab", mcore.sound_stone)

stairs.register_stair_and_slab("stone", "core:stone", {cracky = 3}, {"core_stone.png"}, "Stone Stair", "Stone Slab", mcore.sound_stone)

stairs.register_stair_and_slab("dirt", "core:dirt", {crumbly = 3}, {"core_dirt.png"}, "Dirt Stair", "Dirt Slab", mcore.sound_dirt)

stairs.register_stair_and_slab("sand", "core:sand", {crumbly = 3}, {"core_sand.png"}, "Sand Stair", "Sand Slab", mcore.sound_sand)

stairs.register_stair_and_slab("gravel", "core:gravel", {crumbly = 2}, {"core_gravel.png"}, "Gravel Stair", "Gravel Slab", mcore.sound_sand)

stairs.register_stair_and_slab("clay", "core:clay", {crumbly = 2}, {"core_clay_block.png"}, "Clay Stair", "Clay Slab", mcore.sound_sand)

stairs.register_stair_and_slab("basalt", "core:basalt", {cracky = 1}, {"core_basalt.png"}, "Basalt Stair", "Basalt Slab", mcore.sound_stone)

stairs.register_stair_and_slab("basalt_brick", "core:basalt_brick", {cracky = 1}, {"core_basalt_brick_top.png", "core_basalt_brick_top.png", "core_basalt_brick.png", "core_basalt_brick.png", "core_basalt_brick_bottom.png", "core_basalt_brick_bottom.png"}, "Basalt Brick Stair", "Basalt Brick Slab", mcore.sound_stone)

stairs.register_stair_and_slab("obsidian", "core:obsidian", {cracky = 1}, {"core_obsidian.png"}, "Obsidian Stair", "Obsidian Slab", mcore.sound_stone)

stairs.register_stair_and_slab("obsidian_brick", "core:obsidian_brick", {cracky = 1}, {"core_obsidian_brick_top.png", "core_obsidian_brick_top.png", "core_obsidian_brick.png", "core_obsidian_brick.png", "core_obsidian_brick_bottom.png", "core_obsidian_brick_bottom.png"}, "Obsidian Brick Stair", "Obsidian Brick Slab", mcore.sound_stone)

stairs.register_stair_and_slab("obsidian_glass", "core:obsidian_glass", {cracky = 1}, {"core_obsidian_glass.png"}, "Obsidian Glass Stair", "Obsidian Glass Slab", mcore.sound_stone)

stairs.register_stair_and_slab("mossycobble", "core:mossycobble", {cracky = 2}, {"core_cobble_mossy.png"}, "Mossy Cobblestone Stair", "Mossy Cobblestone Slab", mcore.sound_stone)

stairs.register_stair_and_slab("sandstone", "core:sandstone", {cracky = 2}, {"core_sandstone.png"}, "Sandstone Stair", "Sandstone Slab", mcore.sound_stone)

stairs.register_stair_and_slab("snow", "core:snowblock", {crumbly = 3, puts_out_fire = 1}, {"core_snow.png"}, "Snow Stair", "Snow Slab", mcore.sound_snow)

stairs.register_stair_and_slab("ice", "core:ice", {cracky = 3, puts_out_fire = 1}, {"core_ice.png"}, "Ice Stair", "Ice Slab", mcore.sound_glass)

stairs.register_stair_and_slab("glass", "core:glass", {oddly_breakable_by_hand = 3}, {"core_glass.png"}, "Glass Stair", "Glass Slab", mcore.sound_glass)

-- logs?

stairs.register_stair_and_slab("pine_log", "core:pine_log", {choppy = 3, flammable = 2}, {"core_pine_log.png"}, "Pine Log Stair", "Pine Log Slab", mcore.sound_wood)
stairs.register_stair_and_slab("pine_log_grassy", "core:pine_log_grassy", {choppy = 3, flammable = 2}, {"core_pine_log.png^core_long_grass_1.png"}, "Pine Log (Grassy) Stair", "Pine Log (Grassy) Slab", mcore.sound_wood)

stairs.register_stair_and_slab("oak_log", "core:oak_log", {choppy = 3, flammable = 2}, {"core_oak_log.png"}, "Oak Log Stair", "Oak Log Slab", mcore.sound_wood)
stairs.register_stair_and_slab("oak_log_grassy", "core:oak_log_grassy", {choppy = 3, flammable = 2}, {"core_oak_log.png^core_long_grass_1.png"}, "Oak Log (Grassy) Stair", "Oak Log (Grassy) Slab", mcore.sound_wood)

stairs.register_stair_and_slab("birch_log", "core:birch_log", {choppy = 3, flammable = 2}, {"core_birch_log.png"}, "Birch Log Stair", "Birch Log Slab", mcore.sound_wood)
stairs.register_stair_and_slab("birch_log_grassy", "core:birch_log_grassy", {choppy = 3, flammable = 2}, {"core_birch_log.png^core_long_grass_1.png"}, "Birch Log (Grassy) Stair", "Birch Log (Grassy) Slab", mcore.sound_wood)

stairs.register_stair_and_slab("cherry_log", "core:cherry_log", {choppy = 3, flammable = 2}, {"core_cherry_log.png"}, "Cherry Log Stair", "Cherry Log Slab", mcore.sound_wood)
stairs.register_stair_and_slab("cherry_log_grassy", "core:cherry_log_grassy", {choppy = 3, flammable = 2}, {"core_cherry_log.png^core_long_grass_1.png"}, "Cherry Log (Grassy) Stair", "Cherry Log (Grassy) Slab", mcore.sound_wood)

stairs.register_stair_and_slab("acacia_log", "core:acacia_log", {choppy = 3, flammable = 2}, {"core_acacia_log.png"}, "Acacia Log Stair", "Acacia Log Slab", mcore.sound_wood)
stairs.register_stair_and_slab("acacia_log_grassy", "core:acacia_log_grassy", {choppy = 3, flammable = 2}, {"core_acacia_log.png^core_long_grass_1.png"}, "Acacia Log (Grassy) Stair", "Acacia Log (Grassy) Slab", mcore.sound_wood)

-- planks

stairs.register_stair_and_slab("pine_planks", "core:pine_planks", {choppy = 3, flammable = 2}, {"core_pine_planks.png"}, "Pine Planks Stair", "Pine Planks Slab", mcore.sound_wood)

stairs.register_stair_and_slab("oak_planks", "core:oak_planks", {choppy = 3, flammable = 2}, {"core_oak_planks.png"}, "Oak Planks Stair", "Oak Planks Slab", mcore.sound_wood)

stairs.register_stair_and_slab("birch_planks", "core:birch_planks", {choppy = 3, flammable = 2}, {"core_birch_planks.png"}, "Birch Planks Stair", "Birch Planks Slab", mcore.sound_wood)

stairs.register_stair_and_slab("cherry_planks", "core:cherry_planks", {choppy = 3, flammable = 2}, {"core_cherry_planks.png"}, "Cherry Planks Stair", "Cherry Planks Slab", mcore.sound_wood)

stairs.register_stair_and_slab("acacia_planks", "core:acacia_planks", {choppy = 3, flammable = 2}, {"core_acacia_planks.png"}, "Acacia Planks Stair", "Acacia Planks Slab", mcore.sound_wood)

-- leaves?

stairs.register_stair_and_slab("pine_needles", "core:pine_needles", {snappy = 3, flammable = 2}, {"core_pine_needles.png"}, "Pine Needles Stair", "Pine Needles Slab", mcore.sound_plants)
stairs.register_stair_and_slab("pine_needles_snowy", "core:pine_needles_snowy", {snappy = 3, flammable = 2}, {"core_pine_needles_snowy.png"}, "Pine Needles (Snowy) Stair", "Pine Needles (Snowy) Slab", mcore.sound_plants)

stairs.register_stair_and_slab("oak_leaves", "core:oak_leaves", {snappy = 3, flammable = 2}, {"core_oak_leaves.png"}, "Oak Leaves Stair", "Oak Leaves Slab", mcore.sound_plants)

stairs.register_stair_and_slab("birch_leaves", "core:birch_leaves", {snappy = 3, flammable = 2}, {"core_birch_leaves.png"}, "Birch Leaves Stair", "Birch Leaves Slab", mcore.sound_plants)

stairs.register_stair_and_slab("cherry_leaves", "core:cherry_leaves", {snappy = 3, flammable = 2}, {"core_cherry_leaves.png"}, "Cherry Leaves Stair", "Cherry Leaves Slab", mcore.sound_plants)

stairs.register_stair_and_slab("acacia_leaves", "core:acacia_leaves", {snappy = 3, flammable = 2}, {"core_acacia_leaves.png"}, "Acacia Leaves Stair", "Acacia Leaves Slab", mcore.sound_plants)

-- uhh?

stairs.register_stair_and_slab("grass", "core:grass_1", {snappy = 3}, {"core_grass.png"}, "Grass Stair", "Grass Slab", mcore.sound_grass)

stairs.register_stair_and_slab("grass_wildlands", "core:grass_wild_1", {snappy = 3}, {"core_grass_wild.png"}, "Wildlands Grass Stair", "Wildlands Grass Slab", mcore.sound_grass)