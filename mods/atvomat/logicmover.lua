-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

local atmover = 
	"size[8,9]" ..
	"list[current_name;item_a;3.5,2;1,1]" ..
	"list[current_name;item_b;3.5,2;1,1]" ..
	"list[current_name;comparator;3.5,2;1,1]" ..
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_mover_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]" ..
	"button[]"

local function atvomat_mover(pos, elapsed)
	local fpos = mcore.get_node_from_front(table.copy(pos))
	local rpos = mcore.get_node_from_rear(table.copy(pos))
	
	local front_node = minetest.get_node_or_nil(fpos)
	local rear_node = minetest.get_node_or_nil(rpos)
	
	local mover_inv = minetest.get_meta(pos):get_inventory()

	-- sanity checks to prevent crashes now.
	if front_node == nil then return true end
	if rear_node == nil then return true end
	
	-- take items from rear first;
	
	for k, v in pairs(atvomat.mover_input) do
		if rear_node.name == k then
			local inv = minetest.get_meta(rpos):get_inventory()
		
			for i=1, v[1] do
				local stack = inv:get_stack(v[2], i)
				local stackname = stack:get_name()
				local stacksize = stack:get_count()

				if stackname ~= "" then
					if mode then -- we're allowed to take the whole stack
						if mover_inv:room_for_item("main", stackname) then
							stack:take_item(1)
							mover_inv:add_item("main", stackname)
							inv:set_stack(v[2], i, stack)
					
							return true
						end
					elseif stacksize > 1 then -- we won't be moving singular items that aren't able to stack, but that's what sorters are for boi
						if mover_inv:room_for_item("main", stackname) then
							stack:take_item(1)
							mover_inv:add_item("main", stackname)
							inv:set_stack(v[2], i, stack)
					
							return true
						end
					end
				end
			end
		end
	end
	
	-- push items out of the green side; pushing into other movers is considered last in the chain
	
	local moverstack = mover_inv:get_stack("main", 1)
	local moverstackname = moverstack:get_name()
	
	for k, v in pairs(atvomat.mover_output) do
		if front_node.name == k then
			local inv = minetest.get_meta(fpos):get_inventory()
			
			if v[3] ~= false then
				minetest.get_node_timer(fpos):start(1.0)
			end
			
			for k2, v2 in pairs(atvomat.fuel_sort) do -- let's see if the mover has a fuel item inside it and check if it will fit inside the fuel slot entirely.
				if inv:room_for_item(v[2], moverstackname) and moverstackname == k2 then
					moverstack:take_item()
					inv:add_item(v[2], moverstackname)
					mover_inv:set_stack("main", 1, moverstack)

					return true
				end
			end
			
			if inv:room_for_item(v[1], moverstackname) then -- does it not fit or is the slot incapable of taking it in? fuel will be placed in the cooking or container slot instead.
				moverstack:take_item()
				inv:add_item(v[1], moverstackname)
				mover_inv:set_stack("main", 1, moverstack)
					
				return true
			end
		end
	end

	if front_node.name:sub(1,13) == "atvomat:mover" or front_node.name:sub(1,14) == "atvomat:router"  then -- is the node in front of us a mover? then we'll insert it directly instead of the push pull configuration. this bypasses the pull from container, then push
		local inv = minetest.get_meta(fpos):get_inventory()
		
		if minetest.get_node_timer(fpos):is_started() == false then
			minetest.get_node_timer(fpos):start(1.0)
		end
		
		if inv:room_for_item("main", moverstackname) then
			moverstack:take_item()
			inv:add_item("main", moverstackname)
			mover_inv:set_stack("main", 1, moverstack)
		end
	end
end

minetest.register_node("atvomat:logic_mover",{
	description = "Mover",
	drawtype = "mesh",
	mesh = "atvomat_mover.b3d",
	paramtype2 = "facedir",
	groups = {oddly_breakable_by_hand=3},
	paramtype = "light",
	tiles = {"atvomat_mover_mesh.png"},
	
	on_construct = function(pos)
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", atmover)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
		minetest.get_node_timer(pos):start(1.0)
	end,
	
	on_punch = function(pos)
		minetest.get_node_timer(pos):start(1.0)
	end,
	
	on_place = mcore.rotate_axis,
	on_timer = function(pos, elapsed)
		atvomat_mover(pos, elapsed)
		return true
	end,
	
})