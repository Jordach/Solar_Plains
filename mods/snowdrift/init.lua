-- Parameters

local YLIMIT = 1 -- Set to world's water level or level of lowest open area,
				-- calculations are disabled below this y.
local PRECSPR = 6 -- Time scale for precipitation variation in minutes
local PRECOFF = -0.4 -- Precipitation offset, higher = rains more often
local GSCYCLE = 0.5 -- Globalstep cycle (seconds)
local FLAKES = 32 -- Snowflakes per cycle
local DROPS = 96 -- Raindrops per cycle
local RAINGAIN = 0.12 -- Rain sound volume
local COLLIDE = false -- Whether particles collide with nodes
local NISVAL = 39 -- Clouds RGB value at night
local DASVAL = 175 -- Clouds RGB value in daytime

local np_prec = {
	offset = 0,
	scale = 1,
	spread = {x = PRECSPR, y = PRECSPR, z = PRECSPR},
	seed = 813,
	octaves = 1,
	persist = 0,
	lacunarity = 2.0,
	--flags = ""
}

-- These 2 must match biome heat and humidity noise parameters for a world

local np_temp = {
	offset = 50,
	scale = 50,
	spread = {x = 1000, y = 1000, z = 1000},
	seed = 5349,
	octaves = 3,
	persist = 0.5,
	lacunarity = 2.0,
	--flags = ""
}

local np_humid = {
	offset = 50,
	scale = 50,
	spread = {x = 1000, y = 1000, z = 1000},
	seed = 842,
	octaves = 3,
	persist = 0.5,
	lacunarity = 2.0,
	--flags = ""
}


-- Stuff

local difsval = DASVAL - NISVAL
local grad = 14 / 95
local yint = 1496 / 95


-- Initialise noise objects to nil

local nobj_temp = nil
local nobj_humid = nil
local nobj_prec = nil


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
		local ppos = player:getpos()
		local pposy = math.floor(ppos.y) + 2 -- Precipitation when swimming
		if pposy >= YLIMIT then
			local pposx = math.floor(ppos.x)
			local pposz = math.floor(ppos.z)
			local ppos = {x = pposx, y = pposy, z = pposz}

			local nobj_temp = nobj_temp or minetest.get_perlin(np_temp)
			local nobj_humid = nobj_humid or minetest.get_perlin(np_humid)
			local nobj_prec = nobj_prec or minetest.get_perlin(np_prec)

			local nval_temp = nobj_temp:get2d({x = pposx, y = pposz})
			local nval_humid = nobj_humid:get2d({x = pposx, y = pposz})
			local nval_prec = nobj_prec:get2d({x = os.clock() / 60, y = 0})

			-- Biome system: Frozen biomes below heat 35,
			-- deserts below line 14 * t - 95 * h = -1496
			-- h = (14 * t + 1496) / 95
			-- h = 14/95 * t + 1496/95
			-- where 14/95 is gradient and 1496/95 is y intersection
			-- h - 14/95 t = 1496/95 y intersection
			-- so area above line is
			-- h - 14/95 t > 1496/95
			--local freeze = nval_temp < 35
			--local precip = nval_prec < (nval_humid - 50) / 50 + PRECOFF and
				--nval_humid - grad * nval_temp > yint
			
			-- solar plains biomes to rain in;
			
			--[[
			
				plains
				forests
				beach?
				
				min temp to rain
				
				40
				
				max temp to rain
				
				60
				
				max humidity to rain

				
			
			]]--
			
			local precip = false
			
			local freeze = false
			
			if atmos.current_weather == 6 or atmos.current_weather == 7 or atmos.current_weather == 8 or atmos.current_weather == 9 and nval_humid > 24 and nval_temp > 36 and nval_temp < 61 then
			
				precip = true
				
				freeze = false
				
			elseif atmos.current_weather == 9 and nval_temp < 37 then
			
				precip = true
				
				freeze = true
				
			else
			
				precip = false
				
				freeze = false
			
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
								x = pposx - 24 + math.random(0, 47),
								y = pposy + 8 + math.random(0, 1),
								z = pposz - 20 + math.random(0, 47)
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
				else
					-- Rainfall
					for flake = 1, DROPS do
						minetest.add_particle({
							pos = {
								x = pposx - 8 + math.random(0, 16),
								y = pposy + 8 + math.random(0, 5),
								z = pposz - 8 + math.random(0, 16)
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
