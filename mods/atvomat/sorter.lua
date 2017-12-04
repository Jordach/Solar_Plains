-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

--like the mover, the format for adding items into the list of sorting cards is: atvomat.ingot_sort["item:name"] = ""

atvomat.ingot_sort = {}

atvomat.ingot_block_sort = {}

atvomat.ore_sort = {}

atvomat.dye_sort = {}

-- register ingots for sorting:



--[[

list of item inventories for the sorter

face outputs for sorting:

up 
down
left
right
front
back

main -- single slot for storing items.

]]--

local atsorter = 

	"size[8,9]" ..
	"list[current_name;main;3.5,3.25;1,1]" ..
	"list[current_name;up;0,0;3,1]" .. 
	"list[current_name;down;5,0;3,1]" .. 
	"list[current_name;left;0,1;3,1]" .. 
	"list[current_name;right;5,1;3,1]" .. 
	"list[current_name;front;0,2;3,1]" .. 
	"list[current_name;back;5,2;3,1]" .. 
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_sorter_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"
	
minetest.register_node("atvomat:sorter", {

	description = "Sorter (Sorts things based on items inside of it.)",
	paramtype = "light",
	tiles = {"atvomat_sorter_mesh.png"},
	drawtype = "mesh",
	mesh = "atvomat_sorter.b3d",
	groups = {oddly_breakable_by_hand=3},
	
	on_construct = function(pos)
	
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", atsorter)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
		inv:set_size("up", 3)
		inv:set_size("down", 3)
		inv:set_size("left", 3)
		inv:set_size("right", 3)
		inv:set_size("front", 3)
		inv:set_size("back", 3)
		minetest.get_node_timer(pos):start(1.0)
	end,

})