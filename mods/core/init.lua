--configuration options

mcore = {}

give_initial_stuff = {}

default = {}

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
	
	local hor_rot = math.deg(placer:get_look_horizontal()) -- convert radians to degrees
	local deg_to_fdir = math.floor(((hor_rot * 4 / 360) + 0.5) % 4) -- returns 0, 1, 2 or 3; checks between 90 degrees in a pacman style angle check, it's quite magical.
	
	local fdir = 0 -- get initialised, and if we don't ever assign an fdir, then it's safe to ignore?! (probably not a good idea to do so)
	
	local px = math.abs(placer:get_pos().x - rpos.x) -- measure the distance from the player to the placed nodes position

	local pz = math.abs(placer:get_pos().z - rpos.z)
	
	if px < 2 and pz < 2 then -- if the node is being placed 1 block away from us, then lets place it either upright or upside down
		
		local pY = 0
		
		if placer:get_pos().y < 0 then
		
			pY = math.abs(placer:get_pos().y - 1.14) -- we invert this Y value since we need to go UPWARDS to compare properly.
		
		else
		
			pY = math.abs(placer:get_pos().y + 2.14) -- we measure the y distance by itself as it may not be needed for wall placed blocks.
		
		end
		
		print (pY - math.abs(rpos.y))
		
		if pY - math.abs(rpos.y) > 1.5 then -- are we being placed on the floor? let's be upright then.
				
			if deg_to_fdir == 0 then fdir = 0 -- north
			elseif deg_to_fdir == 1 then fdir = 3 --east
			elseif deg_to_fdir == 2 then fdir = 2 -- south
			elseif deg_to_fdir == 3 then fdir = 1 end -- west
	
			return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)
			
		else -- if not, let's be upside down.

			if deg_to_fdir == 0 then fdir = 20 -- north
			elseif deg_to_fdir == 1 then fdir = 21 -- east
			elseif deg_to_fdir == 2 then fdir = 22 -- south
			elseif deg_to_fdir == 3 then fdir = 23 end -- west
			
			return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)
	
		end 	
		
	end
	
	-- since we couldn't find a place that isn't either on a ceiling or floor, let's place it onto it's side.
	
	if deg_to_fdir == 0 then fdir = 9 -- north
	elseif deg_to_fdir == 1 then fdir = 12 -- east
	elseif deg_to_fdir == 2 then fdir = 7 -- south
	elseif deg_to_fdir == 3 then fdir = 18 end -- west
	
	return minetest.item_place_node(itemstack, placer, pointed_thing, fdir)

end

function mcore.sensible_facedir_simple(itemstack, placer, pointed_thing)
	
	local rpos = ""
	
	local hor_rot = math.deg(placer:get_look_horizontal())
	local deg_to_fdir = math.floor(((hor_rot * 4 / 360) + 0.5) % 4) 
	local fdir = 0
	
	if deg_to_fdir == 0 then fdir = 0
	elseif deg_to_fdir == 1 then fdir = 3
	elseif deg_to_fdir == 2 then fdir = 2
	elseif deg_to_fdir == 3 then fdir = 1 end
	
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

-- borrowed mineclone2's axis facedir:

function mcore.rotate_axis_and_place(itemstack, placer, pointed_thing, infinitestacks, invert_wall)
    local unode = minetest.get_node_or_nil(pointed_thing.under)
    if not unode then
        return
    end
    local undef = minetest.registered_nodes[unode.name]
    if undef and undef.on_rightclick then
        undef.on_rightclick(pointed_thing.under, unode, placer,
                itemstack, pointed_thing)
        return
    end
    local fdir = minetest.dir_to_facedir(placer:get_look_dir())
    local wield_name = itemstack:get_name()

    local above = pointed_thing.above
    local under = pointed_thing.under
    local is_x = (under.x + 1 == above.x)
	local is_x2 = (under.x == above.x)
	
    local is_y = (under.y + 1 == above.y)
	
    local is_z = (under.z + 1 == above.z)
    local is_z2 = (under.z == above.z)
	
    local anode = minetest.get_node_or_nil(above)
    if not anode then
        return
    end
    local pos = pointed_thing.above
    local node = anode

    if undef and undef.buildable_to then
        pos = pointed_thing.under
        node = unode
    end

    if minetest.is_protected(pos, placer:get_player_name()) then
        minetest.record_protection_violation(pos, placer:get_player_name())
        return
    end

    local ndef = minetest.registered_nodes[node.name]
    if not ndef or not ndef.buildable_to then
        return
    end

    local p2
    
	if is_x and not is_x2 then
	
		p2 = 18
		
	elseif not is_x and not is_x2 then
	
		p2 = 12
		
	elseif is_z and not is_z2 then
       
		p2 = 9
		
	elseif not is_z and not is_z2 then
	
		p2 = 7
	
	elseif is_y then
        
		p2 = 20
       
	elseif not is_y then
	
		p2 = 0
	
    end
	
    minetest.set_node(pos, {name = wield_name, param2 = p2})

    if not infinitestacks then
        itemstack:take_item()
        return itemstack
    end
end

function mcore.rotate_axis(itemstack, placer, pointed_thing)
    mcore.rotate_axis_and_place(itemstack, placer, pointed_thing,
        false,
        placer:get_player_control().sneak)
    return itemstack
end

-- dofiles for loading files required by "core"
dofile(minetest.get_modpath("core").."/abm_timer.lua")
dofile(minetest.get_modpath("core").."/sounds.lua")
dofile(minetest.get_modpath("core").."/mapgen.lua")
dofile(minetest.get_modpath("core").."/blocks.lua")
dofile(minetest.get_modpath("core").."/player.lua")
dofile(minetest.get_modpath("core").."/tools.lua")
dofile(minetest.get_modpath("core").."/crafting.lua")