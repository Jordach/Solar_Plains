-- atmos, control of skies, weather, and various other visual tasks

atmos = {}

atmos.wind = {}
atmos.wind.rads = 0.5
atmos.wind.x = 0 -- result
atmos.wind.z = 0 -- result
atmos.wind.speed = 2 -- in nodes/meters per second

atmos.cloud = {}

atmos.cloud.density = {} -- overall cloud density
atmos.cloud.density.min = 0
atmos.cloud.density.max = 1
atmos.cloud.density.now = 0.59

atmos.cloud.thicc = {}
atmos.cloud.thicc.min = 1 -- thiccness in nodes
atmos.cloud.thicc.max = 64
atmos.cloud.thicc.now = 16

atmos.cloud.height= {} -- height in nodes from 0
atmos.cloud.height.min = 120
atmos.cloud.height.max = 320
atmos.cloud.height.now = 120

atmos.cloud.colour = {} -- minetest.rgba components for colourising clouds
atmos.cloud.colour.red = 250 -- these are the default colours, blend with the cloudy skybox colours
atmos.cloud.colour.grn = 250
atmos.cloud.colour.blu = 255

atmos.cloud.colour.alp = {} -- tune this when clouds get thiccer
atmos.cloud.colour.alp.min = 25
atmos.cloud.colour.alp.max = 229

function atmos.wind_to_vector(rads, mult)
	local z2 = math.cos(rads) * mult
	local x2 = (math.sin(rads) * -1) * mult
	return {x=x2, z=z2}
end

function atmos.get_weather(pos)
	local temp = mcore.get_heat_humidity_pos(pos)
	local result
	if atmos.cloud.density.now < 0.11 then
		result = "clear"
	elseif atmos.cloud.density.now >= 0.11 and atmos.cloud.density.now < 0.21 then
		result = "light_cloud"
	elseif atmos.cloud.density.now >= 0.21 and atmos.cloud.density.now < 0.36 then
		result = "medium_cloud"
	elseif atmos.cloud.density.now >= 0.36 and atmos.cloud.density.now < 0.61 then
		result = "large_cloud"
	elseif atmos.cloud.density.now >= 0.61 and atmos.cloud.density.now < 0.71 then
		result = "cloudy"
	elseif atmos.cloud.density.now >= 0.71 and atmos.cloud.density.now < 0.86 then
		if temp < 3.3 then
			result = "snow"
		else
			result = "rain"
		end
	else
		if temp < 2 then
			result = "hail"
		else
			result = "storm"
		end
	end
	return result
end

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
	atmos_cloudy_weather[val] = minetest.deserialize(line) 
	val = val + 1
end

local function atmos_ratio(current, next, ctime2)
	return (current + (next - current) * ctime2)
end

local function convert_hex(input_hex)
	-- Convert ColorSpec strings into individual intergers
	-- compatible with minetest.rgba().
	local r, g, b = input_hex:match("^#(%x%x)(%x%x)(%x%x)")
	return tonumber(r, 16), tonumber(g, 16), tonumber(b, 16)
end


local function make_skybox(player)
	local ctime = minetest.get_timeofday() * 100
	-- figure out our multiplier since get_timeofday returns 0->1, we can use the sig figs as a 0-100 percentage multiplier
	-- contributed by @rubenwardy
	local ctime2 = math.floor((ctime - math.floor(ctime)) * 100) / 100

	if ctime2 == 0 then ctime2 = 0.01 end -- anti sudden skybox change syndrome
	local fade_factor =  math.floor(255 * ctime2)
	ctime = math.floor(ctime) -- remove the sig figs, since we're accessing table points

	-- assemble the skyboxes to fade neatly
	

	-- let's convert the base colour to convert it into our transitioning fog colour:

	local fog_clear = {}
	local fog_cloud = {}

	fog_clear.current = {} -- we need two tables for comparing, as any matching pairs of hex will be skipped.
	fog_clear.next = {}
	fog_clear.result = {}

	fog_cloud.current = {}
	fog_cloud.next = {}
	fog_cloud.result = {}

	-- convert our hex into compatible minetest.rgba components:
	-- we need these to make our lives easier when it comes to uh, things.

	fog_clear.current.red, fog_clear.current.grn, fog_clear.current.blu = convert_hex(atmos_clear_weather[ctime].base)
	fog_clear.next.red, fog_clear.next.grn, fog_clear.next.blu = convert_hex(atmos_clear_weather[ctime+1].base)

	fog_cloud.current.red, fog_cloud.current.grn, fog_cloud.current.blu = convert_hex(atmos_cloudy_weather[ctime].base)
	fog_cloud.next.red, fog_cloud.next.grn, fog_cloud.next.blu = convert_hex(atmos_cloudy_weather[ctime+1].base)

	if atmos_clear_weather[ctime].base ~= atmos_clear_weather[ctime+1].base then
		-- we compare colours the same way we do it for the light level
		fog_clear.result.red = atmos_ratio(fog_clear.current.red, fog_clear.next.red, ctime2)
		fog_clear.result.grn = atmos_ratio(fog_clear.current.grn, fog_clear.next.grn, ctime2)
		fog_clear.result.blu = atmos_ratio(fog_clear.current.blu, fog_clear.next.blu, ctime2)
	else
		fog_clear.result.red = fog_clear.current.red
		fog_clear.result.grn = fog_clear.current.grn
		fog_clear.result.blu = fog_clear.current.blu
	end

	if atmos_cloudy_weather[ctime].base ~= atmos_cloudy_weather[ctime+1].base then
		fog_cloud.result.red = atmos_ratio(fog_cloud.current.red, fog_cloud.next.red, ctime2)
		fog_cloud.result.grn = atmos_ratio(fog_cloud.current.grn, fog_cloud.next.grn, ctime2)
		fog_cloud.result.blu = atmos_ratio(fog_cloud.current.blu, fog_cloud.next.blu, ctime2)
	else
		fog_cloud.result.red = fog_cloud.current.red
		fog_cloud.result.grn = fog_cloud.current.grn
		fog_cloud.result.blu = fog_cloud.current.blu
	end

	-- blend sky textures in colour

	local sky_clear = {}
	sky_clear.now = {}
	sky_clear.now.top = {}
	sky_clear.now.bot = {}

	sky_clear.next = {}
	sky_clear.next.top = {}
	sky_clear.next.bot = {}

	sky_clear.result = {}
	sky_clear.result.top = {}
	sky_clear.result.bot = {}

	--load colours into memory
	sky_clear.now.top.r, sky_clear.now.top.g, sky_clear.now.top.b = convert_hex(atmos_clear_weather[ctime].top)
	sky_clear.now.bot.r, sky_clear.now.bot.g, sky_clear.now.bot.b = convert_hex(atmos_clear_weather[ctime].bottom)
	
	sky_clear.next.top.r, sky_clear.next.top.g, sky_clear.next.top.b = convert_hex(atmos_clear_weather[ctime+1].top)
	sky_clear.next.bot.r, sky_clear.next.bot.g, sky_clear.next.bot.b = convert_hex(atmos_clear_weather[ctime+1].bottom)

	local clear_result = {}
	clear_result.top = {}
	clear_result.bot = {}

	clear_result.top.r = atmos_ratio(sky_clear.now.top.r, sky_clear.next.top.r, ctime2)
	clear_result.top.g = atmos_ratio(sky_clear.now.top.g, sky_clear.next.top.g, ctime2)
	clear_result.top.b = atmos_ratio(sky_clear.now.top.b, sky_clear.next.top.b, ctime2)
	
	clear_result.bot.r = atmos_ratio(sky_clear.now.bot.r, sky_clear.next.bot.r, ctime2)
	clear_result.bot.g = atmos_ratio(sky_clear.now.bot.g, sky_clear.next.bot.g, ctime2)
	clear_result.bot.b = atmos_ratio(sky_clear.now.bot.b, sky_clear.next.bot.b, ctime2)

	-- handle cloud data
	local sky_cloud = {}
	sky_cloud.now = {}
	sky_cloud.now.top = {}
	sky_cloud.now.bot = {}
	
	sky_cloud.next = {}
	sky_cloud.next.top = {}
	sky_cloud.next.bot = {}

	sky_cloud.now.top.r, sky_cloud.now.top.g, sky_cloud.now.top.b = convert_hex(atmos_cloudy_weather[ctime].top)
	sky_cloud.now.bot.r, sky_cloud.now.bot.g, sky_cloud.now.bot.b = convert_hex(atmos_cloudy_weather[ctime].bottom)
	
	sky_cloud.next.top.r, sky_cloud.next.top.g, sky_cloud.next.top.b = convert_hex(atmos_cloudy_weather[ctime+1].top)
	sky_cloud.next.bot.r, sky_cloud.next.bot.g, sky_cloud.next.bot.b = convert_hex(atmos_cloudy_weather[ctime+1].bottom)

	local cloud_result = {}
	cloud_result.top = {}
	cloud_result.bot = {}

	cloud_result.top.r = atmos_ratio(sky_cloud.now.top.r, sky_cloud.next.top.r, ctime2)
	cloud_result.top.g = atmos_ratio(sky_cloud.now.top.g, sky_cloud.next.top.g, ctime2)
	cloud_result.top.b = atmos_ratio(sky_cloud.now.top.b, sky_cloud.next.top.b, ctime2)
	
	cloud_result.bot.r = atmos_ratio(sky_cloud.now.bot.r, sky_cloud.next.bot.r, ctime2)
	cloud_result.bot.g = atmos_ratio(sky_cloud.now.bot.g, sky_cloud.next.bot.g, ctime2)
	cloud_result.bot.b = atmos_ratio(sky_cloud.now.bot.b, sky_cloud.next.bot.b, ctime2)

	-- mix and merge colours

	-- atmos.cloud.density.now
	local blend_curve = ((atmos.cloud.density.now/0.9)^10)/0.125

	if blend_curve < 0 then blend_curve = 0 end -- no stupid squaring here
	if blend_curve > 1 then blend_curve = 1 end

	local blend_op = math.floor(255 * blend_curve)

	local merge_result = {}
	merge_result.top = {}
	merge_result.bot = {}

	merge_result.top.r = atmos_ratio(clear_result.top.r, cloud_result.top.r, blend_curve)
	merge_result.top.g = atmos_ratio(clear_result.top.g, cloud_result.top.g, blend_curve)
	merge_result.top.b = atmos_ratio(clear_result.top.b, cloud_result.top.b, blend_curve)
	
	merge_result.bot.r = atmos_ratio(clear_result.bot.r, cloud_result.bot.r, blend_curve)
	merge_result.bot.g = atmos_ratio(clear_result.bot.g, cloud_result.bot.g, blend_curve)
	merge_result.bot.b = atmos_ratio(clear_result.bot.b, cloud_result.bot.b, blend_curve)

	local sky_tex_top = "atmos_sky.png^[multiply:" .. minetest.rgba(
		merge_result.bot.r,
		merge_result.bot.g,
		merge_result.bot.b
		) .. "^(atmos_sky_top_radial.png^[multiply:" .. minetest.rgba(
		merge_result.top.r,
		merge_result.top.g,
		merge_result.top.b
		) .. ")"

	local sky_tex_side = "atmos_sky.png^[multiply:" .. minetest.rgba(
		merge_result.bot.r,
		merge_result.bot.g,
		merge_result.bot.b
		) .. "^(atmos_sky_top.png^[multiply:" .. minetest.rgba(
		merge_result.top.r,
		merge_result.top.g,
		merge_result.top.b
		) .. ")"

	local sky_tex_bottom = "atmos_sky.png^[multiply:" .. minetest.rgba(
		merge_result.bot.r,
		merge_result.bot.g,
		merge_result.bot.b
		)

	-- merge fog colours;

	local result_fog = {}

	result_fog.r = atmos_ratio(fog_clear.result.red, fog_cloud.result.red, blend_curve)
	result_fog.g = atmos_ratio(fog_clear.result.grn, fog_cloud.result.grn, blend_curve)
	result_fog.b = atmos_ratio(fog_clear.result.blu, fog_cloud.result.blu, blend_curve)

	player:set_sky(
		minetest.rgba(
			result_fog.r,
			result_fog.g,
			result_fog.b
		),
		"skybox",
		{
			sky_tex_top,
			sky_tex_bottom,
			sky_tex_side,
			sky_tex_side,
			sky_tex_side,
			sky_tex_side
		},
		true
	)
	local cloud_curve = atmos.cloud.density.now^2
	local cloud_curve2 = ((((atmos.cloud.density.now-0.46)/1.2)^3)/0.1) + 0.56

	result_fog.a = atmos_ratio(atmos.cloud.colour.alp.min, atmos.cloud.colour.alp.max, cloud_curve2)
	local height = atmos_ratio(atmos.cloud.height.min, atmos.cloud.height.max, cloud_curve)
	local thicc = atmos_ratio(atmos.cloud.thicc.min, atmos.cloud.thicc.max, cloud_curve)

	local sun_

	player:set_clouds({
		density = atmos.cloud.density.now,
		height = height,
		thickness = thicc,
		color = minetest.rgba(
			atmos_ratio(atmos_ratio(atmos.cloud.colour.red, merge_result.bot.r, 0.65),
				fog_cloud.result.red, blend_curve),
			atmos_ratio(atmos_ratio(atmos.cloud.colour.grn, merge_result.bot.g, 0.65),
				fog_cloud.result.grn, blend_curve),
			atmos_ratio(atmos_ratio(atmos.cloud.colour.blu, merge_result.bot.b, 0.65),
				fog_cloud.result.blu, blend_curve),
			result_fog.a
		),
		speed = atmos.wind_to_vector(atmos.wind.rads, atmos.wind.speed)
	})
	
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

function atmos.sync_skybox()
	-- sync skyboxes to all players connected to the server.
	for _, player in ipairs(minetest.get_connected_players()) do
		make_skybox(player)
	end
	minetest.after(0.1, atmos.sync_skybox)
end

function atmos.thunderstrike()
	--lightning.strike()
	--minetest.after(math.random(43, 156), atmos.thunderstrike)	
end

minetest.after(1, atmos.sync_skybox)
--minetest.after(math.random(43, 156), atmos.thunderstrike)

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

minetest.register_chatcommand("thicc", { -- admin commands to debug the values for testing
	
	description = "debugs the current cloud level",
	param = "use 0-1 (float) to set cloud level.",
	func = function(name, param)
		
		if not minetest.check_player_privs(name, "server") then
			return false, "You are not allowed to be changing the clouds."
		end

		atmos.cloud.density.now = tonumber(param)
		
		return true, "Current cloud density levels updated."
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