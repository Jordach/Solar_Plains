-- beds Jordach / Solar Plains edition

-- namespace this badboy

beds = {}

--[[

Notes:

Times returned from "minetest.get_timeofday()"

0    is 12:00 AM
0.23 is 5:30 AM
0.25 is 6:00 AM

0.5  is 12:00 PM
0.75 is 18:00 or 6:00 PM
0.79 is 19:00 or 7:00 PM
]]--

-- time to set the "alarm clock" for sleeping players; use table above for more information.

local wake_time = 0.24

-- percent needed (of players sleeping) to pass the night
-- set this to 1 if you need all players sleeping
-- default setting is 25% of all players.

local percent_needed = 0.25

-- enable closing of eyes while sleeping;
-- requires Solar Plains' Wardrobe mod.
-- by default this setting is true.
-- set to false to disable it.

beds.use_wardrobe_support = true

-- enable waking players from their beds when the morning arrives
-- after the sleep vote has completed
-- true by default; use false to disable
-- this can be enabled for players who whish to AFK for periods
-- of time.

beds.wake_sleeping_players = true


-- how long before the pass night check runs again:
-- 30 seconds by default;

local pass_night_timer = 30

-- enable a wakeup jingle and seasonal specific jingles.
-- true by default; enabled globally by default,
-- players can opt out at anytime using a button in the formspec.
-- player attribute is beds_enable_jingle
-- usable settings are true, false
-- Note: Players must opt into it, but the server can disable the feature if required.

local enable_morning_jingle = true

-- make it gentle; not too loud
-- default setting is 0.25
-- acceptable settings range from 0 -> 1, including floating point numbers.

local jingle_volume = 0.25

-- sleeping players represented as:
-- player_sleeping[player_name] = true
-- and the following;
-- player_sleeping[player_name] = false

local player_sleeping = {}

-- storage for what bed the player initially slept in (for swapping between models)

-- beds are represented as:
-- player_bed_swap[player_name] = "beds:red_empty" (note: node is an example;)
-- this will be updated everytime the player lays in a bed, and should be expected to be that
-- bed the player has recently slept / lay'd in.

local player_bed_swap = {}

-- param works the same as above, stores a number instead of a string

local player_bed_param = {}

-- utilities;

local pi = math.pi


local function get_nodedef_field(nodename, fieldname) -- gets a feature of a block, eg walkable, or waving and so on
-- usage: "node:name", "walkable"

	if not minetest.registered_nodes[nodename] then
    
		return nil
    
	end
	
	return minetest.registered_nodes[nodename][fieldname]

end

function beds.get_yaw_from_facedir(pos) -- turns facedir into a useful yaw direction for players or for nodes wanting that facedir number
	
	local n = minetest.get_node(pos).param2
	
	if n == 1 then
		return pi / 2, n
		--return 1.5708, n
	elseif n == 3 then
		--return -pi / 2, n
		return 4.71239, n
	elseif n == 0 then
		return pi, n
		--return 3.14159, n
	else
		-- there's a rotation bug with using -pi
		return 0, n
	end
	
end

function beds.play_jingle(player) --players who don't sleep don't get the jingle

	-- check for seasonal and special days on the calendar here;
	-- currently TODO
	
	if player:get_attribute("beds_enable_jingle") == "true" and enable_morning_jingle then
	
		local jingle = minetest.sound_play("beds_morning_1", {
		
			to_player = player:get_player_name(),
			gain = jingle_volume,
		
		})
	
	end

end

-- formspec to display the button to leave the bed;

local function beds_formspec(player) 
	
	local jingle_image_state = ""
	local jingle_image_state_push = ""
	
	if player:get_attribute("beds_enable_jingle") == "true" then
	
		jingle_image_state = "beds_sound_enabled.png"
		jingle_image_state_push = "beds_sound_enabled_push.png"
	
	else
	
		jingle_image_state = "beds_sound_disabled.png"
		jingle_image_state_push = "beds_sound_disabled_push.png"
	
	end
	
	local formspec = "size[8.15,3]" ..
	"button[2.93,2.5;2.15,1;beds_exit;Get out of bed.]"..
	"field[1,0;7.15,1;beds_chat;;]"..
	"button[6.75,-0.3;1.5,1;beds_chat_snd;Send]"..
	"label[-0.1,-0.125;Chat:]"..
	"image_button[7.35,2.5;1,1;"..jingle_image_state..";beds_ui_jingle;;true;false;"..jingle_image_state_push.."]"
	
	return formspec

end

function beds.pass_night() -- wakes players when called and sets it to morning.
	minetest.set_timeofday(wake_time)
	
	minetest.after(2, function()
		
		if beds.wake_sleeping_players then
		
			beds.wake_players()
			
		end
		
	end)
end


function beds.wake_players() -- only to be used within a globalstep!!!

	players = minetest.get_connected_players()
	
	for key, pl in pairs(players) do
		
		local pname = pl:get_player_name()
		
		if player_sleeping[pname] == true then -- look for players who are actually sleeping
			
			local pos2 = pl:get_pos()
	
			minetest.set_node(pos2, {name=player_bed_swap[pname], param1=0, param2=player_bed_param[pname]})
			
			local pos = minetest.string_to_pos(pl:get_attribute("beds_spawn"))

			if pos == nil then return end -- unlikely, but this is Minetest
			
			pl:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = true, breathbar = false})
			
			player_sleeping[pname] = false
			
			pl:set_pos(pos)
			pl:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})
			
			pl:set_animation({x=0, y=79}, 30, 0)
			
			wardrobe.apply_to_player(pl)
			
			beds.play_jingle(pl)
			
			minetest.close_formspec(pl:get_player_name(), "beds_ui")
		end
		
	end

end

function beds.wake_specific_player(player) -- for those sleepy people (or leaving the formspec early!)
	
	local pname = player:get_player_name()
		
	if player_sleeping[pname] == true then -- look for players who are actually sleeping
			
		local pos2 = player:get_pos()
	
		minetest.set_node(pos2, {name=player_bed_swap[pname], param1=0, param2=player_bed_param[pname]})
			
		local pos = minetest.string_to_pos(player:get_attribute("beds_spawn"))

		if pos == nil then return end -- unlikely, but this is Minetest
			
		player:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = true, breathbar = false})
			
		player_sleeping[pname] = false
		
		player:set_pos(pos)
		player:set_eye_offset({x = 0, y = 0, z = 0}, {x = 0, y = 0, z = 0})

		player:set_animation({x=0, y=79}, 30, 0)
		
		wardrobe.apply_to_player(player)
			
		beds.play_jingle(player)
			
		minetest.close_formspec(player:get_player_name(), "beds_ui")
		
	end
end

function beds.set_respawn_point(pos, player, param)
	
	--[[
		facedir 0 is +x and -x (left and right)
		facedir 1 is +z and -z (left and right)
		facedir 2 is +x and -x (left and right)
		facedir 3 is +z and -z (left and right)
		
		these are relative to each facedir; keep this in mind.
	]]--
	
	local pname = player:get_player_name()
	
	minetest.chat_send_player(player:get_player_name(), "Spawnpoint set!")
	local p = {x=pos.x, y=pos.y, z=pos.z}
	local air = {x=pos.x, y=pos.y, z=pos.z}
	
	local nname = minetest.get_node(p).name
	
	if param == 0 or param == 2 then -- bed headrest and footer are pointing and north and south
		p   = {x=pos.x-1, y=pos.y-1, z=pos.z}
		air = {x=pos.x-1, y=pos.y, z=pos.z}
		
		nname = minetest.get_node(p).name
		
		if get_nodedef_field(nname, "walkable") == true and minetest.get_node(air).name == "air" then
			p = {x=pos.x-1, y=pos.y+0.25, z=pos.z}
			player:set_attribute("beds_spawn", minetest.pos_to_string(p))
			
			return
		end
		
		p = {x=pos.x+1, y=pos.y-1, z=pos.z}
		air = {x=pos.x+1, y=pos.y, z=pos.z}

		nname = minetest.get_node(p).name
		
		if get_nodedef_field(nname, "walkable") == true and minetest.get_node(air).name == "air" then
			p = {x=pos.x+1, y=pos.y+0.25, z=pos.z}
			player:set_attribute("beds_spawn", minetest.pos_to_string(p))
			
			return
		end
	
		-- failure to set a spawn on either side of the bed:
		
		p = {x=pos.x, y=pos.y+1, z=pos.z}
		player:set_attribute("beds_spawn", minetest.pos_to_string(p))
		
		return
		
	elseif param == 1 or param == 3 then -- bed headrest and footer are pointing east and west
	
		p = {x=pos.x, y=pos.y-1, z=pos.z-1}
		air = {x=pos.x, y=pos.y, z=pos.z-1}

		nname = minetest.get_node(p).name
		
		if get_nodedef_field(nname, "walkable") == true and minetest.get_node(air).name == "air" then
			p = {x=pos.x, y=pos.y+0.25, z=pos.z-1}
			player:set_attribute("beds_spawn", minetest.pos_to_string(p))
			
			return
		end
		
		p = {x=pos.x, y=pos.y-1, z=pos.z+1}
		air = {x=pos.x, y=pos.y, z=pos.z+1}

		nname = minetest.get_node(p).name
		
		if get_nodedef_field(nname, "walkable") == true and minetest.get_node(air).name == "air" then
			p = {x=pos.x, y=pos.y+0.25, z=pos.z+1}
			player:set_attribute("beds_spawn", minetest.pos_to_string(p))
			return
		end
	
		-- failure to set a spawn on either side of the bed:
		
		p = {x=pos.x, y=pos.y+1, z=pos.z}
		player:set_attribute("beds_spawn", minetest.pos_to_string(p))
		
		return
		
	end
	
end

-- make any node be a bed;

function beds.sleep(pos, player, height_offset, bed_node_norm, bed_node_slp) -- height_offset is used to determine where the damn pillow is
	-- bed_node_norm is a playerless bed, bed_node_slp is a bed with a player in.
	-- bed_node_norm gets stored as a 
	
	local yaw, param = beds.get_yaw_from_facedir(pos)
	
	local pname = player:get_player_name()
	
	beds.set_respawn_point(pos, player, param)
	
	player_sleeping[pname] = true
	player_bed_swap[pname] = bed_node_norm	
	
	minetest.show_formspec(pname, "beds_ui", beds_formspec(player))
	
	-- set player animation and stuffs
	
	
	player:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = false, breathbar = false})
	
	player_bed_param[pname] = param
	
	minetest.set_node(pos, {name=bed_node_slp, param1=0, param2=player_bed_param[pname]})
	
	player:set_look_horizontal(yaw)
	player:set_look_vertical(-0.261799)
	--player:set_look_vertical(0)
	player:setpos({x=pos.x, y=pos.y, z=pos.z})
	player:set_eye_offset({x=0, y=-14, z=0}, {x=0, y=0, z=0})
	wardrobe.close_eyes(player)
	player:set_animation({ x= 226, y=228, }, 0, false, false)
end



-- register node

minetest.register_node("beds:red", {
	description = "Bed",
	tiles = {"beds_red.png"},
	drawtype = "mesh",
	paramtype = "light",
	mesh = "bed.b3d",
	groups = {snappy=3},
	paramtype2 = "facedir",
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -1.25, 0.5, 0.1, 0.5},
		}
	},
	
	selection_box = {
			type = "fixed",
			fixed = {-0.55, -0.5, -1.5, 0.55, 0.25, 0.55},
	},
		
	on_rightclick = function(pos, node, clicker)
		beds.sleep(pos, clicker, 0.4, "beds:red", "beds:red_active") -- take a guess what this does, right?
	end,

})

minetest.register_node("beds:red_active", {
	description = "Bed",
	tiles = {"beds_red.png"},
	drawtype = "mesh",
	paramtype = "light",
	mesh = "bed_active.b3d",
	groups = {snappy=3},
	drop = "beds:red",
	paramtype2 = "facedir",
	sounds = mcore.sound_wood,
	collision_box = {
		type = "fixed",
		fixed = {
			{-0.5, -0.5, -1.25, 0.5, 0.1, 0.5},
		}
	},
	
	selection_box = {
			type = "fixed",
			fixed = {-0.55, -0.5, -1.5, 0.55, 0.25, 0.55},
	},
})

local function sleep_logic()

	-- wait until the time is past 7PM and is before 5:45AM
			
	local ctime = minetest.get_timeofday()
			
	if ctime < 0.23 or ctime > 0.79 then
			
		local numplayers = minetest.get_connected_players()
					
		local slp_pl = 0
					
		for key, pl in pairs(numplayers) do
			
			local pname = pl:get_player_name()
			
			if player_sleeping[pname] == true then
			
				slp_pl = slp_pl + 1 -- count the number of sleepers
					
			end
						
		end
							
		local player_perc = #numplayers * percent_needed
					
		if player_perc < slp_pl then
						
			beds.pass_night()
						
		end
	
	end

	minetest.after(pass_night_timer, sleep_logic)
end

minetest.register_on_respawnplayer(function(player)
	
	local pos = minetest.string_to_pos(player:get_attribute("beds_spawn"))

	if pos == nil then return false end
	
	local pname = player:get_player_name()

	player_sleeping[pname] = false

	player:set_pos(pos)
	
	return true
	
end)

minetest.register_on_player_receive_fields(function(player, formname, fields)
	
	if formname ~= "beds_ui" and player_sleeping[player:get_player_name()] == false then return false end
	
	if fields.key_enter_field or fields.beds_chat_snd then
	
		local pname = player:get_player_name()
	
		minetest.chat_send_all("<"..pname.."> ".. fields.beds_chat)
		minetest.close_formspec(pname, "beds_ui")
		minetest.after(0.01, minetest.show_formspec, pname, "beds_ui", beds_formspec(player))
		
		return true
	end
	
	if fields.beds_ui_jingle then
	
		local pname = player:get_player_name()
	
		if player:get_attribute("beds_enable_jingle") ~= "true" then
		
			player:set_attribute("beds_enable_jingle", "true")
			minetest.chat_send_player(pname, "Morning jingle is enabled.")
		else
	
			player:set_attribute("beds_enable_jingle", "false")
			minetest.chat_send_player(pname, "Morning jingle is disabled.")
		end
		minetest.close_formspec(pname, "beds_ui")
		minetest.after(0.01, minetest.show_formspec, pname, "beds_ui", beds_formspec(player))
		
		return true
		
	end
	
	if fields.quit or fields.beds_exit then
		
		beds.wake_specific_player(player)
	
		return true
	
	end
	
end)

minetest.register_on_leaveplayer(function(player)

	-- safety first; don't want returning players to be sleepwalking now, do we
	
	local pname = player:get_player_name()

	player_sleeping[pname] = false

end)

minetest.after(pass_night_timer, sleep_logic)