-- hudinfo, this mod is part of solar plains and (technically is an extension to hudclock) is a requirement; sorry kids

hudinfo = {} -- namespaces;

hudinfo.player_data = {}

function hudinfo.player_env_data(player)

	local pos = player:get_pos()
	
	-- figure out world layers and give that information to the player.
	
	local locale, icon
	
	if pos.y < -16000 then
	
		locale = "Eterra Deep Core,"
	
	elseif pos.y >= -16000 and pos.y < -32  then
	
		locale = "Eterra Underground,"
		
	elseif pos.y >= -32 and pos.y < 10000 then
	
		locale = "Eterra Surface,"
	
	elseif pos.y >= 12000 and pos.y < 26000 then
	
		locale = "Eterra Orbit,"
		
	elseif pos.y >= 26000 and pos.y < 28000 then
	
		locale = "Arkhos Asteroid Fields,"
	
	elseif pos.y >= 28000 and pos.y < 30000 then
	
		locale = "Z12X!C34VB5'6NM7&&8QASW%E^^DFR)TGH(YUJKIO_+LP?,"
		
	elseif pos.y >= 30000 then
	
		locale = "Aetherus."
	
	end

	local heat, temp, latch = mcore.get_heat_humidity(player)
	
	-- let's understand the current weather from atmos:
	
	local weather_str = ""
	
	local atmw = atmos.get_weather(pos)
	
	if atmw == "clear" then
		weather_str = "Clear,"
	elseif atmw == "light_cloud" then
		weather_str = "Light Clouds,"
	elseif atmw == "medium_cloud" then
		weather_str = "Minor Clouds,"
	elseif atmw == "large_cloud" then
		weather_str = "Medium Clouds,"
	elseif atmw == "cloudy" then
		weather_str = "Cloudy,"
	elseif atmw == "snow" then
		weather_str = "Snowfall,"
	elseif atmw == "rain" then
		weather_str = "Downpour,"
	elseif atmw == "storm" then
		weather_str = "Thunderstorm,"
	elseif atmw == "snow" then
		weather_str = "Snowfall,"
	elseif atmw == "hail" then
		weather_str = "Hailstorm,"
	end

	return locale, heat, temp, weather_str
	
end

local function update_huds()
	
	for _,player in ipairs(minetest.get_connected_players()) do
	
		local name = player:get_player_name()
		
		local locale, temparature, humid, weather_str = hudinfo.player_env_data(player)
		
		if hudinfo.player_data[name] == nil then
			--fail
		else
		
			player:hud_change(hudinfo.player_data[name].temp, "text", tonumber(string.format("%.1f", temparature)) .. " C,")
			player:hud_change(hudinfo.player_data[name].humid, "text", tonumber(string.format("%.1f", humid)) .. "% RH.")
			player:hud_change(hudinfo.player_data[name].locale, "text", locale)
			player:hud_change(hudinfo.player_data[name].weather_str, "text", weather_str)
			
		end
		
	end
	
	minetest.after(1, update_huds)
	
end

function hudinfo.display_hud_text(player)

	if player:get_attribute("core_display_hud") == "true" then
		
		local locale, temparature, humid, weather_str = hudinfo.player_env_data(player)
		
		local name = player:get_player_name()
		
		hudinfo.player_data[name] = {}
		
		local temp = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = tonumber(string.format("%.1f", temparature)) .. " C,",
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=50},
		})
		
		local hum = player:hud_add({
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = tonumber(string.format("%.1f", humid)) .. "% RH.",
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

update_huds()