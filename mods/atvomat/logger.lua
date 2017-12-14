-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

atvomat.logger_targets = {}

-- writing your own logs, leaves and others for the logger to automatically chop down:

--[[ 

	atvomat.logger_targets["node:trunk"] = {
		
		"default", -- define the type of tree shape (others such as acacia and pine are not yet supported)
		"node:leaves",
		"node:trunk_base", -- base of the trunk to chop
		6, -- chance to drop the string below
		"node:leaves_drop" -- use this for saplings and the like		
		"node:fallen_leaves" -- if the tree has any falled leaves like the cherry tree
		"node:alt_leaves"
	}

]]--

atvomat.logger_targets["core:oak_log"] = {

	"default",
	"core:oak_leaves",
	"core:oak_log_grassy",
	16,
	"core:oak_sapling",
	"",
	""
}

atvomat.logger_targets["core:birch_log"] = {

	"default",
	"core:birch_leaves",
	"core:birch_log_grassy",
	16,
	"core:birch_sapling",
	"",
	""
}

atvomat.logger_targets["core:cherry_log"] = {

	"default",
	"core:cherry_leaves",
	"core:cherry_log_grassy",
	16,
	"core:cherry_sapling",
	"core:fallen_cherry_leaves",
	""
}

atvomat.logger_targets["core:pine_log"] = {

	"pine",
	"core:pine_needles",
	"core:pine_log",
	16,
	"core:pine_sapling",
	"",
	"core:pine_needles_snowy"

}

local atlogger = 
	"size[8,9]"..
	"list[current_name;fuel;1.5,1.5;1,1;]" ..
	"list[current_name;main;4,0;4,4]" .. 
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_logger_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"

local function remove_stump(fpos, v, y2, x2, z2, inv)

	if y2 == 0 then -- remove the stump
							
		if x2 == 3 then
		
			if z2 == 3 then
				
				local fname = minetest.get_node_or_nil(fpos).name 
				
				if fname == v[3] then
				
					inv:add_item("main", v[3])
				
					minetest.remove_node(fpos)
				
					return true
					
				end
				
			end
		
		end
	
	end

end
	
local function log_tree_and_leaves(cpos, k, v, node, inv)

	if node.name == k then
							
		minetest.remove_node(cpos)
		
		inv:add_item("main", k)
		
		return true
	
	elseif node.name == v[2] then
	
		minetest.remove_node(cpos)
		
		if math.random(1, v[4]) == 1 then
			
			inv:add_item("main", v[5])
			
			return true
			
		else
		
			inv:add_item("main", v[2])
			
			return true
			
		end
	
	elseif node.name == v[7] then
	
		minetest.remove_node(cpos)
		
		if math.random(1, v[4]) == 1 then
			
			inv:add_item("main", v[5])
			
			return true
			
		else
		
			inv:add_item("main", v[7])
			
			return true
			
		end
	
	elseif node.name == v[6] then
		
		if node.name == "" then return true end
		
		minetest.remove_node(cpos)
		
		inv:add_item("main", v[6])
		
		return true
		
	end

end
	
local function active_logger(pos, elapsed)
	
	local inv = minetest.get_meta(pos):get_inventory()
	
	local fuel_stack = inv:get_stack("fuel", 1)
	
	local fuel_name = fuel_stack:get_name()
		
	local fpos = mcore.get_node_from_front(table.copy(pos)) -- lets get the position for the node where the targeter is
	
	if minetest.get_node_or_nil(fpos).name == "air" then return true end
	if minetest.get_node_or_nil(fpos).name == nil then return true end

	if fuel_stack:get_count() == 0 then print(fuel_stack:get_count()) return true end
	if fuel_name ~= "core:coal_lump" then return true end
	
	local cpos = {}
	
	local fuel_required = false
	
	for y2=17, 0, -1 do	
		
		cpos["y"] = fpos.y + y2
		
		for x2 = -3, 3 do
			
			cpos["x"] = fpos.x + x2
			
			for z2 = -3, 3 do
			
				cpos["z"] = fpos.z + z2
				
				for k, v in pairs(atvomat.logger_targets) do
					
					local node = minetest.get_node_or_nil(cpos)
					
					if v[1] == "default" then
					
						if minetest.get_node_or_nil(fpos).name == v[3] then
							
							if log_tree_and_leaves(cpos, k, v, node, inv) then return true end
							
							fuel_required = remove_stump(fpos, v, y2, x2, z2, inv)
							
						end
					
					elseif v[1] == "pine" then
						
						if minetest.get_node_or_nil(fpos).name == v[3] then
						
							if log_tree_and_leaves(cpos, k, v, node, inv) then return true end
							
							fuel_required = remove_stump(fpos, v, y2, x2, z2, inv)
							
						end
						
						
					
					end
					
				end
									
			end
			
		end
	
	end	
	
	if fuel_required then
	
		fuel_stack:take_item(1)
		
		inv:set_stack("fuel", 1, fuel_stack)
	
	end
	
	return true
	
end
	
minetest.register_node("atvomat:logger", {

	description = "Logger",
	tiles = {"atvomat_chopper_body.png"},
	drawtype = "mesh",
	mesh = "atvomat_chopper.b3d",
	
	paramtype2 = "facedir",
	
	sounds = mcore.sound_metallic,
	
	on_place = mcore.rotate_axis,
	
	groups = {oddly_breakable_by_hand=2},
	
	on_construct = function(pos)
	
		local meta = minetest.get_meta(pos)
		
		meta:set_string("infotext", "Insert Coal or Charcoal to get started.")
		
		meta:set_string("formspec", atlogger)
		local inv = meta:get_inventory()
		inv:set_size("main", 16)
		inv:set_size("fuel", 1)
				
		minetest.get_node_timer(pos):start(0.5)
		
	end,
	
	on_timer = active_logger,
	
	on_punch = function(pos)
	
		minetest.get_node_timer(pos):start(0.5)
	
	end,
	
})

minetest.register_recipe({

	output = "atvomat:logger",
	recipe = {
	
		{"core:iron_ingot", "core:diamond_axe", "core:iron_ingot"},
		{"core:furnace", "core:diamond_axe", "core:chest"},
		{"core:iron_ingot", "core:mese", "core:iron_ingot"},
	
	},

})