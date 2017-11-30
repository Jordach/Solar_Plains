
logger = {}
logger.saplings = {["default:sapling"]=1, ["default:junglesapling"]=1}
logger.trees = {["default:tree"]=1, ["default:jungletree"]=1}
logger.fruit = {["default:apple"]=1}

minetest.register_craft({
	recipe = {{"default:wood", "default:wood",   "default:wood"},
	          {"default:wood", "default:cobble", "default:axe_stone"},
	          {"default:wood", "default:wood",   "default:wood"}},
	output = "logger:logger_off"
})


local function allow_put(pos, listname, index, stack, player)
	local cap = stack:get_tool_capabilities()
	local is_good_tool = false
	if cap and cap.groupcaps and cap.groupcaps.choppy and
	   cap.groupcaps.choppy.uses and cap.groupcaps.choppy.uses > 0 then
	   is_good_tool = true
	end
	if listname == "saplings" and logger.saplings[stack:get_name()] or
	   listname == "tool" and is_good_tool then
		return stack:get_stack_max()
	end
	return 0 -- Disallow the move
end

local function swap_node(pos, name)
	local node = minetest.get_node(pos)
	local meta = minetest.get_meta(pos)
	local metatable = meta:to_table()
	node.name = name
	minetest.set_node(pos, node)
	meta:from_table(metatable)
end

local function setup(meta)
	local inv = meta:get_inventory()
	meta:set_string("formspec", 
		"size[8,5]"..
		"label[0,0;Logger]"..
		"label[1.6,0;Saplings]"..
		"list[current_name;saplings;3,0;1,1;]"..
		"label[4,0;Tool]"..
		"list[current_name;tool;5,0;1,1;]"..
		"list[current_player;main;0,1;8,4;]")
	inv:set_size("saplings", 1)
	inv:set_size("tool", 1)
end

local function fdir_to_pos(pos, node, back)
	x = 1
	if back then x = -1 end
	local facedir_pos = {
		{x=pos.x,   y=pos.y, z=pos.z-x},
		{x=pos.x-x, y=pos.y, z=pos.z},
		{x=pos.x,   y=pos.y, z=pos.z+x},
		{x=pos.x+x, y=pos.y, z=pos.z}
	}
	return facedir_pos[node.param2+1]
end

local function store_item(pos, node, itemstring)
	local bpos = fdir_to_pos(pos, node, true)
	local bnode = minetest.get_node(bpos)
	local inv = minetest.get_meta(pos):get_inventory()
	local binv = minetest.get_meta(bpos):get_inventory()
	local stack = ItemStack(itemstring)

	-- Fill ourselves up with saplings first
	if (inv:get_stack("saplings", 1):get_name() == stack:get_name()) or
	   (inv:is_empty("saplings") and logger.saplings[stack:get_name()]) then
		stack = inv:add_item("saplings", stack)
	end
	if stack:get_count() <= 0 then
		return true
	end

	-- Dump the item in a chest or <del>add it as an item</del> <ins>fail</ins>
	if bnode.name ~= "default:chest" or not binv:room_for_item("main", stack) then
		-- This can kill a server...
		--minetest.add_item(pos, itemstring)
		--return true
		return false
	end
	binv:add_item("main", stack)
	return true
end

minetest.register_node("logger:logger_off", {
	description = "Logger",
	tiles = {"default_wood.png^logger_top_off.png", "default_wood.png",
	         "default_wood.png", "default_wood.png",
	         "default_wood.png", "default_wood.png^default_tool_stoneaxe.png"},
	groups = {choppy=1},
	paramtype2 = "facedir",
	on_punch = function(pos, node, puncher)
		local meta = minetest.get_meta(pos)
		swap_node(pos, "logger:logger_on")
		meta:set_string("infotext", "Logger (enabled)")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Logger (disabled)")
		setup(meta)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("saplings") or not inv:is_empty("tool") then
			minetest.chat_send_player(player:get_player_name(),
				"Logger cannot be removed because it is not empty");
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = allow_put,
	allow_metadata_inventory_move = function(pos, from_list, to_list, to_list, to_index, count, player)
		return 0
	end,
})

minetest.register_node("logger:logger_on", {
	description = "Logger enabled (you hacker you)",
	tiles = {"default_wood.png^logger_top_on.png", "default_wood.png",
	         "default_wood.png", "default_wood.png",
	         "default_wood.png", "default_wood.png^default_tool_stoneaxe.png"},
	groups = {choppy=1, not_in_creative_inventory=1},
	paramtype2 = "facedir",
	drop = "logger:logger_off",
	on_punch = function(pos, node, puncher)
		local meta = minetest.get_meta(pos)
		swap_node(pos, "logger:logger_off")
		meta:set_string("infotext", "Logger (disabled)")
	end,
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("infotext", "Logger (enabled)")
		setup(meta)
	end,
	can_dig = function(pos, player)
		local meta = minetest.get_meta(pos);
		local inv = meta:get_inventory()
		if not inv:is_empty("saplings") or not inv:is_empty("tool") then
			minetest.chat_send_player(player:get_player_name(),
				"Logger cannot be removed because it is not empty");
			return false
		end
		return true
	end,
	allow_metadata_inventory_put = allow_put,
	allow_metadata_inventory_move = function(pos, from_list, to_list, to_list, to_index, count, player)
		return 0
	end,
})

minetest.register_abm({
	nodenames = {"logger:logger_on"},
	interval = 5,
	chance = 1,
	action = function(pos, node)
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		local fpos = fdir_to_pos(pos, node, false)
		local fnode = minetest.get_node(fpos)

		-- Vacum up saplings and fruit
		-- The nesting here is a bit deep, but Lua doesn't have
		-- continue so I  don't know how to make it shalower. :-(
		for _, object in pairs(minetest.get_objects_inside_radius(fpos, 3)) do
			if object:get_entity_name() == "__builtin:item" then
				local entity = object:get_luaentity()
				local itemname = ItemStack(entity.itemstring):get_name()
				if logger.saplings[itemname] or logger.fruit[itemname] then
					if store_item(pos, node, entity.itemstring) then
						-- This prevents a duplication glitch
						-- because objects aren't removed immediately.
						-- (Nearby loggers will also add the item
						-- while it is still there)
						entity:set_item("")
						object:remove()
					end
				end
			end
		end

		-- Place a sapling
		if fnode.name == "air" and not inv:is_empty("saplings") then
			local stack = inv:get_stack("saplings", 1)
			if not logger.saplings[stack:get_name()] then
				return
			end
			inv:remove_item("saplings", ItemStack(stack:get_name()))
			minetest.set_node(fpos, {name=stack:get_name()})
		-- Fell a tree
		elseif logger.trees[fnode.name] and not inv:is_empty("tool") then
			np = vector.new(fpos)
			local stack = inv:get_stack("tool", 1)
			-- This assumes that the tool has a choppy group
			-- allow_put ensures that this is a axe from default
			-- so it should be a safe assumption.
			local uses = stack:get_tool_capabilities().groupcaps.choppy.uses
			-- Be more eficient because you can chop down trees by hand
			uses = uses * 4
			-- I looked at Jeija's timber mod to design this.
			while minetest.get_node(np).name == fnode.name do
				-- Slightly above 65535 so
				-- that the tool runs out in time.
				-- (For some reason you got one extra use)
				-- Note that this will work after the tool
				-- has broken if it is halfway up a tree.
				if not store_item(pos, node, fnode.name) then
					break
				end
				stack:add_wear(65540/uses)
				minetest.remove_node(np)
				np = {x=np.x, y=np.y+1, z=np.z}
			end
			inv:set_stack("tool", 1, stack)
		end
	end,
})

