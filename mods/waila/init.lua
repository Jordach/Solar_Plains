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

	WAWLA gets it's mod information from the origin mod folder, that the item, entity or node
	comes from, so please be aware of this.

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

-- Writing overrides;
--[[

	Overrides are a simple way for mod authors to provide a custom image for their
	node, entity or item, so that it can be rendered on the HUD with ease without
	using potential engine hacks or similar.

	Simply use the following:

	waila.override["node:name"] = "minetest_texture_string.png"

	Please note, this only applies to entities, items, nodeboxes, and meshes.

	An example entity render for an example mob or entity is inside this comment block:

	waila.entity_texture["core:moth"] = "lamps_broother.png"
]]--


waila.override["plants:daisy"] = "plants_daisys.png"

local function identify_node(player)
	local raybegin = vector.add(player:get_pos(), {x=0, y=1.64, z=0})
	local rayend = vector.add(raybegin, vector.multiply(player:get_look_dir(), 5))
	local ray = minetest.raycast(raybegin, rayend, false, false)
	local pointed = ray:next()
	if pointed then
		return minetest.registered_nodes[minetest.get_node(pointed.under).name], true, minetest.get_node(pointed.under)
	else
		return false, false, false
	end
end

local function draw_hud(player)
	local node, bool, pointed_thing = identify_node(player)
	local pname = player:get_player_name()
	if bool then
		player:hud_change(player_huds[pname].harvestable, "text", "Harvestable:")
		player:hud_change(player_huds[pname].bg, "text", "mthudclock.png^[opacity:155].png")
		
		if string.len(node.description) < 20 then
			player:hud_change(player_huds[pname].desc, "text", node.description)
		else
			player:hud_change(player_huds[pname].desc, "text", string.sub(node.description, 1, 17) .. "...")
		end


		-- scan for aliases
		for k, v in pairs(waila.alias) do
			if node.mod_origin == k then
				player:hud_change(player_huds[pname].modname, "text", v)
			end
		end

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

		for k, v in pairs(waila.override) do
			if node.name == k then
				player:hud_change(player_huds[pname].image, "text", v .. "^[resize:32x32")
			return
			end
		end

		if node.drawtype == "mesh" then
		elseif node.drawtype == "nodebox" then
		elseif node.drawtype == "torchlike" then
		elseif node.drawtype == "firelike" then
		elseif node.drawtype == "signlike" then
		elseif node.drawtype == "plantlike" then
			player:hud_change(player_huds[pname].image, "text", node.tiles[1] .. "^[resize:32x32")
		elseif node.drawtype == "plantlike_rooted" then
		elseif node.drawtype == "raillike" then
		elseif node.drawtype == "fencelike" then
			
		else
			local textures = {}
			local state
			for k, v in pairs(node.tiles) do
				if k == 1 then
					textures[1] = v
					state = 1
				end
				if k == 3 then
					textures[2] = v
					state = 3
				end
				if k == 5 then
					textures[3] = v
					state = 5
				end
			end

			if state == 1 then
				textures[2] = textures[1]
				textures[3] = textures[1]
			elseif state == 3 then
				textures[3] = textures[2]
			end

			local tstring = minetest.inventorycube(textures[1], textures[2], textures[3])
			player:hud_change(player_huds[pname].image, "text", tstring .. "^[resize:32x32")
		end
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
		text = "core_dirt.png",
		alignment = {x=1, y=0},
		offset = {x=30, y=31},
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