-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

-- table of nodes not to dig or collect;

atvomat.breaker_blacklist = {}

--

atvomat.breaker_blacklist["core:chest"] = ""
atvomat.breaker_blacklist["core:chest_locked"] = ""
atvomat.breaker_blacklist["core:lava_source"] = ""
atvomat.breaker_blacklist["core:lava_flowing"] = ""
atvomat.breaker_blacklist["core:water_source"] = ""
atvomat.breaker_blacklist["core:water_flowing"] = ""
atvomat.breaker_blacklist["core:furnace"] = ""
atvomat.breaker_blacklist["core:furnace_active"] = ""
atvomat.breaker_blacklist["air"] = ""
atvomat.breaker_blacklist["ignore"] = ""
atvomat.breaker_blacklist["atvomat:breaker_1"] = ""
atvomat.breaker_blacklist["atvomat:breaker_2"] = ""
atvomat.breaker_blacklist["atvomat:sorter"] = ""
atvomat.breaker_blacklist["atvomat:mover"] = ""

local atbreaker = 

	"size[8,9]" ..
	"list[current_name;main;3.5,2;1,1]" ..
	"list[current_player;main;0,4.5;8,1;]" ..
	"list[current_player;main;0,6;8,3;8]" ..
	"liststring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_breaker_interface.png]"..
	"listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"

minetest.register_node("atvomat:breaker_1", {

	description = "Automatic Block Breaker (Target is highlighted.)",
	tiles = {"atvomat_breaker_t1_body.png"},
	
	drawtype = "mesh",
	mesh = "atvomat_breaker.b3d",
	paramtype2 = "facedir",
	
	groups = {oddly_breakable_by_hand=2},
	
	on_construct = function(pos)
	
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", atbreaker)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
		meta:set_string("active", "false")
		meta:set_string("infotext", "Auto Block Breaker, Disabled.")
	end,
	
	on_place = mcore.sensible_facedir,
	
	on_punch = function(pos, node, puncher)
	
		local meta = minetest.get_meta(pos)
		
		if meta:get_string("active") == "false" then
		
			meta:set_string("active", "true")
			minetest.get_node_timer(pos):start(3)
			
			meta:set_string("infotext", "Auto Block Breaker, Enabled.")
			
		else
		
			meta:set_string("active", "false")
			
			meta:set_string("infotext", "Auto Block Breaker, Disabled.")
			
		end		
	
	end,
	
	on_timer = function(pos, elapsed)
	
		local meta = minetest.get_meta(pos)
		
		if meta:get_string("active") == "true" then
		
			local inv = meta:get_inventory()
		
			local fpos = mcore.get_node_from_front(table.copy(pos))
		
			local front_node = minetest.get_node_or_nil(fpos)
			
			for k, v in pairs(atvomat.breaker_blacklist) do
	
				if front_node.name == k then return true end
	
			end
			
			minetest.remove_node(fpos)
			
			local drop = minetest.get_node_drops(front_node.name, "core:mese_pickaxe_5")
			
			for k, drop in ipairs(drop) do
					
				inv:add_item("main", drop)
					
				return true
			
			end
		
		else
		
			return false
			
		end
	
	end,
	
})

minetest.register_node("atvomat:breaker_2", {

	description = "Automatic Block Collector (Target is highlighted, gently collects blocks.)",
	tiles = {"atvomat_breaker_t2_body.png"},
	
	drawtype = "mesh",
	mesh = "atvomat_breaker.b3d",
	paramtype2 = "facedir",
	
	groups = {oddly_breakable_by_hand=2},
	
	on_construct = function(pos)
	
		local meta = minetest.get_meta(pos)
		meta:set_string("formspec", atbreaker)
		local inv = meta:get_inventory()
		inv:set_size("main", 1)
		meta:set_string("active", "false")
		meta:set_string("infotext", "Automatic Block Collector (Gently collects blocks), Disabled.")
	end,
	
	on_place = mcore.sensible_facedir,
	
	on_punch = function(pos, node, puncher)
	
		local meta = minetest.get_meta(pos)
		
		if meta:get_string("active") == "false" then
		
			meta:set_string("active", "true")
			minetest.get_node_timer(pos):start(3)
			
			meta:set_string("infotext", "Auto Block Collector (Gently collects blocks), Enabled.")
			
		else
		
			meta:set_string("active", "false")
			
			meta:set_string("infotext", "Auto Block Collector (Gently collects blocks), Disabled.")
			
		end		
	
	end,
	
	on_timer = function(pos, elapsed)
	
		local meta = minetest.get_meta(pos)
		
		if meta:get_string("active") == "true" then
		
			local inv = meta:get_inventory()
		
			local fpos = mcore.get_node_from_front(table.copy(pos))
		
			local front_node = minetest.get_node_or_nil(fpos)
			
			for k, v in pairs(atvomat.breaker_blacklist) do
	
				if front_node.name == k then return true end
	
			end
			
			minetest.remove_node(fpos)
					
			inv:add_item("main", front_node.name)
					
			return true
			
		else
		
			return false
			
		end
	
	end,
	
})

minetest.register_craft({

	output = "atvomat:breaker_1",
	recipe = {
	
		{"core:iron_ingot", "core:mese", "core:iron_ingot"},
		{"core:iron_ingot", "core:mese_pickaxe_3", "core:iron_ingot"},
		{"core:iron_ingot", "core:chest", "core:iron_ingot"}
	
	},
	
	replacements = {
	
		{"core:mese_pickaxe_3", "core:mese_pickaxe_1"},
	
	},
	
})

minetest.register_craft({

	output = "atvomat:breaker_2",
	recipe = {
	
		{"core:mese_crystal", "core:mese", "core:mese_crystal"},
		{"core:mese_crystal", "core:mese_pickaxe_5", "core:mese_crystal"},
		{"core:mese_crystal", "atvomat:breaker_1", "core:mese_crystal"}
	
	},
	
	replacements = {
	
		{"core:mese_pickaxe_5", "core:mese_pickaxe_3"},
	
	},
	
})