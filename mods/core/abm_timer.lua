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

minetest.register_abm({
	nodenames = {"core:dirt"},
	neighbors = {"core:grass_wildland"},
	interval = 180,
	chance = 3,
	action = function(pos)
		pos.y = pos.y + 1
		if not minetest.get_node_light(pos) then
			return
		end
		if minetest.get_node_light(pos) > 9 then
			pos.y = pos.y - 1
			minetest.add_node(pos,{name="core:grass_wildland"})
		end
	end,
})

-- grass decay

minetest.register_abm({
	nodenames = {"core:grass", "core:grass_wildland"},
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
			minetest.add_node(pos,{name="core:grass"})
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
	nodenames = {"core:acacia_sapling"},
	interval = 80, --70
	chance = 3,
	action = function(pos, node)
		
		local nu =  minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name
		local is_soil = minetest.get_item_group(nu, "soil")
		
		if is_soil == 0 then
			return
		end
			
		minetest.remove_node({x=pos.x, y=pos.y, z=pos.z})
		mcore.create_acacia_tree(pos)
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

-- lava cooling and obsidian;

function mcore.freeze_lava(pos, node)

	if node.name == "core:lava_source" then
	
		minetest.set_node(pos, {name="core:obsidian"})
		
		return true
		
	else -- we know it's not the source block.
		
		if math.random(1, 64) == 18 then
		
			minetest.set_node(pos, {name="core:diamond_ore"})
		
		elseif math.random(1, 48) == 16 then
		
			minetest.set_node(pos, {name="core:gold_ore"})
		
		elseif math.random(1, 32) == 12 then
		
			minetest.set_node(pos, {name="core:silver_ore"})
		
		elseif math.random(1, 24) == 8 then
		
			minetest.set_node(pos, {name="core:iron_ore"})
		
		elseif math.random(1, 16) == 6 then
		
			minetest.set_node(pos, {name="core:copper_ore"})
		
		elseif math.random(1, 12) == 5 then
		
			minetest.set_node(pos, {name="core:coal_ore"})
			
		else
		
			minetest.set_node(pos, {name="core:basalt"})
			
		end
		
		return true
		
	end

end

minetest.register_abm({

	nodenames = {"core:lava_source", "core:lava_flowing"},
	neighbors = {"core:water_source", "core:ice", "core:water_flowing"},
	
	interval = 2,
	chance = 1,
	catch_up = false,
	
	action = function(pos, node)
	
		mcore.freeze_lava(pos, node)
	
	end,
	
})

-- make lava cool down once exposed to ambient air

minetest.register_abm({

	nodenames = {"core:lava_source"},
	neighnors = {"air"},
	
	interval = 181,
	chance = 6,
	catch_up = false,
	
	action = function(pos, node)
	
		minetest.set_node(pos, {name="core:obsidian"})
	
	end,

})

minetest.register_abm({

	nodenames = {"core:lava_flowing"},
	neighnors = {"air"},
	
	interval = 64,
	chance = 2,
	catch_up = false,
	
	action = function(pos, node)
	
		minetest.set_node(pos, {name="core:basalt"})
	
	end,

})

-- util func for resetting the math.random seed.

local function randseed()

	math.randomseed( os.time())
	
	minetest.after(math.random(15,45), randseed)
end

minetest.after(math.random(15,45), randseed)

-- leafdecay ported from MTG

default.after_place_leaves = function(pos, placer, itemstack, pointed_thing)
	if placer and placer:is_player() then
		local node = minetest.get_node(pos)
		node.param2 = 1
		minetest.set_node(pos, node)
	end
end

-- Leafdecay

local function leafdecay_after_destruct(pos, oldnode, def)
	for _, v in pairs(minetest.find_nodes_in_area(vector.subtract(pos, def.radius),
			vector.add(pos, def.radius), def.leaves)) do
		local node = minetest.get_node(v)
		local timer = minetest.get_node_timer(v)
		if node.param2 == 0 and not timer:is_started() then
			timer:start(math.random(6, 18))
		end
	end
end

local function leafdecay_on_timer(pos, def)
	if minetest.find_node_near(pos, def.radius, def.trunks) then
		return false
	end

	local node = minetest.get_node(pos)
	local drops = minetest.get_node_drops(node.name)
	
	for _, item in ipairs(drops) do
		local is_leaf
		for _, v in pairs(def.leaves) do
			if v == item then
				is_leaf = true
			end
		end
		if minetest.get_item_group(item, "leafdecay_drop") ~= 0 or
				not is_leaf then
			minetest.add_item({
				x = pos.x - 0.5 + math.random(),
				y = pos.y - 0.5 + math.random(),
				z = pos.z - 0.5 + math.random(),
			}, item)
		end
	end

	minetest.remove_node(pos)
	minetest.check_for_falling(pos)
end

function default.register_leafdecay(def)
	assert(def.leaves)
	assert(def.trunks)
	assert(def.radius)
	for _, v in pairs(def.trunks) do
		minetest.override_item(v, {
			after_destruct = function(pos, oldnode)
				leafdecay_after_destruct(pos, oldnode, def)
			end,
		})
	end
	for _, v in pairs(def.leaves) do
		minetest.override_item(v, {
			on_timer = function(pos)
				leafdecay_on_timer(pos, def)
			end,
		})
	end
end