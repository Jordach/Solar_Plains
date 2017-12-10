--configuration options

mcore = {}

give_initial_stuff = {}

-- dofiles for loading files required by "core"
dofile(minetest.get_modpath("core").."/sounds.lua")
dofile(minetest.get_modpath("core").."/mapgen.lua")
dofile(minetest.get_modpath("core").."/blocks.lua")
dofile(minetest.get_modpath("core").."/player.lua")
dofile(minetest.get_modpath("core").."/tools.lua")
dofile(minetest.get_modpath("core").."/crafting.lua")
dofile(minetest.get_modpath("core").."/abm_timer.lua")


--dofile(minetest.get_modpath("core").."/")
--dofile(minetest.get_modpath("core").."/")
--dofile(minetest.get_modpath("core").."/")

-- base mapgen requirements

minetest.register_alias("mapgen_stone", "core:stone")
minetest.register_alias("mapgen_dirt", "core:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "core:grass")
minetest.register_alias("mapgen_sand", "core:sand")
minetest.register_alias("mapgen_water_source", "core:water_source")
minetest.register_alias("mapgen_river_water_source", "core:water_source")
minetest.register_alias("mapgen_lava_source", "core:lava_source")
minetest.register_alias("mapgen_gravel", "core:gravel")
minetest.register_alias("mapgen_desert_stone", "core:sandstone")
minetest.register_alias("mapgen_desert_sand", "core:sand")
minetest.register_alias("mapgen_dirt_with_snow", "core:grass_snow")
minetest.register_alias("mapgen_snowblock", "core:snowblock")
minetest.register_alias("mapgen_snow", "core:snow")
minetest.register_alias("mapgen_ice", "core:ice")
minetest.register_alias("mapgen_sandstone", "core:sandstone")

-- Flora

minetest.register_alias("mapgen_tree", "core:oak_tree")
minetest.register_alias("mapgen_leaves", "core:oak_leaves")
minetest.register_alias("mapgen_apple", "core:apple")
minetest.register_alias("mapgen_jungletree", "core:jungletree")
minetest.register_alias("mapgen_jungleleaves", "core:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "core:junglegrass")
minetest.register_alias("mapgen_pine_tree", "core:pine_tree")
minetest.register_alias("mapgen_pine_needles", "core:pine_needles")

-- Dungeons

minetest.register_alias("mapgen_cobble", "core:cobble")
minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
minetest.register_alias("mapgen_mossycobble", "core:mossycobble")
minetest.register_alias("mapgen_sandstonebrick", "core:sandstonebrick")
minetest.register_alias("mapgen_stair_sandstonebrick", "stairs:stair_sandstonebrick")

-- add unbreakable starter tools (they break in 32k uses)

local stuff_string = "core:wooden_pickaxe,core:wooden_sword,core:wooden_axe,core:wooden_shovel"

give_initial_stuff = {
	items = {}
}

function give_initial_stuff.give(player)
	minetest.log("action",
			"Giving starter wooden tools to new player " .. player:get_player_name())
	local inv = player:get_inventory()
	for _, stack in ipairs(give_initial_stuff.items) do
		inv:add_item("main", stack)
	end
end

function give_initial_stuff.add(stack)
	give_initial_stuff.items[#give_initial_stuff.items + 1] = ItemStack(stack)
end

function give_initial_stuff.clear()
	give_initial_stuff.items = {}
end

function give_initial_stuff.add_from_csv(str)
	local items = str:split(",")
	for _, itemname in ipairs(items) do
		give_initial_stuff.add(itemname)
	end
end

function give_initial_stuff.set_list(list)
	give_initial_stuff.items = list
end

function give_initial_stuff.get_list()
	return give_initial_stuff.items
end

give_initial_stuff.add_from_csv(stuff_string)

minetest.register_on_newplayer(give_initial_stuff.give)

-- utility;

-- special entity tester

local mob = {

	visual = "mesh",
	mesh = "entity.x",
	textures = {
		
	},
	visual_size = {x=1, y=1},
	anim_type = 1,
}

local mob_anim = {}

mob_anim[1] = {x=263, y=282}
mob_anim[2] = {x=121, y=151}
mob_anim[3] = {x=166, y=191}
mob_anim[4] = {x=201, y=231}

function mob:on_rightclick(clicker)

	if not clicker or not clicker:is_player() then
		return
	end
		
	if self.anim_type == #mob_anim then
	
		self.anim_type = 1
	
	else
	
		self.anim_type = self.anim_type + 1
		
	end
	
	self.object:set_animation(mob_anim[self.anim_type], 30, 0, false)
end

minetest.register_entity("core:tester", mob)

minetest.register_node("core:model_tester", {

	description = "Hax",
	tiles = {"core_stone.png"},
	groups = {dig_immediate = 1},
	drawtype = "mesh",
	
	mesh = "chest_unlocked.b3d",
	
	paramtype = "light",
	paramtype2 = "facedir",
	
	on_place = mcore.sensible_facedir,

})

-- better facedir than minetest.rotate_and_place

--use mcore.sensible_facedir_simple for furnaces or mcore.sensible_facedir for those multiple rotation nodes.

function mcore.sensible_facedir(itemstack, placer, pointed_thing)
	
	local rpos = ""
	
	if minetest.registered_nodes[minetest.get_node(pointed_thing.under).name].buildable_to == true then
	
		rpos = pointed_thing.under
		
	else
		
		rpos = pointed_thing.above
		
	end
	
	local hor_rot = math.deg(placer:get_look_horizontal())
	local deg_to_fdir = math.floor(((hor_rot * 4 / 360) + 0.5) % 4) 
	local fdir = 0
	
	local px = math.ceil(math.abs(placer:get_pos().x - rpos.x))

	local pz = math.ceil(math.abs(placer:get_pos().z - rpos.z))
	
	if px < 2 and pz < 2 then
		
		local pY = math.ceil(math.abs(placer:get_pos().y + 0.5))
		
		if pY - (math.ceil(rpos.y)) > -1 then
				
			if deg_to_fdir == 0 then fdir = 0
			elseif deg_to_fdir == 1 then fdir = 3
			elseif deg_to_fdir == 2 then fdir = 2
			elseif deg_to_fdir == 3 then fdir = 1 end
	
			return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)
			
		else

			if deg_to_fdir == 0 then fdir = 20
			elseif deg_to_fdir == 1 then fdir = 21
			elseif deg_to_fdir == 2 then fdir = 22
			elseif deg_to_fdir == 3 then fdir = 23 end
			
			return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)
	
		end 	
		
	end
	if deg_to_fdir == 0 then fdir = 9
	elseif deg_to_fdir == 1 then fdir = 12
	elseif deg_to_fdir == 2 then fdir = 7
	elseif deg_to_fdir == 3 then fdir = 18 end
	
	return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)

end

function mcore.sensible_facedir_simple(itemstack, placer, pointed_thing)
	
	local rpos = ""
	
	local hor_rot = math.deg(placer:get_look_horizontal())
	local deg_to_fdir = math.floor(((hor_rot * 4 / 360) + 0.5) % 4) 
	local fdir = 0
	
	if deg_to_fdir == 0 then fdir = 9
	elseif deg_to_fdir == 1 then fdir = 12
	elseif deg_to_fdir == 2 then fdir = 7
	elseif deg_to_fdir == 3 then fdir = 18 end
	
	return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)

end

-- get 3d facedir to simple axis; 
-- 0 = y+    1 = z+    2 = z-    3 = x+    4 = x-    5 = y-

function mcore.facedir_stripper(node)

	local number = node.param2/4
	
	local chara = tostring(number)
		
	number = tonumber(chara:sub(1,1))
	
	return number
	
end

function mcore.get_node_from_front(pos) 
	--pos is the standard pos table provided by minetest, eg: pos = {x=int, y=int, z=int}
	
	local node = minetest.get_node_or_nil(pos)
	
	local facedir = mcore.facedir_stripper(node)
	
	local npos = pos
	
	if facedir == 0 then
	
		npos.y = npos.y + 1
		
		return npos
	
	elseif facedir == 1 then
	
		npos.z = npos.z + 1
		
		return npos
		
	elseif facedir == 2 then
	
		npos.z = npos.z - 1

		return npos
		
	elseif facedir == 3 then
	
		npos.x = npos.x + 1
	
		return npos
		
	elseif facedir == 4 then
	
		npos.x = npos.x - 1
		
		return npos
		
	elseif facedir == 5 then
	
		npos.y = npos.y - 1

		return npos
		
	end

end

function mcore.get_node_from_rear(pos) 
	--pos is the standard pos table provided by minetest, eg: pos = {x=int, y=int, z=int}
	
	local node = minetest.get_node_or_nil(pos)
	
	local facedir = mcore.facedir_stripper(node)
	
	local npos = pos
	
	if facedir == 0 then
	
		npos.y = npos.y - 1
		
		return npos
	
	elseif facedir == 1 then
	
		npos.z = npos.z - 1
		
		return npos
		
	elseif facedir == 2 then
	
		npos.z = npos.z + 1
	
		return npos
		
	elseif facedir == 3 then
	
		npos.x = npos.x - 1
		
		return npos
		
	elseif facedir == 4 then
	
		npos.x = npos.x + 1
		
		return npos
		
	elseif facedir == 5 then
	
		npos.y = npos.y + 1
		
		return npos
		
	end

end