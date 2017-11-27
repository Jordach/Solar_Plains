-- wardrobehands, addon to wardrobe;

local player_names = {}

local p_choice = {}

local p_rgb = {}

p_choice = minetest.deserialize(wardrobe.hand_textures:get_string("c"))

p_rgb = minetest.deserialize(wardrobe.hand_textures:get_string("rgb"))

local count = 1

if wardrobe.hand_textures:get_string("c") == "" then

else

	for k, v in pairs(p_choice) do
		
		player_names[count] = k
		
		--print("[Wardrobe] Hands Addon Loaded, name: " .. k)
		
		count = count + 1
		
	end

	for k, v in pairs(player_names) do

		minetest.register_node(":newhand:" .. v, {
			description = "",
		
			tiles = {
		
				"(wardrobe_skin.png^[multiply:#".. p_rgb[v][1].. ")^"..
				"(wardrobe_under_shirt_" .. p_choice[v][5] .. ".png^[multiply:#".. p_rgb[v][5].. ")^"..
				"(wardrobe_under_shirt_" .. p_choice[v][6] .. ".png^[multiply:#".. p_rgb[v][6].. ")^"..
				"(wardrobe_shirt_" .. p_choice[v][11] .. ".png^[multiply:#".. p_rgb[v][11].. ")^"..
				"(wardrobe_shirt_" .. p_choice[v][12] .. ".png^[multiply:#".. p_rgb[v][12]..")",
		
			},
		
			on_place = function(itemstack, placer, pointed_thing)
				local stack = ItemStack(":")
				local ret = minetest.item_place(stack, placer, pointed_thing)
				return ItemStack("newhand:hand "..itemstack:get_count())
			end,
			
			--sunlight_propagates = true,
			--visual_scale = 1,
			--wield_scale = {x=1,y=1,z=1},
			--paramtype = "light",
			drawtype = "mesh",
			mesh = "hand.b3d",
			node_placement_prediction = "",
		})

	end

end
	
minetest.register_node(":newhand:_default_", {
	description = "",
	
	tiles = {
	
			"(wardrobe_skin.png^[multiply:#e3c0a3)^"..
			"(wardrobe_under_shirt_2.png^[multiply:#dddddd)^"..
			"(wardrobe_under_shirt_1.png^[multiply:#ffffff)^"..
			"(wardrobe_shirt_2.png^[multiply:#39881c)^"..
			"(wardrobe_shirt_1.png^[multiply:#ffffff)",
	
	},
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack(":")
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("newhand:hand "..itemstack:get_count())
	end,
	--visual_scale = 1,
	--wield_scale = {x=1,y=1,z=1},
	--paramtype = "light",
	drawtype = "mesh",
	mesh = "hand.b3d",
	node_placement_prediction = "",
})

minetest.register_on_joinplayer(function(player)
	
	--local has_hand = false
	
	if wardrobe.hand_textures:get_string("c") == "" then
	
		player:get_inventory():set_stack("hand", 1, "newhand:_default_")
	
	else
	
		for k, v in pairs(player_names) do
		
			if v == player:get_player_name() then
				
				player:get_inventory():set_stack("hand", 1, "newhand:" .. v)
				
			else
			
				player:get_inventory():set_stack("hand", 1, "newhand:_default_")
			
			end
		
		end
		
	end
	
end)