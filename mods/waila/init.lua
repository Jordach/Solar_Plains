-- what aren't i looking at, a Minecraft parody and parity mod
-- license, MIT, 🅱️

waila = {}

local pi = math.pi

local player_huds = {}

waila.alias = {}
waila.override = {}
waila.entity_texture = {}

-- Writing aliases;
--[[

	Aliases are a way to simply make a list of mods appear as a single part of a game,
	which allows game makers, or modpack authors to hide the submodule names if they're
	using names that aren't from the original mod.

	WAILA gets it's mod information from the origin mod folder, that the item, entity or node
	comes from, so please be aware of this.

	Aliases can also be directly baked into node registration and entity registrations;

	minetest.register_node("test:name", {
		_waila_alias = "Solar Plains",
	})

	minetest.register_entity("example:magic_pickaxe", {
		_waila_alias = "Inside the Box",
	})

	These will ALWAYS override the waila.alias["example"] = "Minetest Game"
]]--

waila.alias["core"] = "Solar Plains"
waila.alias["atvomat"] = "Solar Plains"
waila.alias["doors"] = "Solar Plains"
waila.alias["fire"] = "Solar Plains"
waila.alias["market"] = "Solar Plains"
waila.alias["plants"] = "Solar Plains"
waila.alias["bucket"] = "Solar Plains"
waila.alias["beds"] = "Solar Plains"
waila.alias["book"] = "Solar Plains"
waila.alias["intro"] = "Solar Plains"
waila.alias["stairs"] = "Solar Plains"
waila.alias["wardrobe"] = "Solar Plains"
waila.alias["xeviour"] = "Solar Plains"
waila.alias["naturum"] = "Solar Plains"

-- Writing overrides;
--[[

	Applying custom view textures for entities and nodes.

	Please note; textures are always resized to 32x32 by Waila.

	minetest.register_node("test:name", {
		_waila_texture = "texture.png^texture2.png",
	})

	minetest.register_entity("example:npc", {
		_waila_texture = "npc_male.png^[brighten",
	})

]]--

local function identify_node(player)
	local raybegin = vector.add(player:get_pos(), {x=0, y=1.64, z=0})
	local rayend = vector.add(raybegin, vector.multiply(player:get_look_dir(), 4))
	local ray = minetest.raycast(raybegin, rayend, false, false)
	local pointed = ray:next()
	if pointed then
		return minetest.registered_nodes[minetest.get_node(pointed.under).name], true, minetest.get_node(pointed.under)
	else
		return false, false, false
	end
end

local function node_harvestable_check(player, node)
	local pname = player:get_player_name()

	-- check against hand first, then check against wielded tool
	player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_false.png")
	
	if node.groups.oddly_breakable_by_hand == nil then
	elseif node.groups.oddly_breakable_by_hand < 5 then
		player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
	end

	if node.groups.crumbly == nil then
	elseif node.groups.crumbly < 5 then
		player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
	end

	if node.groups.snappy == nil then
	elseif node.groups.snappy == 3 then
		player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
	end

	if node.groups.choppy == nil then
	elseif node.groups.choppy == 3 then
		player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
	end

	local item = player:get_wielded_item():get_tool_capabilities()

	if item.groupcaps.cracky == nil then
	else
		for k, v in pairs(item.groupcaps.cracky.times) do
			if node.groups.cracky ~= nil then
				if node.groups.cracky <= k then
					player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
				end
			end
		end
	end

	if item.groupcaps.choppy == nil then
	else
		for k, v in pairs(item.groupcaps.choppy.times) do
			if node.groups.choppy ~= nil then
				if node.groups.choppy <= k then
					player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
				end
			end
		end
	end

	if item.groupcaps.snappy == nil then
	else
		for k, v in pairs(item.groupcaps.snappy.times) do
			if node.groups.snappy ~= nil then
				if node.groups.snappy <= k then
					player:hud_change(player_huds[pname].harvestimg, "text", "waila_harvestable_true.png")
				end
			end
		end
	end
end

local function render_node(player, node)
	local pname = player:get_player_name()
	
	for k, v in pairs(waila.override) do
		if node.name == k then
			player:hud_change(player_huds[pname].image, "text", v .. "^[resize:32x32")
		return
		end
	end

	if node._waila_texture == nil then
		-- try autodecting some textures; WIP
		if node.drawtype == "torchlike" then
			player:hud_change(player_huds[pname].image, "text", node.inventory_image[1] .. "^[resize:32x32")
		elseif node.drawtype == "firelike" then
			player:hud_change(player_huds[pname].image, "text", node.inventory_image[1] .. "^[resize:32x32")
		elseif node.drawtype == "signlike" then
			player:hud_change(player_huds[pname].image, "text", node.inventory_image[1] .. "^[resize:32x32")
		elseif node.drawtype == "plantlike" then
			player:hud_change(player_huds[pname].image, "text", node.tiles[1] .. "^[resize:32x32")
		elseif node.drawtype == "plantlike_rooted" then
			player:hud_change(player_huds[pname].image, "text", node.special_tiles[1].name .. "^[resize:32x32")
		elseif node.drawtype == "raillike" then
			player:hud_change(player_huds[pname].image, "text", node.tiles[1] .. "^[resize:32x32")
		elseif node.drawtype == "fencelike" then
			player:hud_change(player_huds[pname].image, "text", node.inventory_image[1] .. "^[resize:32x32")
		else
			local tstring
			local length = #node.tiles
			
			if length == 1 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[1], node.tiles[1])
			elseif length == 2 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[2], node.tiles[2])
			elseif length == 3 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[3], node.tiles[3])
			elseif length == 4 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[4], node.tiles[3])
			elseif length == 5 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[5], node.tiles[3])
			elseif length == 6 then
				tstring = minetest.inventorycube(node.tiles[1], node.tiles[6], node.tiles[3])
			end

			player:hud_change(player_huds[pname].image, "text", tstring .. "^[resize:32x32")
		end
	else
		player:hud_change(player_huds[pname].image, "text", node._waila_texture .. "^[resize:32x32")
	end
end

local function draw_hud(player)
	local node, bool, pointed_thing = identify_node(player)
	local pname = player:get_player_name()
	if bool then
		-- render hud stuff,
		player:hud_change(player_huds[pname].harvestable, "text", "Harvestable:")
		player:hud_change(player_huds[pname].bg, "text", "mthudclock.png^[opacity:155].png")
		
		-- put node desc into the hud box
		if string.len(node.description) < 20 then
			player:hud_change(player_huds[pname].desc, "text", node.description)
		else
			player:hud_change(player_huds[pname].desc, "text", string.sub(node.description, 1, 17) .. "...")
		end

		local found_name = false

		-- scan for aliases
		for k, v in pairs(waila.alias) do
			if node.mod_origin == k then
				player:hud_change(player_huds[pname].modname, "text", v)
				found_name = true
			end
		end

		-- if we're not use the origin mods name, capitalise it, but doesn't convert underscores
		if found_name ~= true then
			local stringy = node.mod_origin
			player:hud_change(player_huds[pname].modname, "text", stringy:sub(1,1):upper()..s:sub(2))
		end

		-- dependancy-less waila aliases override the dependancy method
		if node._waila_alias ~= nil then
			player:hud_change(player_huds[pname].modname, "text", node._waila_alias)
		end

		-- check for valid diggable node:
		node_harvestable_check(player, node)

		if node.paramtype2 == "facedir" then
			local facedir = mcore.facedir_stripper(pointed_thing)
			if facedir == 0 then player:hud_change(player_huds[pname].facedir, "text", "Facing: Up")
			elseif facedir == 1 then player:hud_change(player_huds[pname].facedir, "text", "Facing: North")
			elseif facedir == 2 then player:hud_change(player_huds[pname].facedir, "text", "Facing: South")
			elseif facedir == 3 then player:hud_change(player_huds[pname].facedir, "text", "Facing: East")
			elseif facedir == 4 then player:hud_change(player_huds[pname].facedir, "text", "Facing: West")
			elseif facedir == 5 then player:hud_change(player_huds[pname].facedir, "text", "Facing: Down")
			else player:hud_change(player_huds[pname].facedir, "text", "Facing: Unknown")
			end
		else -- add more other uses for param2
			player:hud_change(player_huds[pname].facedir, "text", "")
		end

		-- render image of pointed thing:
		render_node(player, node)
	else
		player:hud_change(player_huds[pname].desc, "text", "")
		player:hud_change(player_huds[pname].facedir, "text", "")
		player:hud_change(player_huds[pname].harvestable, "text", "")
		player:hud_change(player_huds[pname].modname, "text", "")
		player:hud_change(player_huds[pname].bg, "text", "ptextures_transparent.png")
		player:hud_change(player_huds[pname].harvestimg, "text", "ptextures_transparent.png")
		player:hud_change(player_huds[pname].image, "text", "ptextures_transparent.png")
		player:hud_change(player_huds[pname].modname, "text", "")
		
	end
end

local function core_loop()
	for _, player in ipairs(minetest.get_connected_players()) do
		if player ~= nil then
			draw_hud(player)
		end
	end

	minetest.after(0.25, core_loop)
end

core_loop()

function waila.init_hud(player)
	player_huds[player:get_player_name()] = {}
		
	local bg = player:hud_add({
		hud_elem_type = "image",
		position = {x=0.5, y=0},
		offset = {x=0, y=-8},
		scale = {x=1, y=1},
		text = "ptextures_transparent.png",
	})

	local itemimage = player:hud_add({
		hud_elem_type = "image",
		position = {x=0.5, y=0},
		scale = {x=1, y=1},
		text = "ptextures_transparent.png",
		offset = {x=-116, y=40},
		alignment = {x=1, y=0},
	})

	local desc = player:hud_add({
		hud_elem_type = "text",
		position = {x=0.5, y=0},
		text = "",
		number = 0xFFFFFF,
		alignment = {x=1, y=0},
		offset = {x=-74, y=10},
	})
	local harvestimg = player:hud_add({
		hud_elem_type = "image",
		position = {x=0.5, y=0},
		text = "ptextures_transparent.png",
		alignment = {x=1, y=0},
		offset = {x=30, y=30},
		scale = {x=1, y=1},
	})

	local harvestable = player:hud_add({
		hud_elem_type = "text",
		position = {x=0.5, y=0},
		text = "",
		number = 0xFFFFFF,
		alignment = {x=1, y=0},
		offset = {x=-74, y=30},
	})

	local modname = player:hud_add({
		hud_elem_type = "text",
		position = {x=0.5, y=0},
		text = "",
		number = 0xFFFFFF,
		alignment = {x=1, y=0},
		offset = {x=-74, y=70}
	})

	local facing = player:hud_add({
		hud_elem_type = "text",
		offset = {x=-74, y=50},
		position = {x=0.5, y=0},
		number = 0xFFFFFF,
		alignment = {x=1, y=0},
		text = "",

	})

	--local modname
	player_huds[player:get_player_name()].image = itemimage
	player_huds[player:get_player_name()].harvestable = harvestable
	player_huds[player:get_player_name()].harvestimg = harvestimg
	player_huds[player:get_player_name()].desc = desc
	player_huds[player:get_player_name()].facedir = facing
	player_huds[player:get_player_name()].itemimg = itemimg
	player_huds[player:get_player_name()].modname = modname
	player_huds[player:get_player_name()].bg = bg
end