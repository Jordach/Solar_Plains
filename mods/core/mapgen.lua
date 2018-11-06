-- core functions

minetest.clear_registered_biomes()
minetest.clear_registered_decorations()

-- meshoptions helper function

-- setting meshtypes to:
-- cross is x
-- plus is +
-- croplike is #
-- excroplike is # but the tips are more like a >
-- asterisk is like * but with three faces

-- horizonal is a bool operator - true makes it randomly positioned on x and y
-- height changes where the base of the plant is randomly pushed into the ground
-- size makes the plant 1.4 times bigger

function mcore.options(meshtype, horizontal, height, size)
	local pshape, bit1, bit2, bit3 = 0, 0, 0, 0

	if meshtype == "cross" then
		pshape = 0
	elseif meshtype == "plus" then
		pshape = 1
	elseif meshtype == "asterisk" then
		pshape = 2
	elseif meshtype == "croplike" then
		pshape = 3
	elseif meshtype == "excroplike" then
		pshape = 4
	end
	
	if horizontal then
		bit1 = 8
	end
	
	if size then
		bit2 = 16
	end
	
	if height then
		bit3 = 32
	end
	
	return pshape+bit1+bit2+bit3
end	

-- mapgen specific trees and mapgen saplings - mg_saplings grow trees with vmanip at mapgen

minetest.register_node("core:mg_oak_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_pine_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_pine_snowy_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_birch_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_cherry_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_acacia_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

minetest.register_node("core:mg_wimba_sapling", {
	description = "Impossible to get node.",
	drawtype = "airlike",
	paramtype = "light",
	--tiles = {"xfences_space.png"},
	groups = {not_in_creative_inventory=1},
})

-- vmanip on generate

local c_mg_birch_sap = minetest.get_content_id("core:mg_birch_sapling")
local c_mg_cherry_sap = minetest.get_content_id("core:mg_cherry_sapling")
local c_mg_oak_sap = minetest.get_content_id("core:mg_oak_sapling")
local c_mg_pine_sap = minetest.get_content_id("core:mg_pine_sapling")
local c_mg_pine_snowy_sap = minetest.get_content_id("core:mg_pine_snowy_sapling")
local c_mg_grass = minetest.get_content_id("core:mg_grass")
local c_mg_grass_snowy = minetest.get_content_id("core:mg_grass_snowy")
local c_mg_aca_sap = minetest.get_content_id("core:mg_acacia_sapling")
local c_mg_wim_sap = minetest.get_content_id("core:mg_wimba_sapling")

minetest.register_on_generated(function(minp, maxp, seed)
	local timer = os.clock()
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local data = vm:get_data()
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local trees_grown = 0
	for z=minp.z, maxp.z, 1 do
		for y=minp.y, maxp.y, 1 do
			for x=minp.x, maxp.x, 1 do
				local p_pos = area:index(x,y,z)
				local content_id = data[p_pos]
				
				if content_id == c_mg_birch_sap then
					mcore.grow_tree({x=x, y=y, z=z}, false, "core:birch_log", "core:birch_leaves", nil, nil)
					trees_grown = trees_grown + 1
				
				elseif content_id == c_mg_cherry_sap then
					mcore.grow_tree({x=x, y=y, z=z}, false, "core:cherry_log", "core:cherry_leaves", "core:fallen_cherry_leaves", 1.15)
					trees_grown = trees_grown + 1
				
				elseif content_id == c_mg_oak_sap then
					mcore.grow_tree({x=x, y=y, z=z}, false, "core:oak_log", "core:oak_leaves", nil, nil)
					trees_grown = trees_grown + 1
				
				elseif content_id == c_mg_pine_sap then
					mcore.grow_pine({x=x, y=y, z=z}, false)
					trees_grown = trees_grown + 1
				
				elseif content_id == c_mg_pine_snowy_sap then
					mcore.grow_pine({x=x, y=y, z=z}, true)
					trees_grown = trees_grown + 1
				
				elseif content_id == c_mg_aca_sap then
					mcore.create_acacia_tree({x=x, y=y, z=z})
					trees_grown = trees_grown + 1

				elseif content_id == c_mg_wim_sap then
					mcore.create_wimba_tree({x=x, y=y, z=z})
					trees_grown = trees_grown + 1
				end
			end
		end
	end
	local geninfo = string.format(" trees grown after: %.2fs", os.clock() - timer)
	print (trees_grown..geninfo)
	
	vm:set_data(data)
	vm:calc_lighting()
	vm:update_liquids()
	vm:update_map()
end)

-- tree vmanip function

local random = math.random

local function add_pine_needles(data, vi, c_air, c_ignore)
	if data[vi] == c_air or data[vi] == c_ignore then
		data[vi] = minetest.get_content_id("core:pine_needles")
	end
end

local function add_pine_snow(data, vi, c_air, c_ignore)
	if data[vi] == c_air or data[vi] == c_ignore then
		data[vi] = minetest.get_content_id("core:pine_needles_snowy")
	end
end

local function add_snow(data, vi, c_air, c_ignore)
	if data[vi] == c_air or data[vi] == c_ignore then
		data[vi] = minetest.get_content_id("core:snow")
	end
end

function mcore.grow_pine(pos, boolsnow)
	local x, y, z = pos.x, pos.y, pos.z
	local maxy = y + math.random(7, 13) --trunk top
	
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_pinetree = minetest.get_content_id("core:pine_log")
	local c_pine_needles = minetest.get_content_id("core:pine_needles")
	local c_snow = minetest.get_content_id("core:snow")
	local c_snowblock = minetest.get_content_id("core:snowblock")
	local c_dirtsnow = minetest.get_content_id("core:grass_snow")
	
	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = x - 3, y = y - 1, z = z - 3},
		{x = x + 3, y = maxy + 3, z = z + 3}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	
	--upper branches
	
	local dev = 3
	for yy = maxy - 1, maxy + 1 do
		for zz = z - dev, z + dev do
			local vi = a:index(x - dev, yy, zz)
			for xx = x - dev, x + dev do
				if math.random() < 0.95 - dev * 0.05 then
					if boolsnow == false then
						add_pine_needles(data, vi, c_air, c_ignore)
					elseif boolsnow == true then
						add_pine_snow(data, vi, c_air, c_ignore)
					else
						add_pine_needles(data, vi, c_air, c_ignore)
					end
				end
				vi  = vi + 1
			end
		end
		dev = dev - 1
	end
	
	--center top nodes
	
	if boolsnow == false then
		add_pine_needles(data, a:index(x, maxy + 1, z), c_air, c_ignore)
		add_pine_needles(data, a:index(x, maxy + 2, z), c_air, c_ignore)
		-- Paramat added a pointy top node
	elseif boolsnow == true then
		add_pine_snow(data, a:index(x, maxy + 1, z), c_air, c_ignore)
		add_pine_snow(data, a:index(x, maxy + 1, z), c_air, c_ignore)
	-- Lower branches layer
	else
		add_pine_needles(data, a:index(x, maxy + 1, z), c_air, c_ignore)
		add_pine_needles(data, a:index(x, maxy + 1, z), c_air, c_ignore)
	end
	
	local my = 0
	for i = 1, 20 do -- Random 2x2 squares of needles
		local xi = x + math.random(-3, 2)
		local yy = maxy + math.random(-6, -5)
		local zi = z + math.random(-3, 2)
		if yy > my then
			my = yy
		end
		for zz = zi, zi+1 do
			local vi = a:index(xi, yy, zz)
			for xx = xi, xi + 1 do
				if boolsnow == false then
					add_pine_needles(data, vi, c_air, c_ignore)
				elseif boolsnow == true then
					add_pine_snow(data, vi, c_air, c_ignore)
					add_pine_needles(data, vi, c_air, c_ignore)
				else
					add_pine_snow(data, vi, c_air, c_ignore)
				end
				vi  = vi + 1
			end
		end
	end

	local dev = 2
	for yy = my + 1, my + 2 do
		for zz = z - dev, z + dev do
			local vi = a:index(x - dev, yy, zz)
			for xx = x - dev, x + dev do
				if random() < 0.95 - dev * 0.05 then
					if boolsnow == false then
						add_pine_needles(data, vi, c_air, c_ignore)
					elseif boolsnow == true then
						add_pine_snow(data, vi, c_air, c_ignore)
						add_pine_needles(data, vi, c_air, c_ignore)
					else
						add_pine_snow(data, vi, c_air, c_ignore)
					end
				end
				vi  = vi + 1
			end
		end
		dev = dev - 1
	end

	-- Trunk
	for yy = y, maxy do
		local vi = a:index(x, yy, z)
		data[vi] = c_pinetree
	end

	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()
end

--standard trees

local function add_trunk_and_leaves(data, a, pos, tree_cid, leaves_cid,
		height, size, iters, is_apple_tree, log_grass)
	local x, y, z = pos.x, pos.y, pos.z
	local c_air = minetest.get_content_id("air")
	local c_ignore = minetest.get_content_id("ignore")
	local c_apple = minetest.get_content_id("base:dirt")
	local c_cherry = minetest.get_content_id("core:fallen_cherry_leaves")
	
	-- Trunk
	for y_dist = 0, height - 1 do
		local vi = a:index(x, y + y_dist, z)
		local node_id = data[vi]
		
		if y_dist == 0 then
		
			data[vi] = log_grass
		
		elseif node_id == c_air or node_id == c_ignore
		or node_id == leaves_cid then
			
			data[vi] = tree_cid
			
		end
		
	end

	-- Force leaves near the trunk
	for z_dist = -1, 1 do
	for y_dist = -size, 1 do
		local vi = a:index(x - 1, y + height + y_dist, z + z_dist)
		for x_dist = -1, 1 do
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
			vi = vi + 1
		end
	end
	end

	-- Randomly add leaves in 2x2x2 clusters.
	for i = 1, iters do
		local clust_x = x + random(-size, size - 1)
		local clust_y = y + height + random(-size, 0)
		local clust_z = z + random(-size, size - 1)

		for xi = 0, 1 do
		for yi = 0, 1 do
		for zi = 0, 1 do
			local vi = a:index(clust_x + xi, clust_y + yi, clust_z + zi)
			if data[vi] == c_air or data[vi] == c_ignore then
				if is_apple_tree and random(1, 8) == 1 then
					data[vi] = c_apple
				else
					data[vi] = leaves_cid
				end
			end
		end
		end
		end
	end
end

function mcore.create_acacia_tree(pos)

	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("core:dirt")
	local c_leaves = minetest.get_content_id("core:acacia_leaves")
	local c_trunk = minetest.get_content_id("core:acacia_log")
	local c_trunk_grassy = minetest.get_content_id("core:acacia_log_grassy")

	local x2, y2, z2 = pos.x, pos.y, pos.z
	
	local mid_point = math.random(4,6)
	
	local vm = minetest.get_voxel_manip()
	
	local minp, maxp = vm:read_from_map(
		{x = pos.x - 5, y = pos.y, z = pos.z - 5},
		{x = pos.x + 5, y = pos.y + mid_point*2 + 1, z = pos.z + 5}
	)
	
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	
	local tree_model = math.random(1,3) -- three models currently.
	
	for i=0, mid_point-1 do
			
		local vi = a:index(x2, y2 + i, z2)
			
		if i == 0 then
			
			data[vi] = c_trunk_grassy
			
		elseif data[vi] == c_air or data[vi] == c_ignore or data[vi] == c_leaves then
			
			data[vi] = c_trunk
			
		end
			
	end
	
	if tree_model == 1 then
		
		-- lets make the tree fork on the x-axis since the sun goes east to west;
		
		local h_rand = math.random(0,1)
		
		local vi = a:index(x2 - 1, y2 + math.floor((mid_point - h_rand) / 2), z2)
		data[vi] = c_trunk
		
		vi = a:index(x2 - 2, (y2 + 1) + math.floor((mid_point - h_rand) / 2), z2)
		data[vi] = c_trunk
		
		vi = a:index(x2 + 1, y2 + mid_point, z2)
		data[vi] = c_trunk
		
		vi = a:index(x2 + 2, y2 + mid_point + 1, z2)
		data[vi] = c_trunk
		
		vi = nil
		
		-- leaf me alone
		
		for xl=-2, 2 do -- top part of the top fork
		
			for zl=-2, 2 do
				
				local vi = a:index((x2 + 2) + xl, (y2 + mid_point) + 2, z2 + zl)
				
				if xl == -2 and zl == -2 then
				elseif xl == -2 and zl == 2 then
				elseif xl == 2 and zl == -2 then
				elseif xl == 2 and zl == 2 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
		for xl=-3, 3 do -- second part of the top fork
		
			for zl=-3, 3 do
				
				local vi = a:index((x2 + 2) + xl, (y2 + mid_point) + 1, z2 + zl)
				
				if xl == -3 and zl == -3 then
				elseif xl == -3 and zl == 3 then
				elseif xl == 3 and zl == -3 then
				elseif xl == 3 and zl == 3 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
		for xl=-2, 2 do -- top part of the lower fork
		
			for zl=-2, 2 do
				
				local vi = a:index((x2 - 2) + xl, (y2 + 2) + math.floor((mid_point - h_rand) / 2), z2 + zl)
				
				if xl == -2 and zl == -2 then
				elseif xl == -2 and zl == 2 then
				elseif xl == 2 and zl == -2 then
				elseif xl == 2 and zl == 2 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
		for xl=-3, 3 do -- lower part of the bottom fork
		
			for zl=-3, 3 do
				
				local vi = a:index((x2 - 2) + xl, (y2 + 1) + math.floor((mid_point - h_rand) / 2), z2 + zl)
				
				if xl == -3 and zl == -3 then
				elseif xl == -3 and zl == 3 then
				elseif xl == 3 and zl == -3 then
				elseif xl == 3 and zl == 3 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
	elseif tree_model == 2 then -- simple oak like tree
	
		for xl=-2, 2 do -- top part 
		
			for zl=-2, 2 do
				
				local vi = a:index(x2 + xl, y2 + mid_point + 1, z2 + zl)
				
				if xl == -2 and zl == -2 then
				elseif xl == -2 and zl == 2 then
				elseif xl == 2 and zl == -2 then
				elseif xl == 2 and zl == 2 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
		for xl=-3, 3 do -- lower part
		
			for zl=-3, 3 do
				
				local vi = a:index(x2 + xl, y2 + mid_point, z2 + zl)
				
				if xl == -3 and zl == -3 then
				elseif xl == -3 and zl == 3 then
				elseif xl == 3 and zl == -3 then
				elseif xl == 3 and zl == 3 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
	
	elseif tree_model == 3 then
		
		local vi = a:index(x2 - 1, y2 + mid_point, z2)
		data[vi] = c_trunk
		
		vi = a:index(x2 - 2, y2 + mid_point + 1, z2)
		data[vi] = c_trunk
		
		for xl=-2, 2 do -- top part of the top fork
		
			for zl=-2, 2 do
				
				local vi = a:index((x2 - 2) + xl, (y2 + mid_point) + 2, z2 + zl)
				
				if xl == -2 and zl == -2 then
				elseif xl == -2 and zl == 2 then
				elseif xl == 2 and zl == -2 then
				elseif xl == 2 and zl == 2 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
		for xl=-3, 3 do -- second part of the top fork
		
			for zl=-3, 3 do
				
				local vi = a:index((x2 - 2) + xl, (y2 + mid_point) + 1, z2 + zl)
				
				if xl == -3 and zl == -3 then
				elseif xl == -3 and zl == 3 then
				elseif xl == 3 and zl == -3 then
				elseif xl == 3 and zl == 3 then
				elseif data[vi] == c_air then
					if math.random (1,100) < 85 then
						data[vi] = c_leaves
					end
				end
			
			end
		
		end
		
	end
	
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()

end


local function place_leaves_on_ground(pos, chance, fallen_leaves_node)
	
	local x2, y2, z2 = pos.x, pos.y, pos.z
	
	for zi=-3, 3 do
		for xi=-3, 3 do
			for yi=-3, 3 do
				if math.random(1, chance) == 1 then
					if zi == -3 and xi == -3 then
						--minetest.set_node({x=x2+xi, y=y2, z=z2+zi}, {name="air"})
					elseif zi == -3 and xi == 3 then
						--minetest.set_node({x=x2+xi, y=y2, z=z2+zi}, {name="air"})
					elseif zi == 3 and xi == -3 then
						--minetest.set_node({x=x2+xi, y=y2, z=z2+zi}, {name="air"})
					elseif zi == 3 and xi == 3 then
						--minetest.set_node({x=x2+xi, y=y2, z=z2+zi}, {name="air"})
					else
						if minetest.get_node_or_nil({x=x2+xi, y=y2+yi, z=z2+zi}).name == "air" and minetest.get_item_group(minetest.get_node_or_nil({x=x2+xi, y=y2+yi-1, z=z2+zi}).name, "solid") == 1 then
							minetest.set_node({x=x2+xi, y=y2+yi, z=z2+zi}, {name=fallen_leaves_node})
							break
						end
					end
				end
			end
		end
	end
end

-- Appletree

function mcore.grow_tree(pos, is_apple_tree, trunk_node, leaves_node, fallen_leaves_node, chance)
	--[[
		NOTE: Tree-placing code is currently duplicated in the engine
		and in games that have saplings; both are deprecated but not
		replaced yet
	--]]
	
	if fallen_leaves_node ~= nil or chance ~= nil then
		place_leaves_on_ground(pos, chance, fallen_leaves_node)
	end
	
	local x, y, z = pos.x, pos.y, pos.z
	local height = random(4, 7)
	local c_tree = minetest.get_content_id(trunk_node)
	local c_leaves = minetest.get_content_id(leaves_node)
	local log_grass = minetest.get_content_id(trunk_node .. "_grassy")
	
	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = pos.x - 2, y = pos.y, z = pos.z - 2},
		{x = pos.x + 2, y = pos.y + height + 1, z = pos.z + 2}
	)
	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()
	
	add_trunk_and_leaves(data, a, pos, c_tree, c_leaves, height, 2, 8, is_apple_tree, log_grass)
	
	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()
end

function mcore.create_wimba_tree(pos)
	local c_air = minetest.get_content_id("air")
	local c_dirt = minetest.get_content_id("core:dirt")
	local c_leaves = minetest.get_content_id("core:wimba_leaves")
	local c_trunk = minetest.get_content_id("core:wimba_log")
	local c_trunk_grassy = minetest.get_content_id("core:wimba_log_grassy")
	local c_vine_co = minetest.get_content_id("core:vine")
	
	local x2, y2, z2 = pos.x, pos.y, pos.z

	local height = math.random(8, 16)

	local vm = minetest.get_voxel_manip()
	local minp, maxp = vm:read_from_map(
		{x = pos.x - 5, y = pos.y - 1, z = pos.z - 5},
		{x = pos.x + 5, y = pos.y + height + 1, z = pos.z + 5}
	)

	local a = VoxelArea:new({MinEdge = minp, MaxEdge = maxp})
	local data = vm:get_data()

	for i=0, height do
		local vi = a:index(x2, y2 + i, z2)
		if i == 0 then
			data[vi] = c_trunk_grassy
		elseif data[vi] == c_air or data[vi] == c_ignore then
			data[vi] = c_trunk
		end
	end

	-- draw the little X shaped trunk at the bottom:
	local vi = a:index(x2-1, y2-1, z2-1)
	data[vi] = c_trunk_grassy
	vi = a:index(x2-1, y2-1, z2+1)
	data[vi] = c_trunk_grassy
	vi = a:index(x2+1, y2-1, z2-1)
	data[vi] = c_trunk_grassy
	vi = a:index(x2+1, y2-1, z2+1)
	data[vi] = c_trunk_grassy

	vi = a:index(x2-1, y2, z2-1)
	data[vi] = c_trunk
	vi = a:index(x2-1, y2, z2+1)
	data[vi] = c_trunk
	vi = a:index(x2+1, y2, z2-1)
	data[vi] = c_trunk
	vi = a:index(x2+1, y2, z2+1)
	data[vi] = c_trunk

	for xl=-4, 4 do -- lower leaves
		for zl=-4, 4 do
			vi = a:index(x2 + xl, y2 + height, z2 + zl)
			
			if xl == -4 and zl == -4 then
			elseif xl == -4 and zl == 4 then
			elseif xl == 4 and zl == -4 then
			elseif xl == 4 and zl == 4 then
			elseif data[vi] == c_air then
				if math.random (1,100) < 92 then
					data[vi] = c_leaves
				end
			end

			-- RIP vine.co
			if xl == -4 and zl == -4 then
			elseif xl == -4 and zl == 4 then
			elseif xl == 4 and zl == -4 then
			elseif xl == 4 and zl == 4 then
			else
				if math.random (1,12) == 1 then
					for y1 = 1, math.random(5, height-1) do
						vi = a:index(x2 + xl, y2 + height - y1, z2 + zl)
						if data[vi] == c_air then
							data[vi] = c_vine_co
						end
					end
				end
			end
		end
	end

	for xl=-3, 3 do -- top part 
		for zl=-3, 3 do
			local vi = a:index(x2 + xl, y2 + height + 1, z2 + zl)
			
			if xl == -3 and zl == -3 then
			elseif xl == -3 and zl == 3 then
			elseif xl == 3 and zl == -3 then
			elseif xl == 3 and zl == 3 then
			elseif data[vi] == c_air then
				if math.random (1,100) < 85 then
					data[vi] = c_leaves
				end
			end
		end
	end

	for xl=-2, 2 do -- top part 
		for zl=-2, 2 do
			local vi = a:index(x2 + xl, y2 + height + 2, z2 + zl)
			
			if xl == -2 and zl == -2 then
			elseif xl == -2 and zl == 2 then
			elseif xl == 2 and zl == -2 then
			elseif xl == 2 and zl == 2 then
			elseif data[vi] == c_air then
				if math.random (1,100) < 85 then
					data[vi] = c_leaves
				end
			end
		end
	end

	vm:set_data(data)
	vm:calc_lighting()
	vm:write_to_map()
	vm:update_map()
end

-- biome defs

minetest.register_biome({

	name = "plains",
	
	node_top = "core:grass",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 1,
	y_max = 120,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 45,
	humidity_point = 50,

})

minetest.register_biome({

	name = "highlands",
	
	node_top = "core:grass",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 30,
	y_max = 220,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 45,
	humidity_point = 76,

})

minetest.register_biome({

	name = "plains_forest",
	
	node_top = "core:grass",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 10,
	y_max = 80,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 45,
	humidity_point = 10,

})

minetest.register_biome({

	name = "beach",
	
	node_top = "core:sand",
	depth_top = 1,
	
	node_filler = "core:sand",
	depth_filler = 3,
	
	y_min = 0,
	y_max = 4,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 45,
	humidity_point = 35,

})

minetest.register_biome({

	name = "gravel_beach",
	
	node_top = "core:gravel",
	depth_top = 1,
	
	node_filler = "core:gravel",
	depth_filler = 3,
	
	y_min = 0,
	y_max = 4,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 45,
	humidity_point = 76,

})

minetest.register_biome({

	name = "beach_cold",
	
	node_dust = "core:snow",
	
	node_top = "core:sand",
	depth_top = 1,
	
	node_filler = "core:sand",
	depth_filler = 3,
	
	y_min = 0,
	y_max = 4,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	node_water_top = "core:ice",
	depth_water_top = 1,
	
	heat_point = 20,
	humidity_point = 35,

})

minetest.register_biome({

	name = "snowy_plains",
	
	node_dust = "core:snow",
	
	node_top = "core:grass_snow",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	node_water_top = "core:ice",
	depth_water_top = 1,
	
	y_min = 4,
	y_max = 150,
	
	heat_point = 20,
	humidity_point = 50,

})

minetest.register_biome({

	name = "snowy_mountain",
	
	node_dust = "core:snow",
	
	node_top = "core:snowblock",
	depth_top = 1,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	node_water_top = "core:ice",
	depth_water_top = 1,
	
	y_min = 150,
	y_max = 1000,
	
	heat_point = 50,
	humidity_point = 50,

})

minetest.register_biome({

	name = "snowy_forest",
	
	node_dust = "core:snow",
	
	node_top = "core:grass_snow",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 30,
	y_max = 150,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	node_water_top = "core:ice",
	depth_water_top = 1,
	
	heat_point = 12,
	humidity_point = 25,

})

-- man's not hot

minetest.register_biome({

	name = "desert",
	
	node_top = "core:sand",
	depth_top = 1,
	
	node_filler = "core:sandstone",
	depth_filler = 3,
	
	node_stone = "core:sandstone",
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	y_min = 15,
	y_max = 1000,
	
	heat_point = 85,
	humidity_point = 75,

})

minetest.register_biome({

	name = "hot_beach",
	
	node_top = "core:sand",
	depth_top = 1,
	
	node_filler = "core:sand",
	depth_filler = 3,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	y_min = 0,
	y_max = 4,
	
	heat_point = 75,
	humidity_point = 50,

})

minetest.register_biome({

	name = "jungle",
	
	node_top = "core:grass_wildland",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 4,
	y_max = 60,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 85,
	humidity_point = 30,

})

minetest.register_biome({

	name = "wildlands",
	
	node_top = "core:grass_wildland",
	depth_top = 1,
	
	node_filler = "core:dirt",
	depth_filler = 3,
	
	y_min = 4,
	y_max = 60,
	
	node_water = "core:water_source",
	node_river_water = "core:water_source",
	
	heat_point = 75,
	humidity_point = 50,

})

-- ocean

minetest.register_biome({
		name = "ocean",
		
		node_top = "core:sand",
		depth_top = 1,
		
		node_filler = "core:sand",
		depth_filler = 3,
		
		node_water = "core:water_source",
		node_river_water = "core:water_source",
		
		y_min = -112,
		y_max = 0,
		
		heat_point = 50,
		humidity_point = 50,
})

-- register decorum

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_snow",
	decoration = {"core:mg_pine_snowy_sapling"},
	sidelen = 16,
	fill_ratio = 0.02,
	biomes = {"snowy_forest"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:mg_pine_sapling"},
	sidelen = 16,
	fill_ratio = 0.025,
	biomes = {"highlands"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:mg_oak_sapling"},
	sidelen = 16,
	fill_ratio = 0.01,
	biomes = {"plains_forest"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:mg_birch_sapling"},
	sidelen = 16,
	fill_ratio = 0.008,
	biomes = {"plains_forest"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:mg_cherry_sapling"},
	sidelen = 16,
	fill_ratio = 0.001,
	biomes = {"plains_forest"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = {"core:grass"},
	decoration = {"core:mg_oak_sapling", "core:mg_cherry_sapling", "core:mg_birch_sapling"},
	sidelen = 80,
	fill_ratio = 0.0001,
	biomes = {"plains"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:grass_1", "core:grass_2", "core:grass_3"},
	sidelen = 16,
	fill_ratio = 0.2,
	biomes = {"plains", "plains_forest", "highlands"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_wildland",
	decoration = {"core:mg_acacia_sapling"},
	sidelen = 40,
	fill_ratio = 0.0002,
	biomes = {"wildlands"},
	height = 1,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_wildland",
	decoration = {"core:grass_wild_1", "core:grass_wild_2", "core:grass_wild_3"},
	sidelen = 20,
	fill_ratio = 0.02,
	biomes = {"wildlands"},
	height = 1,
	param2 = mcore.options("cross", true, true, true),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_wildland",
	decoration = {"core:grass_wild_1", "core:grass_wild_2", "core:grass_wild_3"},
	sidelen = 20,
	fill_ratio = 0.3,
	biomes = {"jungle"},
	height = 1,
	param2 = mcore.options("cross", true, true, true),
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_wildland",
	decoration = {"core:bamboo"},
	sidelen = 20,
	fill_ratio = 0.02,
	biomes = {"jungle"},
	height = 4,
	height_max = 6,
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass_wildland",
	decoration = {"core:mg_wimba_sapling"},
	sidelen = 16,
	fill_ratio = 0.08,
	biomes = {"jungle"},
	height = 1,
	--height = 8,
	--height_max = 14,
})

-- plants items

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:daisy"},
	sidelen = 16,
	fill_ratio = 0.12,
	biomes = {"plains", "highlands"},
	height = 1,
})

-- cactus

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:sand",
	decoration = {"core:cactus"},
	sidelen = 20,
	fill_ratio = 0.0004,
	biomes = {"desert"},
	height = 3,
	height_max = 5,
})

--

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"core:papyrus"},
	y_min = 1,
	y_max = 1,
	height = 2,
	height_max = 5,
	spawn_by = "core:water_source",
	num_spawn_by = 1,
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.87,
		spread = {x = 95, y = 95, z = 95},
		seed = 354,
		octaves = 3,
		persist = 0.8
	},
})

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:sand",
	biomes = {"hot_beach"},
	decoration = {"core:papyrus"},
	y_min = 1,
	y_max = 1,
	height = 2,
	height_max = 5,
	spawn_by = "core:water_source",
	num_spawn_by = 1,
	sidelen = 16,
	noise_params = {
		offset = -0.3,
		scale = 0.87,
		spread = {x = 150, y = 150, z = 150},
		seed = 145,
		octaves = 3,
		persist = 0.8
	},
})

-- ores

minetest.register_ore({
	ore_type        = "blob",
	ore             = "core:gravel",
	wherein         = {"core:sand"},
	clust_scarcity  = 7 * 7 * 7,
	clust_size      = 5,
	y_min           = -31000,
	y_max           = -2,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 632,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "core:clay",
	wherein         = {"core:sand"},
	clust_scarcity  = 7 * 7 * 7,
	clust_size      = 7,
	y_min           = -31000,
	y_max           = -2,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 420, -- blaze it :^)
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "core:dirt",
	wherein         = {"core:sand"},
	clust_scarcity  = 11 * 11 * 11,
	clust_size      = 5,
	y_min           = -31000,
	y_max           = -2,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 4788,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type        = "blob",
	ore             = "core:stone",
	wherein         = {"core:sand"},
	clust_scarcity  = 16 * 16 * 16,
	clust_size      = 5,
	y_min           = -31000,
	y_max           = -2,
	noise_threshold = 0.0,
	noise_params    = {
		offset = 0.5,
		scale = 0.2,
		spread = {x = 5, y = 5, z = 5},
		seed = 23462,
		octaves = 1,
		persist = 0.0
	},
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:water_source",
	ore_param2 = 128,
	wherein = "mapgen:stone",
	clust_scarcity = 20 * 20 * 20,
	clust_num_ores = 10,
	clust_size = 4,
	y_min = -32000,
	y_max = 32000,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:dirt",
	wherein = "core:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 64,
	clust_size = 5,
	y_max = 32000,
	y_min = -32000,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:gravel",
	wherein = "core:stone",
	clust_scarcity = 16 * 16 * 16,
	clust_num_ores = 64,
	clust_size = 5,
	y_max = 32000,
	y_min = -31000,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:sand",
	wherein = "core:stone",
	clust_scarcity = 24 * 24 * 24,
	clust_num_ores = 32,
	clust_size = 4,
	y_max = 32000,
	y_min = -32000,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:clay",
	wherein = "core:stone",
	clust_scarcity = 32 * 32 * 32,
	clust_num_ores = 32,
	clust_size = 4,
	y_max = 32000,
	y_min = -32000,
})

-- ore nodes

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:coal_ore",
	wherein = "core:stone",
	clust_scarcity = 4*4*4,
	clusm_num_ores = 8,
	clust_size = 3,
	y_min = -4096,
	y_max = 220,
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:coal_ore",
	wherein = "core:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 12,
	clust_size = 6,
	y_min = -4096,
	y_max = 220,
	flags = "absheight",
})

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:coal_ore",
	wherein = "core:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 12,
	clust_size = 6,
	y_min = -31000,
	y_max = -4096,
	flags = "absheight",
})

-- iron

minetest.register_ore({
	ore_type = "scatter",
	ore = "core:iron_ore",
	wherein = "core:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 5,
	clust_size = 3,
	y_min = -4096,
	y_max = -64,
	flags = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:iron_ore",
	wherein        = "core:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -4096,
	y_max     = -128,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:iron_ore",
	wherein        = "core:stone",
	clust_scarcity = 7*7*7,
	clust_num_ores = 9,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -4096,
	flags          = "absheight",
})

-- copper, LAPD, FREEZE!

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:copper_ore",
	wherein        = "core:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -4096,
	y_max     = -16,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:copper_ore",
	wherein        = "core:stone",
	clust_scarcity = 12*12*12,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -4096,
	flags          = "absheight",
})

-- feed me with a silver spoon ;)

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:silver_ore",
	wherein        = "core:stone",
	clust_scarcity = 10*10*10,
	clust_num_ores = 15,
	clust_size     = 6,
	y_min     = -4096,
	y_max     = -256,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:silver_ore",
	wherein        = "core:stone",
	clust_scarcity = 9*9*9,
	clust_num_ores = 19,
	clust_size     = 9,
	y_min     = -31000,
	y_max     = -4096,
	flags          = "absheight",
})

--diamonds, rare, but eyes don't twinkle like diamonds.

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:diamond_ore",
	wherein        = "core:stone",
	clust_scarcity = 17*17*17,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -1024,
	y_max     = -256,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:diamond_ore",
	wherein        = "core:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 4,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -256,
	flags          = "absheight",
})

-- gold, the football players choice of scoring: GOALLLDDDD!

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:gold_ore",
	wherein        = "core:stone",
	clust_scarcity = 15*15*15,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -255,
	y_max     = -64,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:gold_ore",
	wherein        = "core:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -4096,
	y_max     = -512,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:gold_ore",
	wherein        = "core:stone",
	clust_scarcity = 13*13*13,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -31000,
	y_max     = -4096,
	flags          = "absheight",
})

-- MESE, must be easy MESEY getting this stuff

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:mese_ore",
	wherein        = "core:stone",
	clust_scarcity = 18*18*18,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -255,
	y_max     = -64,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:mese_ore",
	wherein        = "core:stone",
	clust_scarcity = 14*14*14,
	clust_num_ores = 5,
	clust_size     = 3,
	y_min     = -16392,
	y_max     = -256,
	flags          = "absheight",
})

minetest.register_ore({
	ore_type       = "scatter",
	ore            = "core:mese",
	wherein        = "core:stone",
	clust_scarcity = 36*36*36,
	clust_num_ores = 3,
	clust_size     = 2,
	y_min     = -31000,
	y_max     = -4096,
	flags          = "absheight",
})

-- port of bfoil for BFD

local YMAXU = -128
local YMINU = -16391
local YMAXL = -16392
local YMINL = -33000
local RAD = 24 -- Average radius of oil sphere
local NAMP = 0.33 -- Oily noise amplitude, controls reserve shape irregularity
local TSTONE = -0.2 -- Oily stone threshold, controls width of stone shell
local CHA = 1 / 5 ^ 3 -- Chance of reserve per chunk in upper layer

-- noise

local np_fire = {
	offset = 0,
	scale = 1,
	spread = {x=16, y=16, z=16},
	seed = 5900033,
	octaves = 2,
	persist = 0.5
}

minetest.register_on_generated(function(minp, maxp, seed)
	local y0 = minp.y
	local y1 = maxp.y
	if minp.y < YMINL or maxp.y > YMAXU
	or (minp.y < YMINU and maxp.y > YMAXL) then
		return
	end
	
	if (minp.y >= YMINU and math.random() > CHA * 3)
	or (maxp.y <= YMAXL and math.random() > CHA * 5) then -- 5x more common in lower layer
		return
	end
	
	local t1 = os.clock()
	local x0 = minp.x
	local x1 = maxp.x
	local z0 = minp.z
	local z1 = maxp.z
	print ("[Core] Firestone / Zero Ice Biome at ("..minp.x.." "..minp.y.." "..minp.z..")")
	local ccenx = math.floor((x0 + x1) / 2)
	local cceny = math.floor((y0 + y1) / 2)
	local ccenz = math.floor((z0 + z1) / 2)
		
	local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
	local area = VoxelArea:new{MinEdge=emin, MaxEdge=emax}
	local data = vm:get_data()
	
	local c_firestone = minetest.get_content_id("core:firestone")
	local c_zero = minetest.get_content_id("core:icestone")
	local c_stone = minetest.get_content_id("core:stone")
	local c_air = minetest.get_content_id("air")
	
	local sidelen = x1 - x0 + 1
	local chulens = {x=sidelen, y=sidelen, z=sidelen}
	local minposxyz = {x=x0, y=y0, z=z0}
	
	local nvals_oil = minetest.get_perlin_map(np_fire, chulens):get3dMap_flat(minposxyz)
	
	-- consistency
	
	math.randomseed(seed)
	
	local biometype = math.random(1,2)
	print (biometype)
	
	local nixyz = 1
	for z = z0, z1 do
	for y = y0, y1 do
		local vi = area:index(x0, y, z)
		for x = x0, x1 do
			local n_oil = nvals_oil[nixyz]
			local nodrad = ((x - ccenx) ^ 2 + (y - cceny) ^ 2 + (z - ccenz) ^ 2) ^ 0.5
			local oily = (RAD - nodrad) / RAD + n_oil * NAMP -- oily = 1 at centre, = 0 at edge
			
			if oily >= 0 then
				
				if data[vi] ~= c_air then
				
					if biometype == 1 then
						data[vi] = c_firestone
					elseif biometype == 2 then
						data[vi] = c_zero
					end
				end
				
			elseif oily >= TSTONE then

				if data[vi] ~= c_air then
					if biometype == 1 then
						data[vi] = c_firestone
					elseif biometype == 2 then
						data[vi] = c_zero
					end
				end
			end
			
			
			nixyz = nixyz + 1
			vi = vi + 1
		end
	end
	end
	
	vm:set_data(data)
	--vm:set_lighting({day=0, night=0})
	vm:calc_lighting()
	vm:write_to_map(data)
	local chugent = math.ceil((os.clock() - t1) * 1000)
	print ("[Core] Firestone / Zero Ice Biome generated in "..chugent.." ms")
end)