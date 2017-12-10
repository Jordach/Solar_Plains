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