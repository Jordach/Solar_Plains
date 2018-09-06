-- atmos, control of skies, weather, and various other visual tasks

atmos = {}

minetest.register_chatcommand("weather", {
	
	description = "debugs the current atmos based weather system",
	param = "use a number to select the weather type.",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to control the weather, you scrub. \n \n This incident WILL be reported."
		end
		
		atmos.current_weather = 0 + param
		
		--local player = minetest.get_player_by_name(name)

		--player:set_sky("#000000", "skybox", {"core_glass.png", "core_glass.png", "core_glass.png", "core_glass.png", "core_glass.png", "core_glass.png"}, false, true)
		
		--player:override_day_night_ratio(0)
		
		--atmos.set_skybox(player)
		
		return true, "Current weather updated."
	end,

})

-- 

--atmos.weather_type = 1
atmos.current_weather = 3

--[[

atmos.fog_colour = {}
atmos.weather_sky_type = {}
atmos.weather_light_level = {}

atmos.weather_clouds = {}
atmos.weather_cloud_colour = {}
atmos.weather_cloud_thicc = {}
atmos.weather_cloud_height = {}



atmos.weather_light_level[1] = nil -- default skies
atmos.weather_light_level[5] = 0.8 -- cloudy
atmos.weather_light_level[8] = 0.175 -- rain, night

-- cloud settings

atmos.weather_clouds[1] = 0.275 -- light
atmos.weather_clouds[2] = 0.4 -- default
atmos.weather_clouds[3] = 0.5 -- large
atmos.weather_clouds[4] = 0.65 -- rain, snow, thunder

atmos.weather_cloud_colour[1] = "#f0f0f0e5" -- default
atmos.weather_cloud_colour[2] = "#9b9b9bff" -- cloudy
atmos.weather_cloud_colour[3] = "#797979ff" -- cloudy, night
atmos.weather_cloud_colour[4] = "#93a2b3ff" -- rain
atmos.weather_cloud_colour[5] = "#6b6b6bff" -- rain, night

atmos.weather_cloud_thicc[1] = 8 -- thin
atmos.weather_cloud_thicc[2] = 16 -- default
atmos.weather_cloud_thicc[3] = 32 -- large
atmos.weather_cloud_thicc[4] = 96/2 -- rain

atmos.weather_cloud_height[1] = 120 -- default
atmos.weather_cloud_height[2] = 110 -- rain, snow, thunder

]]--

-- load data into atmos2 from .atm configuration files:

local atmos_clear_weather = {}
local atmos_cloudy_weather = {}

local storage = minetest.get_modpath("atmos").."/skybox/"
local val = 0

for line in io.lines(storage.."skybox_clear_gradient.atm") do

	atmos_clear_weather[val] = minetest.deserialize(line) 

	val = val + 1

end

val = 0 

-- load data for cloudy / rainy / hail environments:

for line in io.lines(storage.."skybox_cloud_gradient.atm") do



end

local function atmos_ratio(current, next, ctime2)

	if current < next then -- check if we're darker than the next skybox frame

		local ratio = (next - current) * ctime2
		return (current + ratio)
	
	else -- we darken instead, this repeats for the next two if, else statements

		local ratio = (current - next) * ctime2
		return (current - ratio)
	
	end	

end

function atmos.set_skybox_clear(player, weather_fade)

	local ctime = minetest.get_timeofday() * 100

	-- figure out our multiplier since get_timeofday returns 0->1, we can use the sig figs as a 0-100 percentage multiplier

	-- contributed by @rubenwardy

	local ctime2 = math.floor((ctime - math.floor(ctime)) * 100) / 100

	if ctime2 == 0 then ctime2 = 0.01 end -- anti sudden skybox change syndrome

	local fade_factor =  math.floor(255 * ctime2)
	
	ctime = math.floor(ctime) -- remove the sig figs, since we're accessing table points

	-- assemble the skyboxes to fade neatly

	local side_string_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime].bottom .. ")^" .. "(atmos_sky_top.png^[multiply:" .. atmos_clear_weather[ctime].top .. ")"
	local side_string_new_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime+1].bottom .. ")^" .. "(atmos_sky_top.png^[multiply:" .. atmos_clear_weather[ctime+1].top .. ")"

	local sky_top_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime].bottom .. ")^(atmos_sky_top_radial.png^[multiply:".. atmos_clear_weather[ctime].top .. ")"
	local sky_top_new_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime+1].bottom .. ")^(atmos_sky_top_radial.png^[multiply:".. atmos_clear_weather[ctime+1].top .. ")"

	local sky_bottom_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime].bottom .. ")"
	local sky_bottom_new_clear = "(atmos_sky.png^[multiply:".. atmos_clear_weather[ctime+1].bottom .. ")"

	-- let's convert the base colour to convert it into our transitioning fog colour:

	local fog = {}

	fog.current = {} -- we need two tables for comparing, as any matching pairs of hex will be skipped.
	fog.next = {}
	fog.result = {}

	fog.current.red = 0
	fog.current.grn = 0
	fog.current.blu = 0

	fog.next.red = 0
	fog.next.grn = 0
	fog.next.blu = 0

	fog.result.red = 0
	fog.result.grn = 0
	fog.result.blu = 0

	-- convert our hex into compatible minetest.rgba components:
	-- we need these to make our lives easier when it comes to uh, things.

	fog.current.red = tonumber("0x" .. atmos_clear_weather[ctime].base:sub(2,3))
	fog.current.grn = tonumber("0x" .. atmos_clear_weather[ctime].base:sub(4,5))
	fog.current.blu = tonumber("0x" .. atmos_clear_weather[ctime].base:sub(6,7))

	fog.next.red = tonumber("0x" .. atmos_clear_weather[ctime+1].base:sub(2,3))
	fog.next.grn = tonumber("0x" .. atmos_clear_weather[ctime+1].base:sub(4,5))
	fog.next.blu = tonumber("0x" .. atmos_clear_weather[ctime+1].base:sub(6,7))

	if atmos_clear_weather[ctime].base ~= atmos_clear_weather[ctime+1].base then

		-- we compare colours the same way we do it for the light level

		fog.result.red = atmos_ratio(fog.current.red, fog.next.red, ctime2)
		fog.result.grn = atmos_ratio(fog.current.grn, fog.next.grn, ctime2)
		fog.result.blu = atmos_ratio(fog.current.blu, fog.next.blu, ctime2)

	else

		fog.result.red = fog.current.red
		fog.result.grn = fog.current.grn
		fog.result.blu = fog.current.blu

	end

	if atmos_clear_weather[ctime].bottom == atmos_clear_weather[ctime+1].bottom then -- prevent more leakage
		if atmos_clear_weather[ctime].top == atmos_clear_weather[ctime+1].top then
			fade_factor = 0
		end
	end
	
	player:set_sky(minetest.rgba(fog.result.red, fog.result.grn, fog.result.blu), "skybox", {
		
		sky_top_clear .. "^(" .. sky_top_new_clear .. "^[opacity:" .. fade_factor .. ")",
		sky_bottom_clear .. "^(" .. sky_bottom_new_clear .. "^[opacity:" .. fade_factor .. ")",

		side_string_clear .. "^(" .. side_string_new_clear .. "^[opacity:" .. fade_factor .. ")",
		side_string_clear .. "^(" .. side_string_new_clear .. "^[opacity:" .. fade_factor .. ")",
		side_string_clear .. "^(" .. side_string_new_clear .. "^[opacity:" .. fade_factor .. ")",
		side_string_clear .. "^(" .. side_string_new_clear .. "^[opacity:" .. fade_factor .. ")"
		
	}, true)
	
	local light_ratio = 0
	local light_level = 0

	if atmos_clear_weather[ctime].light == atmos_clear_weather[ctime+1].light then -- we do nothing, because there's nothing worth doing
		
		light_level = atmos_clear_weather[ctime].light

	else -- we do the light to dark fade 

		light_level = atmos_ratio(atmos_clear_weather[ctime].light, atmos_clear_weather[ctime+1].light, ctime2)
		
	end

	if light_level > 1 then light_level = 1 end -- sanity checks, going over 1 makes it dark again
	if light_level < 0 then light_level = 0 end -- going under 0 makes it bright again

	player:override_day_night_ratio(light_level)
	
end

local atmos_crossfade = 0
local atmos_start_fade = false

function atmos.sync_skybox()



	-- sync skyboxes to all players connected to the server.

	for _, player in ipairs(minetest.get_connected_players()) do
		
		if atmos_start_fade then
			atmos_crossfade = atmos_crossfade + 1
		end

		-- do not sync the current weather to players under -32 depth.
	
		if player:get_pos().y <= -32 then
		
			player:set_sky("#000000", "plain", false)

			player:override_day_night_ratio(0)
		
		elseif player:get_pos().y > 10000 then

			-- change to low orbit skybox here

		else
		
			-- sync weather to players that are above -32, lightning effects (and flashes) only affects players above -16
		
			--atmos.set_skybox(player)
			
			-- move clouds here to enable realtime cloud changes

		
			player:set_clouds({
		
				density = 0.4,
				color = "#fff0f0e5",
				thickness = 16,
				height = 210,
			
			})
		
		end
	
	end

	if atmos_crossfade == 20 then
		atmos_crossfade = 0
		atmos_start_fade = false
	end
	
	minetest.after(0.1, atmos.sync_skybox)
end

-- table of weathers; even numbers above 5 are night time version (but not this table)

-- 1 = cloudless (uses default dynamic skybox)
-- 2 = some clouds (uses default dynamic skybox)
-- 3 = default (uses default dynamic skybox)
-- 4 = somewhat cloudy, not overcast enough (uses default dynamic skybox)
-- 5 = cloudy, overcast?
-- 6 = raining (and snow in colder areas)
-- 7 = thunderstorm
-- 8 = snowing in all biomes exc. the desert
-- 9 = hailstorm



function atmos.weatherchange()	

	local rand = math.random(0, 1)
	
	if rand == 0 then rand = -1 end

	local cw = atmos.current_weather

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
	
	minetest.after(60+math.random(1,59)*math.random(5,15), atmos.weatherchange)
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
--minetest.after(60+math.random(1,59)*math.random(5,15), atmos.weatherchange)
--minetest.after(math.random(43, 156), atmos.thunderstrike)

lightning.light_level = atmos.weather_light_level

-- abm to remove fires when it's raining, snowing or hailing?

-- logic to support taking damage when either too cold or too hot

hb.register_hudbar("overheat",
	0xFFFFFF,
	"Overheat",
	{bar = "atmos_heatstroke_bar.png", icon = "atmos_heatstroke_icon.png", bgicon = "atmos_heatstroke_icon.png"},
	0,
	100,
	false
)
	
hb.register_hudbar("frostbite",
	0xFFFFFF,
	"Frostbite",
	{bar = "atmos_frostbite_bar.png", icon = "atmos_frostbite_icon.png", bgicon = "atmos_frostbite_icon.png"},
	0,
	100,
	false
)

minetest.register_on_joinplayer(function(player)
	
	hb.init_hudbar(player, "overheat")
	hb.init_hudbar(player, "frostbite")
	
	local meta = player:get_meta()

	if meta:get_int("overheat") == "" then

		meta:set_int("overheat", 0)

	end

	if meta:get_int("frostbite") == "" then

		meta:set_int("frostbite", 0)

	end
	
	local frosty = meta:get_int("frostbite")
	local toasty = meta:get_int("overheat")

	hb.change_hudbar(player, "overheat", toasty)
	hb.change_hudbar(player, "frostbite", frosty)	

end)


local function local_area_stamina()

	for _, player in ipairs(minetest.get_connected_players()) do

		if player:is_player() == false then --uh skip? in case of we dont have players active, eg starting a server
		
		else

		
			local heat, humid, latch = mcore.get_heat_humidity(player)

			-- if the local temp is more than -15 C then decrement frostbite every now and then, if the heatstroke bar is not at 100,
			-- then start replenishing it
			-- if the local temp is less than +35 C then decrement heatstroke every now and then, if the frostbite bar is not at 100,
			-- then start replenishing it
			-- if not under or over those values, slowly restore the bar to 0. 
			-- environmental timer is 15 seconds
			
			local meta = player:get_meta()
			
			local frosty = meta:get_int("frostbite") -- nice combo into uppercut, just wait for the kahn.
			local toasty = meta:get_int("overheat")

			if heat < -15 then -- do frostbite bar 

				if toasty > 0 then
				
					meta:set_int("overheat", toasty - 1)

				else

					meta:set_int("frostbite", frosty + 1)

				end

			elseif heat > 35 then -- do the overheat bar

				if frosty > 0 then

					meta:set_int("frostbite", frosty - 1)

				else

					meta:set_int("overheat", toasty + 1)

				end

			else -- otherwise, let's cool off and remove frostbite

				frosty = meta:get_int("frostbite")
				toasty = meta:get_int("overheat")

				frosty = frosty - 1
				toasty = toasty - 1

				if toasty > 100 then toasty = 100 end
				if toasty < 0 then toasty = 0 end

				if frosty > 100 then frosty = 100 end
				if frosty < 0 then frosty = 0 end

				meta:set_int("overheat", toasty)
				meta:set_int("frostbite", frosty)

			end

			frosty = meta:get_int("frostbite")
			toasty = meta:get_int("overheat")

			hb.change_hudbar(player, "overheat", toasty) -- deal with our hudbars
			hb.change_hudbar(player, "frostbite", frosty)

			if frosty > 94 then -- we do damage in this order because while 94 is higher than 79, the 15hp would never activate.

				player:set_hp(player:get_hp() - 15, "atmos_frostbite")

			elseif frosty > 89 then

				player:set_hp(player:get_hp() - 5, "atmos_frostbite")

			elseif frosty > 79 then

				player:set_hp(player:get_hp() - 2, "atmos_frostbite") -- do 1 hearts worth of damage

			end

			if toasty > 94 then -- read the above comment on L634

				player:set_hp(player:get_hp() - 15, "atmos_overheat")

			elseif toasty > 89 then

				player:set_hp(player:get_hp() - 5, "atmos_overheat")

			elseif toasty > 79 then

				player:set_hp(player:get_hp() - 2, "atmos_overheat")

			end
		
		end

	end

	minetest.after(math.random(5, 15), local_area_stamina) -- restart the loop at a random time to simulate reality. (not really)

end

local_area_stamina()

minetest.register_chatcommand("frosty", { -- admin commands to debug the values for testing
	
	description = "debugs the current frostbite level",
	param = "use 0-100 to set frostbite level.",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to be more or less frosty, you scrub. \n \n This incident WILL be reported."
		end
		
		local player = minetest.get_player_by_name(name)

		player:get_meta():set_int("frostbite", tonumber(param))

		hb.change_hudbar(player, "frostbite", tonumber(param))
		
		return true, "Current frostbite levels updated."
	end,

})

minetest.register_chatcommand("toasty", {
	
	description = "debugs the current overheat level",
	param = "use 0-100 to set overheat level.",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to be more or less toasty, you scrub. \n \n This incident WILL be reported."
		end
		
		local player = minetest.get_player_by_name(name)

		player:get_meta():set_int("overheat", tonumber(param))

		hb.change_hudbar(player, "overheat", tonumber(param))
		
		return true, "Current overheat levels updated."
	end,

})

-- handle dying so that values are set to 1/4 of what they were when the player dies

minetest.register_on_dieplayer(function(player)

	local meta = player:get_meta()

	local frosty = meta:get_int("frostbite")
	local toasty = meta:get_int("overheat")

	meta:set_int("overheat", math.floor(toasty / 4))
	meta:set_int("frostbite", math.floor(frosty / 4))

end)