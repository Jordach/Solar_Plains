-- avtomat, mover - (automatico, automation)
-- part of solar plains, by jordach

-- format for registering your own designations for the mover to take items from

--[[

	atvomat.mover_input["node:name"] = { -- string, "node:name" is the target to pull items from.
	
		1, -- int, the number of slots to scan for items in. 8*4 is the standard chest size.
		"main", -- string, the name of the list to pull items from.
	
	}

]]-- 

atvomat.mover_input = {}

-- format for registering a output, eg, from mover to insert items into

--[[

	atvomat.mover_output["node:name"] = { -- string, "node:name" is the target for pushing items into
	
		"main", -- string, the name of the list to push items into v[1]
		"fuel", -- string, the name of the secondary slot for burnable items to be pushed into v[2]
		false,  -- bool, does the node need a node timer to be started? (example, furnace needs it to start smelting) v[3]
	}

]]--

atvomat.mover_output = {}

-- list of burnable shit that has the burntime crap associated with it

--[[

	format for burnable shit:
	
	atvomat.mover_burnable["item:name"] = "" -- string, "item:name" is only required, but, in future, this might be different to make life easier

]]-- 

-- the mover is unlisted for the specfic reason which is what i won't go into, as pairs() may make atvomat first instead of core.

-- todo, automate this to detect anything wsith a burntime?

atvomat.mover_burnable = {}

atvomat.mover_burnable["core:coal_lump"] = ""

-- registration of extractable containers:

atvomat.mover_input["core:chest"] = {

	32,
	"main"

}

atvomat.mover_input["core:furnace"] = {

	4,
	"dst"

}

atvomat.mover_input["core:furnace_active"] = {

	4,
	"dst"

}

atvomat.mover_input["atvomat:breaker_1"] = {

	1,
	"main"

}

atvomat.mover_input["atvomat:breaker_2"] = {

	1,
	"main"

}

-- registration of insertable containers:

atvomat.mover_output["core:chest"] = {

	"main",
	"main",
	false
}

atvomat.mover_output["core:chest_locked"] = {

	"main",
	"main",
	false
}

atvomat.mover_output["core:furnace"] = {

	"src",
	"fuel",
	true

}

atvomat.mover_output["core:furnace_active"] = {

	"src",
	"fuel",
	true

}

atvomat.mover_output["atvomat:sorter"] = {

	"main",
	"main",
	true
	
}

local atmover = 

	"size[8,9]" ..
	"list[current_name;main;3.5,2;1,1]" ..
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"liststring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_mover_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"

	
-- local function show_status(pos, )

-- end

minetest.register_node("atvomat:mover",{
	description = "Mover (Moves Items from Red to Green)",
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
	
	on_place = minetest.rotate_and_place,
	
	on_timer = function(pos, elapsed)
	
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
				
					if stackname ~= "" then
				
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
		
		if front_node.name == "atvomat:mover" then -- is the node in front of us a mover? then we'll insert it directly instead of the push pull configuration. this bypasses the pull from container, then push
		
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
		
		return true
		
	end,
	
})

minetest.register_craft({

	output = "atvomat:mover",
	
	recipe = {
	
		{"group:planks", "core:iron_ingot", ""},
		{"core:chest", "core:mese_crystal", "core:chest"},
		{"group:planks", "core:iron_ingot", ""}
	
	},

})
