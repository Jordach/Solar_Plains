--[[

Inventory Plus for Minetest

Copyright (c) 2012 cornernote, Brett O'Donnell <cornernote@gmail.com>
Source Code: https://github.com/cornernote/minetest-inventory_plus
License: BSD-3-Clause https://raw.github.com/cornernote/minetest-inventory_plus/master/LICENSE

Edited by TenPlus1 (19th October 2016)

]]--

-- compatibility with older minetest versions
if not rawget(_G, "creative") then
	local creative = {}
end

-- check for new creative addition
local addition = ""

addition = "button[5.4,4.2;2.65,0.3;main;Back]"

-- expose api
inventory_plus = {}

-- define buttons
inventory_plus.buttons = {}

-- default inventory page
inventory_plus.default = minetest.settings:get("inventory_default") or "craft"

-- register_button
inventory_plus.register_button = function(player, name, label)

	local player_name = player:get_player_name()

	if inventory_plus.buttons[player_name] == nil then
		inventory_plus.buttons[player_name] = {}
	end

	inventory_plus.buttons[player_name][name] = label
end

-- set_inventory_formspec
inventory_plus.set_inventory_formspec = function(player, formspec)

	 -- error checking
	if not formspec then
		return
	end

	-- short pause before setting inventory
	minetest.after(0.01, function()
		player:set_inventory_formspec(formspec)
	end)
end

-- create detached inventory for trashcan
local trashInv = minetest.create_detached_inventory("trash", {

	on_put = function(inv, toList, toIndex, stack, player)
		inv:set_stack(toList, toIndex, {})
	end
})

trashInv:set_size("main", 1)

-- get_formspec
inventory_plus.get_formspec = function(player, page)

	if not player then
		return
	end

	-- creative page
	if page == "creative" then

		return player:get_inventory_formspec() .. addition
	end

	-- default inventory page
	local formspec = "size[8,9]"
		-- .. default.gui_bg
		-- .. default.gui_bg_img
		-- .. default.gui_slots
		.. "list[current_player;main;0,4.5;8,1;]"
		.. "list[current_player;main;0,6;8,3;8]"
		.. "listcolors[#573b2e;#de9860;#ffffff;#3f2832;#ffffff]"
		
		
	-- craft page
	if page == "craft" then

		if not player:get_inventory() then
			print ("[Inventory Plus] NO PLAYER INVENTORY FOUND!")
			return
		end

		formspec = formspec
			.. "button[0,0;2.15,1;cguide;Crafting Guide]"
			.. "list[current_player;craftpreview;7,1;1,1;]"
			.. "list[current_player;craft;3,0;3,3;]"
			.. "listring[current_name;craft]"
			.. "listring[current_player;main]"
			-- trash icon
			.. "list[detached:trash;main;0,2.95;1,1;]"
			.. "image[6,1;1,1;core_crafting_arrow.png]"
			.. "background[-0.45,-0.5;8.9,10;core_inv_plus_craft.png]"
			--.. "image[1.1,2.1;0.8,0.8;trash_icon.png]"
	end

	-- main page
	if page == "main" then

		local name = player:get_player_name()
		local num = 0

		-- count buttons
		for k, v in pairs( inventory_plus.buttons[name] ) do
			num = num + 1
		end

		-- buttons
		local x = 0
		local f = math.ceil(num / 4)
		local y = 0

		for k, v in pairs( inventory_plus.buttons[name] ) do

			formspec = formspec .. "image_button[" .. x .. ","
				 .. y .. ";2,1;core_button_wood.png;" .. k .. ";" .. v .. ";false;false;core_button_wood_pressed.png]"

			x = x + 2

			if x == 8 then
				x = 0
				y = y + 1
			end
		end
		
		formspec = formspec .. "background[-0.45,-0.5;8.9,10;core_inv_plus.png]"
	end

	return formspec
end

-- register_on_joinplayer
minetest.register_on_joinplayer(function(player)

	inventory_plus.register_button(player,"craft", "Crafting")

	if minetest.settings:get_bool("creative_mode")
	or minetest.check_player_privs(player:get_player_name(), {creative = true}) then
		inventory_plus.register_button(player, "creative_prev", "Creative")
	end

	minetest.after(1, function()

		inventory_plus.set_inventory_formspec(player,
				inventory_plus.get_formspec(player, inventory_plus.default))
	end)
end)

-- register_on_player_receive_fields
minetest.register_on_player_receive_fields(function(player, formname, fields)

	if fields.cguide then

		inventory_plus.set_inventory_formspec(player, zcg.formspec(player:get_player_name()))

		return
		
	end

	-- craft
	if fields.main then

		inventory_plus.set_inventory_formspec(player,
				inventory_plus.get_formspec(player, "craft"))

		return
	end

	-- creative
	if fields.creative_prev
	or fields.creative_next then

		minetest.after(0.1, function()

			inventory_plus.set_inventory_formspec(player,
					inventory_plus.get_formspec(player, "creative"))
		end)

		return
	end
end)