-- atmos, control of skies, weather, and various other visual tasks

atmos = {}

atmos.wind = {}
atmos.wind.x = 0 -- radians
atmos.wind.z = 0 -- radians
atmos.wind.speed = 2 -- in nodes/meters per second

atmos.cloud = {}

atmos.cloud.density = {} -- overall cloud density
atmos.cloud.density.min = 0
atmos.cloud.density.max = 1
atmos.cloud.density.now = 0

atmos.cloud.thicc = {}
atmos.cloud.thicc.min = 1 -- thiccness in nodes
atmos.cloud.thicc.max = 32

atmos.cloud.height= {} -- height in nodes from 0
atmos.cloud.height.min = 80
atmos.cloud.height.max = 220

atmos.cloud.colour = {} -- minetest.rgba components for colourising clouds
atmos.cloud.colour.red = 250 -- replace these with the cloudy skybox with some brightening
atmos.cloud.colour.grn = 250
atmos.cloud.colour.blu = 255

atmos.cloud.colour.alp = {} -- tune this when clouds get thiccer
atmos.cloud.colour.alp.min = 5
atmos.cloud.colour.alp.max = 229

function atmos.wind_to_vector(rads, mult) -- forwards only
	local z = math.cos(rads) * mult
	local x = (math.sin(rads) * -1) * mult
	return x, z
end

atmos.current_weather = 3

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
	return current + (next - current) * ctime2
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
	local side_string_clear = "(atmos_sky.png^[multiply:" .. atmos_clear_weather[ctime].bottom .. ")^" ..
		"(atmos_sky_top.png^[multiply:" .. atmos_clear_weather[ctime].top .. ")"

	local side_string_new_clear = "(atmos_sky.png^[multiply:" .. atmos_clear_weather[ctime+1].bottom .. ")^" ..
		"(atmos_sky_top.png^[multiply:" .. atmos_clear_weather[ctime+1].top .. ")"

	local sky_top_clear = "(atmos_sky.png^[multiply:" .. atmos_clear_weather[ctime].bottom .. ")^" ..
		"(atmos_sky_top_radial.png^[multiply:" .. atmos_clear_weather[ctime].top .. ")"

	local sky_top_new_clear = "(atmos_sky.png^[multiply:" .. atmos_clear_weather[ctime+1].bottom .. ")^" ..
		"(atmos_sky_top_radial.png^[multiply:".. atmos_clear_weather[ctime+1].top .. ")"

	local sky_bottom_clear = "(atmos_sky.png^[multiply:" ..
		atmos_clear_weather[ctime].bottom .. ")"
	
	local sky_bottom_new_clear = "(atmos_sky.png^[multiply:" ..
		atmos_clear_weather[ctime+1].bottom .. ")"

	-- cloud sky textures
	local side_string_cloud = "(atmos_sky.png^[multiply:" .. atmos_cloudy_weather[ctime].bottom .. ")^" ..
		"(atmos_sky_top.png^[multiply:" .. atmos_cloudy_weather[ctime].top .. ")"
	
	local side_string_cloud_new = "(atmos_sky.png^[multiply:" .. atmos_cloudy_weather[ctime+1].bottom .. ")^" ..
		"(atmos_sky_top.png^[multiply:" .. atmos_cloudy_weather[ctime+1].top .. ")"
	
	local sky_top_cloud = "(atmos_sky.png^[multiply:" .. atmos_cloudy_weather[ctime].bottom .. ")^" ..
		"(atmos_sky_top_radial.png^[multiply:" .. atmos_cloudy_weather[ctime].top .. ")"
	
	local sky_top_cloud_new = "(atmos_sky.png^[multiply:" .. atmos_cloudy_weather[ctime+1].bottom .. ")^" ..
		"(atmos_sky_top_radial.png^[multiply:" .. atmos_cloudy_weather[ctime+1].top .. ")"
	
	local sky_bottom_cloud = "(atmos_sky.png^[multiply:" ..
		atmos_cloudy_weather[ctime].bottom .. ")"
	
	local sky_bottom_cloud_new = "(atmos_sky.png^[multiply:" ..
		atmos_cloudy_weather[ctime+1].bottom .. ")"

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

	fog_cloud.current.red, fog_cloud.current.grn, fog_cloud.current.blu = convert_hex(atmos_clear_weather[ctime].base)
	fog_cloud.next.red, fog_cloud.next.grn, fog_cloud.next.blu = convert_hex(atmos_clear_weather[ctime+1].base)

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

	if atmos_clear_weather[ctime].bottom == atmos_clear_weather[ctime+1].bottom then -- prevent more leakage
		if atmos_clear_weather[ctime].top == atmos_clear_weather[ctime+1].top then
			fade_factor = 0
		end
	end
	
	local blend_curve = ((atmos.cloud.density.now / 0.9)^10)/2.867

	if blend_curve < 0 then blend_curve = 0 end -- no stupid squaring here
	if blend_curve > 1 then blend_curve = 1 end

	local blend_op = math.floor(255 * blend_curve)

	-- blend sky textures in colour
	local clear_sky_top = sky_top_clear .. "^(" .. sky_top_new_clear .. "^[opacity:" .. fade_factor .. ")"
	local cloud_sky_top = sky_top_cloud .. "^(" .. sky_top_cloud_new .. "^[opacity:" .. fade_factor .. ")"

	local clear_sky_side = side_string_clear .. "^(" .. side_string_new_clear .. "^[opacity:" .. fade_factor .. ")"
	local cloud_sky_side = side_string_cloud .. "^(" .. side_string_cloud_new .. "^[opacity:" .. fade_factor .. ")"

	local clear_sky_bottom = sky_bottom_clear .. "^(" .. sky_bottom_new_clear .. "^[opacity:" .. fade_factor .. ")"
	local cloud_sky_bottom = sky_bottom_cloud .. "^(" .. sky_bottom_cloud_new .. "^[opacity:" .. fade_factor .. ")"

	-- "^[opacity:" .. blend_op
	local result_sky_top = clear_sky_top .. "^(" .. cloud_sky_top .. "^[opacity:" .. blend_op .. ")"

	local result_sky_bottom = clear_sky_bottom .. "^(" .. cloud_sky_bottom .. "^[opacity:" .. blend_op .. ")"

	local result_sky_side = clear_sky_side .. "^(" .. cloud_sky_side .. "^[opacity:" .. blend_op .. ")"

	local result_fog = {}

	result_fog.r = atmos_ratio(fog_clear.result.red, fog_cloud.result.red, atmos.cloud.density.now)
	result_fog.g = atmos_ratio(fog_clear.result.grn, fog_cloud.result.grn, atmos.cloud.density.now)
	result_fog.b = atmos_ratio(fog_clear.result.blu, fog_cloud.result.blu, atmos.cloud.density.now)
	result_fog.a = math.floor(atmos.cloud.colour.alp.max * atmos.cloud.density.now)

	if result_fog.a < atmos.cloud.colour.alp.min then
		result_fog.a = atmos.cloud.colour.alp.min
	end

	player:set_sky(
		minetest.rgba(
			result_fog.r,
			result_fog.g,
			result_fog.b
		),
		"skybox",
		{
			result_sky_top,
			result_sky_bottom,
			result_sky_side,
			result_sky_side,
			result_sky_side,
			result_sky_side,
		},
		true
	)
	
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