-- Parameters

local YLIMIT = 0 -- Set to world's water level or level of lowest open area,
				-- calculations are disabled below this y.

local GSCYCLE = 0.5 -- Globalstep cycle (seconds)
local FLAKES = 32 -- Snowflakes per cycle
local DROPS = 96 -- Raindrops per cycle
local RAINGAIN = 0.12 -- Rain sound volume
local COLLIDE = true -- Whether particles collide with nodes

-- Globalstep function

local handles = {}
local timer = 0

minetest.register_globalstep(function(dtime)
	timer = timer + dtime
	if timer < GSCYCLE then
		return
	end

	timer = 0

	for _, player in ipairs(minetest.get_connected_players()) do

		local player_name = player:get_player_name()
		local heat, humid, latch = mcore.get_heat_humidity(player)
		local ppos = player:get_pos()
		local pposy = math.floor(ppos.y) + 2 -- Precipitation when swimming
		
		if pposy >= YLIMIT then
			
			local precip = false
			
			local freeze = false
			
			local hail = false
			
			if atmos.current_weather == 6 and heat <= 4 then
			
				precip = true
				
				freeze = true
			
				hail = false
			
			elseif atmos.current_weather == 6 or atmos.current_weather == 7 then
				
				if humid > 5 and heat < 35 then
				
					precip = true
				
					freeze = false
				
					hail = false
				
				end
				
			elseif atmos.current_weather == 9 and humid > 5 and heat < 1 then
			
				precip = true
				
				freeze = false
				
				hail = true
			
			elseif atmos.current_weather == 8 and humid > 5 and heat < 4 then
				
				precip = true
				
				freeze = true
				
				hail = false
				
			else
			
				precip = false
				
				freeze = false
				
				hail = false
			
			end
			
			-- Check if player is outside
			local outside = minetest.get_node_light(ppos, 0.5) == 15

			if not precip or not outside or freeze then
				if handles[player_name] then
					-- Stop sound if playing
					minetest.sound_stop(handles[player_name])
					handles[player_name] = nil
				end
			end

			if precip and outside then
				-- Precipitation
				if freeze then
					-- Snowfall
					for flake = 1, FLAKES do
						minetest.add_particle({
							pos = {
								x = ppos.x - 24 + math.random(0, 47),
								y = ppos.y + 8 + math.random(0, 1),
								z = ppos.z - 20 + math.random(0, 47)
							},
							vel = {
								x = 0.0,
								y = -2.0,
								z = -1.0
							},
							acc = {x = 0, y = 0, z = 0},
							expirationtime = 8.5,
							size = 2.8,
							collisiondetection = COLLIDE,
							collision_removal = true,
							vertical = false,
							texture = "snowdrift_snowflake" .. math.random(1, 4) .. ".png",
							playername = player:get_player_name()
						})
					end
				
				elseif hail then
				
					for flake = 1, DROPS-48 do
						minetest.add_particle({
							pos = {
								x = ppos.x - 8 + math.random(0, 16),
								y = ppos.y + 8 + math.random(0, 5),
								z = ppos.z - 8 + math.random(0, 16)
							},
							vel = {
								x = 0.0,
								y = -15.0,
								z = 0.0
							},
							acc = {x = 0, y = 0, z = 0},
							expirationtime = 2.1,
							size = 2.8,
							collisiondetection = COLLIDE,
							collision_removal = true,
							vertical = true,
							texture = "snowdrift_hailstone.png",
							playername = player:get_player_name()
						})
					end
				
				else
					-- Rainfall
					for flake = 1, DROPS do
						minetest.add_particle({
							pos = {
								x = ppos.x - 8 + math.random(0, 16),
								y = ppos.y + 8 + math.random(0, 5),
								z = ppos.z - 8 + math.random(0, 16)
							},
							vel = {
								x = 0.0,
								y = -10.0,
								z = 0.0
							},
							acc = {x = 0, y = 0, z = 0},
							expirationtime = 2.1,
							size = 2.8,
							collisiondetection = COLLIDE,
							collision_removal = true,
							vertical = true,
							texture = "snowdrift_raindrop.png",
							playername = player:get_player_name()
						})
					end

					if not handles[player_name] then
						-- Start sound if not playing
						local handle = minetest.sound_play(
							"snowdrift_rain",
							{
								to_player = player_name,
								gain = RAINGAIN,
								loop = true,
							}
						)
						if handle then
							handles[player_name] = handle
						end
					end
				end
			end
		elseif handles[player_name] then
			-- Stop sound when player goes under y limit
			minetest.sound_stop(handles[player_name])
			handles[player_name] = nil
		end
	end
end)


-- Stop sound and remove player handle on leaveplayer

minetest.register_on_leaveplayer(function(player)
	local player_name = player:get_player_name()
	if handles[player_name] then
		minetest.sound_stop(handles[player_name])
		handles[player_name] = nil
	end
end)
