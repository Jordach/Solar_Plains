-- hudinfo, this mod is part of solar plains and (technically is an extension to hudclock) is a requirement; sorry kids

hudinfo = {} -- namespaces;

hudinfo.player_data = {}

-- paramat's snowdrif to get mapgen heat and humidity since get_heat() doesn't work?

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

local nobj_temp = nil
local nobj_humid = nil
local nobj_prec = nil

local function player_env_data(player)

	local pos = player:get_pos()
	
	-- figure out world layers and give that information to the player.
	
	local locale, icon
	
	if pos.y < -16000 then
	
		locale = "Eterra Deep Core,"
		
		icon = "hudinfo_eterra_deep_core.png"
	
	elseif pos.y >= -16000 and pos.y < -32  then
	
		locale = "Eterra Underground,"
		
		icon = "hudinfo_eterra_underground.png"
		
	elseif pos.y >= -32 and pos.y < 10000 then
	
		locale = "Eterra Surface,"
		
		icon = "hudinfo_eterra_surface.png"
	
	elseif pos.y >= 10000 and pos.y < 26000 then
	
		locale = "Eterra Orbit,"
		
		icon = "hudinfo_eterra_orbit.png"
		
	elseif pos.y >= 26000 and pos.y < 28000 then
	
		locale = "Arkhos Asteroid Fields,"
		
		icon = "hudinfo_arkhos_asteroids.png"
	
	elseif pos.y >= 28000 and pos.y < 30000 then
	
		locale = "Z12X!C34VB5'6NM7&&8QASW%E^^DFR)TGH(YUJKIO_+LP?,"
		
		icon = "hudinfo_unknown.png"
		
	elseif pos.y >= 30000 then
	
		locale = "Aetherus."
		
		icon = "hudinfo_aetherus.png"
	
	end
	
	-- let's get a temparature reading for the local area.
	
	--[[
	
		some notes on temparature scaling in Solar Plains:
		
		temparature grading goes from 10 (-20C) to 75 (45C) 50 sits at a cool 20C
		
		humidity modifies the actual "feel" of the temparature.
		
		20 + (50 * 0.02) = 21
	
	]]--
	
	local pposx = math.floor(pos.x)
	local pposz = math.floor(pos.z)
	
	local nobj_temp = nobj_temp or minetest.get_perlin(np_temp)
	local nobj_humid = nobj_humid or minetest.get_perlin(np_humid)

	local nval_temp = nobj_temp:get2d({x = pposx, y = pposz})
	local nval_humid = nobj_humid:get2d({x = pposx, y = pposz})
	
	local latch = false
	
	if nval_temp <= 40.5 then
	
		latch = true
	
	end
	
	nval_temp = ((nval_temp / 2) - 10) + (nval_humid * 0.02)
	
	if pos.y >= 10000 then
	
		nval_temp = -271
		
		nval_humid = 0
		
	end
	
	-- let's understand the current weather from atmos:
	
	local weather_str, weather_icon
	
	local atmw = atmos.current_weather
	
	if atmw == 1 then
		weather_str = "Clear,"
	elseif atmw == 2 then
		weather_str = "Light Clouds,"
	elseif atmw == 3 then
		weather_str = "Minor Clouds,"
	elseif atmw == 4 then
		weather_str = "Medium Clouds,"
	elseif atmw == 5 then
		weather_str = "Cloudy,"
	elseif latch and atmw == 6 then
		weather_str = "Snowfall,"
	elseif atmw == 6 then
		weather_str = "Downpour,"
	elseif atmw == 7 then
		weather_str = "Thunderstorm,"
	elseif atmw == 8 then
		weather_str = "Snowfall,"
	elseif atmw == 9 then
		weather_str = "Hailstorm,"
	end
	
	return locale, nval_temp, nval_humid, weather_str
	
end

local function update_huds()
	
	for _,player in ipairs(minetest.get_connected_players()) do
	
		local name = player:get_player_name()
		
		local locale, temparature, humid, weather_str = player_env_data(player)
		
		player:hud_change(hudinfo.player_data[name].temp, "text", tonumber(string.format("%.1f", temparature)) .. " C,")
		player:hud_change(hudinfo.player_data[name].humid, "text", tonumber(string.format("%.1f", humid)) .. "% RH.")
		player:hud_change(hudinfo.player_data[name].locale, "text", locale)
		player:hud_change(hudinfo.player_data[name].weather_str, "text", weather_str)
		
	end
	
	minetest.after(1, update_huds)
	
end

function hudinfo.display_hud_text(player)

	if player:get_attribute("core_display_hud") == "true" then
		
		local locale, temparature, humid, weather_str = player_env_data(player)
		
		local name = player:get_player_name()
		
		hudinfo.player_data[name] = {}
		
		local temp = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = tonumber(string.format("%.1f", temparature)) .. "C,",
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=50},
		})
		
		local hum = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = tonumber(string.format("%.1f", humid)) .. "% Humidity",
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=70},
		})
		
		local loc = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = locale,
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=10},
		})
		
		local wea_str = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = weather_str,
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=30},			
		})
	
		hudinfo.player_data[name]["temp"] = temp
		hudinfo.player_data[name]["humid"] = hum
		hudinfo.player_data[name]["locale"] = loc
		hudinfo.player_data[name]["weather_str"] = wea_str
		
	end

end

minetest.after(1, update_huds)