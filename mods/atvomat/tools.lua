-- avtomat - (automatico, automation)
-- part of solar plains, by jordach

local rdir = {}

rdir[0] = minetest.dir_to_facedir({x=-1,y= 0,z= 0},true)
rdir[1] = minetest.dir_to_facedir({x= 0,y= 0,z=-1},true)
rdir[2] = minetest.dir_to_facedir({x= 0,y= 1,z= 0},true)
rdir[3] = minetest.dir_to_facedir({x= 0,y=-1,z= 0},true)
rdir[4] = minetest.dir_to_facedir({x= 1,y= 0,z= 0},true)
rdir[5] = minetest.dir_to_facedir({x= 0,y= 0,z= 1},true)

minetest.register_craftitem("atvomat:convincer", {

	description = "Engineer's Convincer",
	inventory_image = "atvomat_convincer.png",
	stack_max = 1,
	
	on_use = function(itemstack, user, pointed_thing)
	
		if pointed_thing.type == "node" then
		
			local node = minetest.get_node(pointed_thing.under)
			
			local fdir = mcore.facedir_stripper(node)
			
			print(fdir)
			
			print(dump(user:get_look_dir()))
			
			if node.name == "atvomat:mover" then
			
				minetest.set_node(pointed_thing.under, {name="atvomat:mover", param2 = minetest.dir_to_facedir(user:get_look_dir(), true) })
				
			end
			
		end
		
		return itemstack
		
	end,
	
})