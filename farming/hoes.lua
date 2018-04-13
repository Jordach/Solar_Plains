
local S = farming.intllib

-- Hoe registration function

farming.register_hoe = function(name, def)

	-- Check for : prefix (register new hoes in your mod's namespace)
	if name:sub(1,1) ~= ":" then
		name = ":" .. name
	end

	-- Check def table
	if def.description == nil then
		def.description = "Hoe"
	end

	if def.inventory_image == nil then
		def.inventory_image = "unknown_item.png"
	end

	if def.recipe == nil then
		def.recipe = {
			{"air","air",""},
			{"","group:stick",""},
			{"","group:stick",""}
		}
	end

	if def.max_uses == nil then
		def.max_uses = 30
	end

	-- Register the tool
	minetest.register_tool(name, {
		description = def.description,
		inventory_image = def.inventory_image,
		on_use = function(itemstack, user, pointed_thing)
			return farming.hoe_on_use(itemstack, user, pointed_thing, def.max_uses)
		end
	})

	-- Register its recipe
	if def.material == nil then
		minetest.register_craft({
			output = name:sub(2),
			recipe = def.recipe
		})
	else
		minetest.register_craft({
			output = name:sub(2),
			recipe = {
				{def.material, def.material, ""},
				{"", "group:stick", ""},
				{"", "group:stick", ""}
			}
		})
	end
end

-- Turns dirt with group soil=1 into soil

function farming.hoe_on_use(itemstack, user, pointed_thing, uses)

	local pt = pointed_thing

	-- check if pointing at a node
	if not pt or pt.type ~= "node" then
		return
	end
	
	local under = minetest.get_node(pt.under)
	local upos = pointed_thing.under

	if minetest.is_protected(upos, user:get_player_name()) then
		minetest.record_protection_violation(upos, user:get_player_name())
		return
	end

	local p = {x = pt.under.x, y = pt.under.y + 1, z = pt.under.z}
	local above = minetest.get_node(p)
	
	-- return if any of the nodes is not registered
	if not minetest.registered_nodes[under.name]
	or not minetest.registered_nodes[above.name] then
		return
	end
	
	-- check if the node above the pointed thing is air
	if above.name ~= "air" then
		return
	end
	
	-- check if pointing at dirt
	if minetest.get_item_group(under.name, "soil") ~= 1 then
		return
	end
	
	-- turn the node into soil, wear out item and play sound
	minetest.set_node(pt.under, {name = "farming:soil"})

	minetest.sound_play("default_dig_crumbly", {pos = pt.under, gain = 0.5})

	if not minetest.setting_getbool("creative_mode") then
		itemstack:add_wear(65535/(uses-1))
	end

	return itemstack
end

-- Define Hoes

farming.register_hoe(":farming:hoe_wood", {
	description = S("Wooden Hoe"),
	inventory_image = "farming_tool_woodhoe.png",
	max_uses = 500,
	material = "group:planks"
})

farming.register_hoe(":farming:hoe_stone", {
	description = S("Stone Hoe"),
	inventory_image = "farming_tool_stonehoe.png",
	max_uses = 1000,
	material = "group:stone"
})

farming.register_hoe(":farming:hoe_steel", {
	description = S("Steel Hoe"),
	inventory_image = "farming_tool_steelhoe.png",
	max_uses = 2000,
	material = "core:iron_ingot"
})

farming.register_hoe(":farming:hoe_ironze", {
	description = S("Ironze Hoe"),
	inventory_image = "farming_tool_bronzehoe.png",
	max_uses = 2500,
	material = "core:ironze_ingot"
})

farming.register_hoe(":farming:hoe_mese", {
	description = S("MESE Hoe"),
	inventory_image = "farming_tool_mesehoe.png",
	max_uses = 5000,
	material = "core:mese_crystal"
})

farming.register_hoe(":farming:hoe_diamond", {
	description = S("Diamond Hoe"),
	inventory_image = "farming_tool_diamondhoe.png",
	max_uses = 10000,
	material = "core:diamond"
})
