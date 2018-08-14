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
			.. "button[0,1;2.15,1;quickslots;QuickSlots]"
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

	if page == "quickslots" then

		formspec = formspec ..
		"button[0,0;3,1;main;Return to Inventory]" ..
		"button[0,1;3,1;main;Save Slot Modes]" ..
		"label[0,2;Punch = item acts as if punched]"..
		"label[0,2.3;Use = item acts as if used]" ..
		"label[0,2.6;Place = item acts as if placed]" ..
		"label[0,2.9;Note, Place will be used automatically for blocks]" ..
	
		"dropdown[3.95,0.15;1;slot1;Use,Punch,Place;1]" ..
		"dropdown[3.95,1.15;1;slot1;Use,Punch,Place;1]" ..
		"dropdown[3.95,2.15;1;slot1;Use,Punch,Place;1]" ..
		"dropdown[5.95,0.15;1;slot1;Use,Punch,Place;1]" ..
		"dropdown[5.95,1.15;1;slot1;Use,Punch,Place;1]" ..
		"dropdown[5.95,2.15;1;slot1;Use,Punch,Place;1]" ..

		"list[current_player;quickslots;3,0;1,1;0]" ..
		"list[current_player;quickslots;3,1;1,1;1]" ..
		"list[current_player;quickslots;3,2;1,1;2]" ..
		"list[current_player;quickslots;7,0;1,1;3]" ..
		"list[current_player;quickslots;7,1;1,1;4]" ..
		"list[current_player;quickslots;7,2;1,1;5]" ..
		"background[-0.45,-0.5;8.9,10;core_inv_plus_guide.png]"

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

	-- quickslots

	if fields.quickslots then

		inventory_plus.set_inventory_formspec(player,
			inventory_plus.get_formspec(player, "quickslots"))
		
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