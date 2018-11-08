-- naturum
-- replacement for farming_plus
-- License: MIT

local function hoe_dirt(itemstack, user, pointed_thing, uses)
	
	if pointed_thing.type ~= "node" then
		return
	end
	
	local is_soil = minetest.get_item_group(
		minetest.get_node(pointed_thing.under).name, "dirt")

	if is_soil ~= 0 then
		minetest.set_node(pointed_thing.under, {name = "naturum:soil"})
		itemstack:add_wear(65535/uses)
		return itemstack
	end
end

minetest.register_tool("naturum:hoe_wood", {
	description = "Wooden Hoe",
	inventory_image = "naturum_hoe_wood.png",
	
	on_place = function(itemstack, user, pointed_thing)
		return hoe_dirt(itemstack, user, pointed_thing, 32)
	end,
})

minetest.register_tool("naturum:hoe_stone", {
	description = "Stone Hoe",
	inventory_image = "naturum_hoe_stone.png",
	
	on_place = function(itemstack, user, pointed_thing)
		hoe_dirt(itemstack, user, pointed_thing, 32)
	end,
})

minetest.register_tool("naturum:hoe_iron", {
	description = "Iron Hoe",
	inventory_image = "naturum_hoe_iron.png",
	
	on_place = function(itemstack, user, pointed_thing)
		hoe_dirt(itemstack, user, pointed_thing, 32)
	end,
})

minetest.register_tool("naturum:hoe_diamond", {
	description = "Diamond Hoe",
	inventory_image = "naturum_hoe_diamond.png",
	
	on_place = function(itemstack, user, pointed_thing)
		hoe_dirt(itemstack, user, pointed_thing, 32)
	end,
})