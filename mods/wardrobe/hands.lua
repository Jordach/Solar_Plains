-- wardrobehands, addon to wardrobe;

local player_names = {}

local p_choice = {}

local p_rgb = {}

local p_skin = {}

local p_size = {}

p_choice = minetest.deserialize(wardrobe.hand_textures:get_string("c"))

p_rgb = minetest.deserialize(wardrobe.hand_textures:get_string("rgb"))

p_skin = minetest.deserialize(wardrobe.hand_textures:get_string("skin"))

p_size = minetest.deserialize(wardrobe.hand_textures:get_string("size"))

local count = 1

if wardrobe.hand_textures:get_string("c") == "" then

else
	
	local iter
	
	if wardrobe.hand_textures:get_string("skin") == "" then -- occurs when a set of data cannot be found for servers with RGB data, but not skins
	
		iter = p_choice
	
	else
	
		iter = p_skin
		
	end
	
	for k, v in pairs(iter) do
		
		player_names[count] = k
		
		count = count + 1
		
		
	end
	
	print("[Wardrobe]: Hands Addon Loaded")
	
	--print(dump(p_choice))
	--print(dump(p_rgb))
	
	for k, v in pairs(player_names) do
		
		--print(":newhand:" .. v)
		
		if wardrobe.hand_textures:get_string("skin") ~= "" and p_skin[v] then
			
			local tex_string = "wardrobe_player_" .. v .. ".png"
			
			if p_size[v] == 32 then tex_string = "[combine:64x64:0,0=" .. tex_string end -- caution, will not support larger than 64 wide skins
			
			minetest.register_node(":newhand:" .. v, {
			
				description = "",
				tiles = {
					tex_string
				},
				
				on_place = function(itemstack, placer, pointed_thing)
					local stack = ItemStack(":")
					local ret = minetest.item_place(stack, placer, pointed_thing)
					return ItemStack("newhand:" .. v ..itemstack:get_count())
				end,
				
				drawtype = "mesh",
				mesh = "hand.b3d",
				node_placement_prediction = "",
				
			})
				
		elseif wardrobe.hand_textures:get_string("c") ~= "" then
		
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
					return ItemStack("newhand:" .. v ..itemstack:get_count())
				end,
				
				drawtype = "mesh",
				mesh = "hand.b3d",
				node_placement_prediction = "",
			})
		
		end
		
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
	
	player:get_inventory():set_stack("hand", 1, "newhand:_default_") -- normally we get a default hand if we don't have a custom appearance yet
	
	if wardrobe.hand_textures:get_string("skin") == "" or wardrobe.hand_textures:get_string("c") == "" then return end	
	
	for k, v in pairs(player_names) do -- iterate over the table to make sure the joining player has a skin
	
		if v == player:get_player_name() then -- and if they do -- we get to give them their custom arm.
			
			player:get_inventory():set_stack("hand", 1, "newhand:" .. v) -- we give the user their custom skin as an arm
			
		end
	
	end

end)