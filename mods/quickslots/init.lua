-- quickslots - a mod that grants the player upto 6 additional quick actions to perform
-- this can be used to place blocks, activate buckets, etc

-- base configuration options

quickslots_aux1_enabled = true
quickslots_sneak_enabled = true
quickslots_punch_enabled = true -- may break certain mods.

-- hud configuration

quickslots_hud_pos_x = 1 --base position in percentages
quickslots_hud_pos_y = 1
quickslots_hud_offset_x = 0 -- offset from base position in pixels
quickslots_hud_offset_y = 0 

quickslots_hud_orientation = "vertical" -- valid options: "vertical", "horizontal"
quickslots_hud_bg_image = "filename.png"

-- namespace for mods to hook for primary commands and checks

quickslots = {}

--[[

	Setting information about how quickslots meta works:

	0 = on_use
	1 = on_place
	2 = on_sec_use

]]--

-- load data for players:

minetest.register_on_joinplayer(function(player)

	local meta = player:get_meta()

	for i=1,6 do

		if meta:get_int("quickslots_slot_" .. i) == "" then

			meta:set_int("quickslots_slot_" .. i, 0)

		end
	
	end	

	local inv = minetest.get_inventory({type="player", name=player:get_player_name()})
	
	if inv:get_list("quickslots") == nil then

		inv:set_size("quickslots", 6)
		print("[QuickSlots]" .. player:get_player_name() .. " lacks QuickSlots, constructing them.")

	end

end)

-- process formspec data from inv_plus

function quickslots.set_slot_modes(player, fields)



end

-- get the slot the player is using:

function quickslots.get_quick_slots(player)

	local pkeys = player:get_player_control()

	--print(dump(pkeys))

	if pkeys.sneak then
		if pkeys.aux1 then
			if pkeys.LMB then
				return 6
			else
				return 3 -- right mouse
			end
		else
			if pkeys.LMB then
				return 4
			else
				return 1 -- right mouse
			end
		end

	elseif pkeys.aux1 then
		if pkeys.LMB then
			return 5
		else
			return 2 -- right mouse
		end
	end
end

--[[

	Writing your first compatible quickslots tool is easy!

	The first thing quickslots will check is that if the item is a node, ensuring that the block is placed.

	Then, it will check if the registered item has a registered right-click custom function.

	_quickslots_use_l = function(itemstack, placer, pointed_thing)

	_quickslots_use_r = function(itemstack, user, pointed_thing)

	_quickslots_place = function(itemstack, placer, pointed_thing)

	For items that are nodes, placement is automatic! You can override this by using:

	_quickslots_no_place = true

	To ensure they're automatically placed - having the field missing will do the same effect or the two following values.

	_quickslots_no_place = false
	_quickslots_no_place = nil

	However, to use such quick slots, the currently wielded tool must;

	Support using sneak and right mouse, alongside using the on_use function.

	Use quicktools.on_use(quicktools.get_quick_slots(user), user, pointed_thing) for on_use.
	
	Use quicktools.on_sec_use(quicktools.get_quick_slots(user), user, pointed_thing) for on_secondary_use.

	Use quicktools.on_place(quicktools.get_quick_slots(user), user, pointed_thing) for on_place.
	
	See the below example for implementing this yourself. If the tool has an alternate mode that requires sneak or aux1,
	perform the action and do not process quicktools. 

]]--

minetest.register_craftitem("quickslots:test", {

	description = "test for quickslots",

	inventory_image = "fire_basic_flame.png",

	on_use = function(itemstack, placer, pointed_thing)

		-- figure out which slot we're going to use:

		slotnum = quickslots.get_quick_slots(placer)
		-- get our player's settings for the current slot, if it's in on_use, on_place or on_sec_use
		--placer:get_int("quickslots_slot_" .. slotnum)

		

	end,

	on_secondary_use = function(itemstack, user, pointed_thing)

		slotnum = quickslots.get_quick_slots(user)

	end,

	on_place = function(itemstack, placer, pointed_thing)

		slotnum = quickslots.get_quick_slots(placer)

	end,

})

minetest.register_craftitem("quickslots:test_use", {

	description = "Tests the on_use function",
	inventory_image = "core_water.png",

	_quickslots_use_l = function(itemstack, placer, pointed_thing)

		minetest.chat_send_all("on_use quickslots test used")

	end,

})

minetest.register_craftitem("quickslots:test_use_r", {

	description = "Tests the on_sec_use function",
	inventory_image = "core_lava.png",

	_quickslots_use_r = function(itemstack, placer, pointed_thing)

		minetest.chat_send_all("on_sec_use quickslots test used")

	end,

})

minetest.register_craftitem("quickslots:test_place", {

	description = "Tests the on_place function",
	inventory_image = "core_cobble.png",

	_quickslots_place = function(itemstack, placer, pointed_thing)

		minetest.chat_send_all("on_place quickslots test used")

	end,

})