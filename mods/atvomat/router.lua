-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

local atmover = 
	"size[8,9]" ..
	"list[current_name;main;3.5,2;1,1]" ..
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_mover_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"

local function round_robin(pos)
	local rpos = mcore.get_node_from_rear(table.copy(pos))
	local rear_node = minetest.get_node_or_nil(rpos)
	local meta = minetest.get_meta(pos)
	local mover_inv = meta:get_inventory()
	
	local face = meta:get_int("face") -- face never becomes 7 due to set_int returning it to 0 later on
	
	local moverstack = mover_inv:get_stack("main", 1)
	local moverstackname = moverstack:get_name()

	local face_pos = table.copy(pos)
	local mover_push = minetest.get_node_or_nil(face_pos)

	for i=face, 6 do
		face_pos = table.copy(pos) -- clear results if we don't exist the first time
		local pn = i
		
		if pn == 1 then face_pos.y = face_pos.y + 1 
		elseif pn == 2 then face_pos.z = face_pos.z + 1
		elseif pn == 3 then face_pos.z = face_pos.z - 1
		elseif pn == 4 then face_pos.x = face_pos.x + 1
		elseif pn == 5 then face_pos.x = face_pos.x - 1
		elseif pn == 6 then face_pos.y = face_pos.y - 1
		end

		mover_push = minetest.get_node_or_nil(face_pos)

		if face_pos.x == rpos.x then
			if face_pos.y == rpos.y then
				if face_pos.z == rpos.z then
					if pn == 6 then
						meta:set_int("face", 1)
					else
						meta:set_int("face", pn+1)
					end

					break
				end
			end
		end

		face_pos = table.copy(pos) -- because we need to reset once again because of the off chance of an inputting mover
		
		if pn == 1 then face_pos.y = face_pos.y + 1 
		elseif pn == 2 then face_pos.z = face_pos.z + 1
		elseif pn == 3 then face_pos.z = face_pos.z - 1
		elseif pn == 4 then face_pos.x = face_pos.x + 1
		elseif pn == 5 then face_pos.x = face_pos.x - 1
		elseif pn == 6 then face_pos.y = face_pos.y - 1
		end
		
		mover_push = minetest.get_node_or_nil(face_pos)

		if mover_push.name:sub(1,13) == "atvomat:mover" then
			if pn == 6 then
				meta:set_int("face", 1)
			else
				meta:set_int("face", pn+1)
			end

			break
		else
			if pn == 6 then meta:set_int("face", 1) end -- just in case we ever get stuck.
		end
	end

	if mover_push.name:sub(1,13) == "atvomat:mover" then -- is the node in front of us a mover? then we'll insert it directly instead of the push pull configuration. this bypasses the pull from container, then push
		local inv = minetest.get_meta(face_pos):get_inventory()
		
		if minetest.get_node_timer(face_pos):is_started() == false then
			minetest.get_node_timer(face_pos):start(1.0)
		end
		
		if inv:room_for_item("main", moverstackname) then
			moverstack:take_item()
			inv:add_item("main", moverstackname)
			mover_inv:set_stack("main", 1, moverstack)
		end

	end
	
	return true
end

minetest.register_node("atvomat:router_robin", {
	description = "Router (Round Robin, does not send to red.)",
	paramtype = "light",
	tiles = {"atvomat_router_robin.png"},
	drawtype = "mesh",
	mesh = "atvomat_sorter.b3d",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=3},
	on_place = mcore.rotate_axis,
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", atmover)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
		meta:set_int("face", 1)
		minetest.get_node_timer(pos):start(1.0)
	end,
	
	on_punch = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,

	on_timer = function(pos, elapsed)
		round_robin(pos)
		return true
	end
})

minetest.register_craft({
	output = "atvomat:router_robin",
	recipe = {
		{"", "core:mese_crystal", ""},
		{"core:mese_crystal", "atvomat:sorter", "core:mese_crystal"},
		{"", "core:mese_crystal", ""},
	},
})