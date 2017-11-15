-- solar fields core/abm_timer.lua

-- used for: saplings, grass spread, decay, etc


-- grass spread

minetest.register_abm({
	nodenames = {"core:dirt"},
	neighbors = {"core:grass"},
	interval = 180,
	chance = 3,
	action = function(pos)
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 9 then
			pos.y = pos.y - 1
			minetest.add_node(pos,{name="core:grass"})
		end
	end,
})

-- grass decay

minetest.register_abm({
	nodenames = {"core:grass"},
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


minetest.register_abm({
	nodenames = {"core:grass_snow"},
	interval = 120,
	chance = 2,
	action = function(pos)
		pos.y = pos.y + 1
		if not minetest.get_node_or_nil(pos) then
			return
		end
		
		if minetest.get_node_or_nil(pos).name ~= "core:snow" then
			pos.y = pos.y - 1
			minetest.add_node(pos,{name="core:dirt"})
		end
	end,
})

-- saplings

minetest.register_abm({
	nodenames = {"core:oak_sapling"},
	interval = 100, --100
	chance = 3,
	action = function(pos, node)
		
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		
		if is_soil == 0 then
			return
		end
		
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		mcore.grow_tree(pos, false, "core:oak_log", "core:oak_leaves", nil, nil)
	end,
})

minetest.register_abm({
	nodenames = {"core:birch_sapling"},
	interval = 90, --90
	chance = 3,
	action = function(pos, node)
		
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		
		if is_soil == 0 then
			return
		end
		
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		mcore.grow_tree(pos, false, "core:birch_log", "core:birch_leaves", nil, nil)
	end,
})

minetest.register_abm({
	nodenames = {"core:cherry_sapling"},
	interval = 85, --85
	chance = 3,
	action = function(pos, node)
		
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		
		if is_soil == 0 then
			return
		end
		
		
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		mcore.grow_tree(pos, false, "core:cherry_log", "core:cherry_leaves", "core:fallen_cherry_leaves", 1.25)
	end,
})

minetest.register_abm({
	nodenames = {"core:pine_sapling"},
	interval = 70, --70
	chance = 3,
	action = function(pos, node)
		
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		
		if is_soil == 0 then
			return
		end
			
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		mcore.grow_pine(pos, false)
	end,
})

