-- atmos, control of skies, weather (when doable.)

atmos = {}

minetest.register_chatcommand("ratio", {
	
	description = "debugs the current atmos based weather system",
	param = "use a number to select the weather type.",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to control the weather, you scrub. \n \n This incident WILL be reported."
		end
		
		atmos.current_weather = 0 + param
		
		local player = minetest.get_player_by_name(name)
		
		atmos.set_skybox(player)
		
		return true, "Current weather updated."
	end,

})

-- 

atmos.weather_type = 1
atmos.current_weather = 3

atmos.weather_sky_colour = {}
atmos.weather_sky_type = {}
atmos.weather_light_level = {}

atmos.weather_clouds = {}
atmos.weather_cloud_colour = {}
atmos.weather_cloud_direction = {}
atmos.weather_cloud_thicc = {}
atmos.weather_cloud_height = {}


-- sky settings, items 1-4 are here just for completeness, not functionality

atmos.weather_sky_colour[1] = "#8bb9f9"
atmos.weather_sky_colour[2] = "#8bb9f9"
atmos.weather_sky_colour[3] = "#8bb9f9"
atmos.weather_sky_colour[4] = "#8bb9f9"
atmos.weather_sky_colour[5] = "#9b9b9b"
atmos.weather_sky_colour[6] = "#000409"
atmos.weather_sky_colour[7] = "#8b8b8b"
atmos.weather_sky_colour[8] = "#000409"
atmos.weather_sky_colour[9] = "#333b46"
atmos.weather_sky_colour[10] = "#000409"
atmos.weather_sky_colour[11] = "#333b46"
atmos.weather_sky_colour[12] = "#000409"
atmos.weather_sky_colour[13] = "#8b8b8b"
atmos.weather_sky_colour[14] = "#000409"
atmos.weather_sky_colour[15] = "#000000"

atmos.weather_sky_type[1] = "regular"
atmos.weather_sky_type[2] = "regular"
atmos.weather_sky_type[3] = "regular"
atmos.weather_sky_type[4] = "regular"
atmos.weather_sky_type[5] = "plain"
atmos.weather_sky_type[6] = "plain"
atmos.weather_sky_type[7] = "plain"
atmos.weather_sky_type[8] = "plain"
atmos.weather_sky_type[9] = "plain"
atmos.weather_sky_type[10] = "plain"
atmos.weather_sky_type[11] = "plain"
atmos.weather_sky_type[12] = "plain"
atmos.weather_sky_type[13] = "plain"
atmos.weather_sky_type[14] = "plain"
atmos.weather_sky_type[15] = "plain"

atmos.weather_light_level[1] = nil
atmos.weather_light_level[2] = nil
atmos.weather_light_level[3] = nil
atmos.weather_light_level[4] = nil
atmos.weather_light_level[5] = 0.8
atmos.weather_light_level[6] = 0.175
atmos.weather_light_level[7] = 0.775
atmos.weather_light_level[8] = 0.175
atmos.weather_light_level[9] = 0.6
atmos.weather_light_level[10] = 0.175
atmos.weather_light_level[11] = 0.6
atmos.weather_light_level[12] = 0.175
atmos.weather_light_level[13] = 0.775
atmos.weather_light_level[14] = 0.175
atmos.weather_light_level[15] = 0.075

-- cloud settings

atmos.weather_clouds[1] = 0
atmos.weather_clouds[2] = 0.275
atmos.weather_clouds[3] = 0.4
atmos.weather_clouds[4] = 0.5
atmos.weather_clouds[5] = 0.65
atmos.weather_clouds[6] = 0.65
atmos.weather_clouds[7] = 0.65
atmos.weather_clouds[8] = 0.65
atmos.weather_clouds[9] = 0.65
atmos.weather_clouds[10] = 0.65
atmos.weather_clouds[11] = 0.65
atmos.weather_clouds[12] = 0.65
atmos.weather_clouds[13] = 0.65
atmos.weather_clouds[14] = 0.65

atmos.weather_cloud_colour[1] = "#f0f0f0e5"
atmos.weather_cloud_colour[2] = "#f0f0f055"
atmos.weather_cloud_colour[3] = "#f0f0f0e5"
atmos.weather_cloud_colour[4] = "#f0f0f0f5"
atmos.weather_cloud_colour[5] = "#9b9b9bff"
atmos.weather_cloud_colour[6] = "#797979ff"
atmos.weather_cloud_colour[7] = "#93a2b3ff"
atmos.weather_cloud_colour[8] = "#6b6b6bff"
atmos.weather_cloud_colour[9] = "#4d5968ff"
atmos.weather_cloud_colour[10] = "#6b6b6bff"
atmos.weather_cloud_colour[11] = "#4d5968ff"
atmos.weather_cloud_colour[12] = "#6b6b6bff"
atmos.weather_cloud_colour[13] = "#93a2b3ff"
atmos.weather_cloud_colour[14] = "#6b6b6bff"

atmos.weather_cloud_thicc[1] = 0
atmos.weather_cloud_thicc[2] = 8
atmos.weather_cloud_thicc[3] = 16
atmos.weather_cloud_thicc[4] = 32
atmos.weather_cloud_thicc[5] = 32
atmos.weather_cloud_thicc[6] = 32
atmos.weather_cloud_thicc[7] = 96/2
atmos.weather_cloud_thicc[8] = 96/2
atmos.weather_cloud_thicc[9] = 64
atmos.weather_cloud_thicc[10] = 64
atmos.weather_cloud_thicc[11] = 64
atmos.weather_cloud_thicc[12] = 64
atmos.weather_cloud_thicc[13] = 96/2
atmos.weather_cloud_thicc[14] = 96/2

atmos.weather_cloud_height[1] = 120
atmos.weather_cloud_height[2] = 180
atmos.weather_cloud_height[3] = 120
atmos.weather_cloud_height[4] = 100
atmos.weather_cloud_height[5] = 110
atmos.weather_cloud_height[6] = 110
atmos.weather_cloud_height[7] = 105
atmos.weather_cloud_height[8] = 105
atmos.weather_cloud_height[9] = 130
atmos.weather_cloud_height[10] = 130
atmos.weather_cloud_height[11] = 130
atmos.weather_cloud_height[12] = 130
atmos.weather_cloud_height[13] = 115
atmos.weather_cloud_height[14] = 115

	-- 1 = clear, no clouds /
	-- 2 = clear, some clouds /
	-- 3 = clear, default settings /
	-- 4 = clear, almost cloudy /
	-- 5 = cloudy /
	-- 6 = cloudy at night
	-- 7 = rainy /
	-- 8 = rainy at night
	-- 9 = thunderstorm /
	-- 10 = thunderstorm at night
	-- 11 = hailstorm /
	-- 12 = hailstorm at night
	-- 13 = snowing /
	-- 14 = snowing at night

function atmos.set_skybox(player)

	local skybox = atmos.get_weather_skybox()

	player:set_sky(atmos.weather_sky_colour[skybox], atmos.weather_sky_type[skybox], true)
		
	player:set_clouds({
		
		density = atmos.weather_clouds[skybox],
		color = atmos.weather_cloud_colour[skybox],
		thickness = atmos.weather_cloud_thicc[skybox],
		height = atmos.weather_cloud_height[skybox],
		
	})
		
	player:override_day_night_ratio(atmos.weather_light_level[skybox])
	
end


function atmos.sync_skybox()

	-- sync skyboxes to all players connected to the server.

	for _, player in ipairs(minetest.get_connected_players()) do
	
		-- do not sync the current weather to players under -32 depth.
	
		if player:get_pos().y <= -32 then
		
			player:set_sky(atmos.weather_sky_colour[15], atmos.weather_sky_type[15], false)
		
			player:set_clouds({
		
				density = atmos.weather_clouds[1],
				color = atmos.weather_cloud_colour[1],
				thickness = atmos.weather_cloud_thicc[1],
				height = atmos.weather_cloud_height[1],
		
			})
		
			player:override_day_night_ratio(atmos.weather_light_level[15])
		
		else
		
			-- sync weather to players that are above -32, lightning effects (and flashes) only affects players above -16
		
			atmos.set_skybox(player)
		
		end
	
	end
	
	minetest.after(1, atmos.sync_skybox)
end

-- table of weathers; even numbers above 5 are night time version (but not this table)

-- 1 = cloudless (uses default dynamic skybox)
-- 2 = some clouds (uses default dynamic skybox)
-- 3 = default (uses default dynamic skybox)
-- 4 = somewhat cloudy, not overcast enough (uses default dynamic skybox)
-- 5 = cloudy, overcast? (5 and 6)
-- 6 = raining (and snow in colder areas) (7 and 8)
-- 7 = thunderstorm (9 and 10)
-- 8 = snowing in all biomes exc. the desert (13 and 14 on the atmos.weather_type chart)
-- 9 = hailstorm (11 and 12)

function atmos.get_weather_skybox()
	
	-- let's get the skybox we want depending on the time and day, as well as the current weather
	
	local ctime = minetest.get_timeofday()
	
	if atmos.current_weather == 1 then
	
		return 1
		
	elseif atmos.current_weather == 2 then
	
		return 2
		
	elseif atmos.current_weather == 3 then
	
		return 3

	elseif atmos.current_weather == 4 then
	
		return 4
		
	elseif atmos.current_weather == 5 then
	
		if ctime >= 0.22 and ctime <= 0.77 then
		
			return 5
			
		else
		
			return 6
		
		end
		
	elseif atmos.current_weather == 6 then
	
		if ctime >= 0.22 and ctime <= 0.77 then
		
			return 7
		
		else
		
			return 8
			
		end
		
	elseif atmos.current_weather == 7 then
	
		if ctime >= 0.22 and ctime <= 0.77 then
		
			return 9
			
		else
		
			return 10
		
		end
	
	elseif atmos.current_weather == 9 then
	
		if ctime >= 0.22 and ctime <= 0.77 then
		
			return 11
			
		else
		
			return 12
			
		end
	
	elseif atmos.current_weather == 8 then
	
		if ctime >= 0.22 and ctime <= 0.77 then
		
			return 13
			
		else
		
			return 14
			
		end
	
	end

end

function atmos.weatherchange()	

	local rand = math.random(-1, 1)
	
	if rand == 0 then rand = -1 end

	if atmos.current_weather == 6 or atmos.current_weather == 7 or atmos.current_weather == 8 or atmos.current_weather == 9 and math.random(1,5) < 5 then
	
		atmos.current_weather = 5
	
	elseif atmos.current_weather + rand == 6 and atmos.current_weather == 5 then
		
		if hudclock.month == 1 or hudclock.month == 11 or hudclock.month == 12 then --is it winter months?
		
			if math.random(1,8) == 1 then --hail
			
				atmos.current_weather = 9
			
			elseif math.random(1,3) == 1 then --snow in cool and cold areas
			
				atmos.current_weather = 8
				
			end
		
		elseif hudclock.month == 5 or hudclock.month == 6 or hudclock.month == 7 then --is it summer?
		
			if math.random(1,7) == 1 then -- thunder + rain
	
				atmos.current_weather = 7
			
			elseif math.random(1,3) == 1 then -- rain
			
				atmos.current_weather = 6
				
			end
		
		else -- other seasons just have rain.
		
			if math.random(1,3) == 1 then -- we rain, else if it's not the winter months, or summer thunder
			
				atmos.current_weather = 6
			
			end
		
		end
	
	elseif atmos.current_weather < 5 then

		atmos.current_weather = atmos.current_weather + rand
		
		if atmos.current_weather == 0 then
	
			atmos.current_weather = 1

		end
	
	end	
	
	minetest.after(60+math.random(1,59)*math.random(1,5), atmos.weatherchange)
end

function atmos.thunderstrike()
	
	if atmos.get_weather_skybox() == 9 or atmos.get_weather_skybox() == 10 then
		
		--lightning.weather_type = atmos.weather_type
		
		-- doing the above doesn't seem to work, so i'll ignore it for now.
		
		lightning.strike()
		
	end
	
	minetest.after(math.random(43, 156), atmos.thunderstrike)
	
end

minetest.after(1, atmos.sync_skybox)
minetest.after(60+math.random(1,59)*math.random(1,5), atmos.weatherchange)
minetest.after(math.random(43, 156), atmos.thunderstrike)

lightning.light_level = atmos.weather_light_level

-- abm to remove fires when it's raining, snowing or hailing?