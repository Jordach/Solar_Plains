-- auto_maintainence, by Jordach

-- this mod requires at least a basic self restarting script to allow for re-generating of player hands

-- notes:

-- a player must connect first before the server is able to shutdown automatically.

-- this can be disabled by running /no_reboot

-- enabling the auto-restart system can be done via /auto_reboot

-- or by setting enable_auto_shutdown to false

local enable_auto_shutdown = true

local is_shutting_down = false

local has_player_joined_yet = false

local players_joined = 0

local shutdown_delay = 240

local auto_check_delay = 120

local shutdown_message = "Server is shutting down to re-generate player hands and perform maintenance. Thank you for your patience."

-- register chat commands

minetest.register_chatcommand("no_reboot", {
	
	description = "disables the automatic restarts",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to stop automated maintainence. \n \n This incident WILL be reported."
		end
		
		enable_auto_shutdown = false
		minetest.cancel_shutdown_requests()
		
		return true, "Automatic server restarts disabled."
	end,

})

minetest.register_chatcommand("auto_reboot", {
	
	description = "enables the automatic restarts",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to start automated maintainence. \n \n This incident WILL be reported."
		end
		
		enable_auto_shutdown = true
		return true, "Automatic server restarts enabled."
	end,

})

local function check_for_players()

	if players_joined > 0 then
	
		if is_shutting_down == true then
		
			is_shutting_down = false
			
			minetest.cancel_shutdown_requests()
		
		end
		
		print("[Maintainence]: Server will not reboot until a player joins and leaves first.")
	
	elseif players_joined == 0 then
			
		if enable_auto_shutdown == true then
			
			if is_shutting_down == false then
				
				if has_player_joined_yet == true then
				
					minetest.request_shutdown(shutdown_message, true, shutdown_delay)
				
					minetest.chat_send_all("\n \n \n \n \n Server shutdown in 60 seconds.")
					
				else
				
					print("[Maintainence]: Server will not reboot until a player joins and leaves first.")
				
				end
			
			end
			
			is_shutting_down = true
			
			
			
			
		end
	
	end
	
	minetest.after(auto_check_delay, check_for_players)
end

minetest.register_on_joinplayer(function(player)

	players_joined = players_joined + 1
	
	has_player_joined_yet = true
	
end)

minetest.register_on_leaveplayer(function(player)

	players_joined = players_joined - 1

end)

minetest.after(auto_check_delay, check_for_players)