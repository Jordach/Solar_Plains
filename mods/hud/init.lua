hud = {}

-- HUD statbar values
hud.health = {}
hud.hunger = {}
hud.air = {}
hud.armor = {}
hud.hunger_out = {}
hud.armor_out = {}

-- HUD item ids
local health_hud = {}
local hunger_hud = {}
local air_hud = {}
local armor_hud = {}
local armor_hud_bg = {}

-- default settings

HUD_SCALEABLE = false
HUD_SIZE = ""

 -- statbar positions
HUD_HEALTH_POS = {x=0.5,y=0.9}
HUD_HEALTH_OFFSET = {x=-175, y=2}

HUD_HUNGER_POS = {x=0.5,y=0.9}
HUD_HUNGER_OFFSET = {x=-175, y=-15}

HUD_AIR_POS =    {x=0.5,y=0.9}
HUD_AIR_OFFSET =    {x=-175,y=-24}

--HUD_ARMOR_POS = {x=0.5,y=0.9}
--HUD_ARMOR_OFFSET = {x=-175, y=-15}

-- dirty way to check for new statbars
if dump(minetest.hud_replace_builtin) ~= "nil" then
	HUD_SCALEABLE = false
	HUD_SIZE = {x=46.5, y=46.5}
	
	HUD_HEALTH_POS = {x=0.5,y=1}
	HUD_HEALTH_OFFSET = {x=-218, y=-96}
	
	HUD_HUNGER_POS = {x=0.5,y=1}
	HUD_HUNGER_OFFSET = {x=-218, y=-88-24}
	
	HUD_AIR_POS = {x=0.5,y=1}
	HUD_AIR_OFFSET = {x=-218, y=-88-40}
	
	--HUD_ARMOR_POS = {x=0.5,y=1}
	--HUD_ARMOR_OFFSET = {x=-262, y=-110}
end

HUD_TICK = 0.25
HUD_HUNGER_TICK = 300

HUD_ENABLE_HUNGER = minetest.setting_getbool("hud_hunger_enable")
if HUD_ENABLE_HUNGER == nil then
	HUD_ENABLE_HUNGER = minetest.setting_getbool("enable_damage")
end

--load custom settings
local set = io.open(minetest.get_modpath("hud").."/hud.conf", "r")
if set then 
	dofile(minetest.get_modpath("hud").."/hud.conf")
	set:close()
else
	if not HUD_ENABLE_HUNGER then
		HUD_AIR_OFFSET = HUD_HUNGER_OFFSET
	end
end

local function hide_builtin(player)
	 player:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = true, breathbar = false})
end


function hud.custom_hud(player)
 local name = player:get_player_name()

 
 
 --hunger
	if HUD_ENABLE_HUNGER then
       	 player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_HUNGER_POS,
		size = HUD_SIZE,
		text = "hud_hunger_bg.png",
		number = 20,
		alignment = {x=-1,y=-1},
		offset = HUD_HUNGER_OFFSET,
	 })
	local h = hud.hunger[name]
	if h == nil or h > 20 then h = 20 end
	 hunger_hud[name] = player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_HUNGER_POS,
		size = HUD_SIZE,
		text = "hud_hunger_fg.png",
		number = h,
		alignment = {x=-1,y=-1},
		offset = HUD_HUNGER_OFFSET,
	 })
	 
 --health
        player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_HEALTH_POS,
		size = HUD_SIZE,
		text = "hud_heart_bg.png",
		number = 20,
		alignment = {x=-1,y=-1},
		offset = HUD_HEALTH_OFFSET,
	})
	health_hud[name] = player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_HEALTH_POS,
		size = HUD_SIZE,
		text = "hud_heart_fg.png",
		number = player:get_hp(),
		alignment = {x=-1,y=-1},
		offset = HUD_HEALTH_OFFSET,
	})

 --air
	    player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_HEALTH_POS,
		size = HUD_SIZE,
		text = "hud_heart_bg.png",
		number = 20,
		alignment = {x=-1,y=-1},
		offset = HUD_AIR_OFFSET,
	})
	
	air_hud[name] = player:hud_add({
		hud_elem_type = "statbar",
		position = HUD_AIR_POS,
		size = HUD_SIZE,
		text = "hud_air_fg.png",
		number = (player:get_breath()-1)*2,
		alignment = {x=-1,y=-1},
		offset = HUD_AIR_OFFSET,
	})

 end
end

--needs to be defined for older version of 3darmor
function hud.set_armor()
end


if HUD_ENABLE_HUNGER then dofile(minetest.get_modpath("hud").."/hunger.lua") end
--if HUD_SHOW_ARMOR then dofile(minetest.get_modpath("hud").."/armor.lua") end

-- update hud elemtens if value has changed
local function update_hud(player)
	local name = player:get_player_name()
 --air
	local air = tonumber(hud.air[name])
	if player:get_breath() ~= air then
		air = player:get_breath()
		hud.air[name] = air
		if air > 10 then air = 10 end
		player:hud_change(air_hud[name], "number", air*2)
	end
 --health
	local hp = tonumber(hud.health[name])
	if player:get_hp() ~= hp then
		hp = player:get_hp()
		hud.health[name] = hp
		player:hud_change(health_hud[name], "number", hp)
	end
 --armor
	local arm_out = tonumber(hud.armor_out[name])
	if not arm_out then arm_out = 0 end
	local arm = tonumber(hud.armor[name])
	if not arm then arm = 0 end
	if arm_out ~= arm then
		hud.armor_out[name] = arm
		player:hud_change(armor_hud[name], "number", arm)
		-- hide armor bar completely when there is none
		if (not armor.def[name].count or armor.def[name].count == 0) and arm == 0 then
		 player:hud_change(armor_hud_bg[name], "number", 0)
		else
		 player:hud_change(armor_hud_bg[name], "number", 20)
		end
	end
 --hunger
	local h_out = tonumber(hud.hunger_out[name])
	local h = tonumber(hud.hunger[name])
	if h_out ~= h then
		hud.hunger_out[name] = h
		-- bar should not have more than 10 icons
		if h>20 then h=20 end
		player:hud_change(hunger_hud[name], "number", h)
	end
end

hud.get_hunger = function(player)
	local inv = player:get_inventory()
	if not inv then return nil end
	local hgp = inv:get_stack("hunger", 1):get_count()
	if hgp == 0 then
		hgp = 21
		inv:set_stack("hunger", 1, ItemStack({name=":", count=hgp}))
	else
		hgp = hgp
	end
	return hgp-1
end

hud.set_hunger = function(player)
	local inv = player:get_inventory()
	local name = player:get_player_name()
	local value = hud.hunger[name]
	if not inv  or not value then return nil end
	if value > 30 then value = 30 end
	if value < 0 then value = 0 end
	
	inv:set_stack("hunger", 1, ItemStack({name=":", count=value+1}))

	return true
end

minetest.register_on_joinplayer(function(player)
		
	local name = player:get_player_name()
	local inv = player:get_inventory()
	inv:set_size("hunger",1)
	hud.health[name] = player:get_hp()
	
	if HUD_ENABLE_HUNGER then
		hud.hunger[name] = hud.get_hunger(player)
		hud.hunger_out[name] = hud.hunger[name]
	end
	hud.armor[name] = 0
	hud.armor_out[name] = 0
	local air = player:get_breath()
	hud.air[name] = air
	
	minetest.after(0.2, function()
		--hide_builtin(player)
		--custom_hud(player)
		if HUD_ENABLE_HUNGER then hud.set_hunger(player) end
	end)
	
	
end)

minetest.register_on_respawnplayer(function(player)
	-- reset player breath since the engine doesnt
	player:set_breath(11)
	-- reset hunger (and save)
	hud.hunger[player:get_player_name()] = 20
	if HUD_ENABLE_HUNGER then
		minetest.after(0.5, hud.set_hunger, player)
	end
end)

function hud.update_cycle()

	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()

		-- only proceed if damage is enabled
		if minetest.setting_getbool("enable_damage") then
		 local h = tonumber(hud.hunger[name])
		 local hp = player:get_hp()
		 if HUD_ENABLE_HUNGER then
			-- heal player by 1 hp if not dead and saturation is > 15 (of 30)
			if h > 15 and hp > 0 and hud.air[name] > 0 then
				player:set_hp(hp+1)
			-- or damage player by 1 hp if saturation is < 2 (of 30)
			elseif h <= 1 and minetest.setting_getbool("enable_damage") then
				if hp-1 >= 0 then player:set_hp(hp-1) end
			end
		 end	
	 -- update all hud elements
				
		update_hud(player)
		end
	end

	minetest.after(HUD_TICK, hud.update_cycle)

end

function hud.change_hunger()
	
	for _,player in ipairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local h = tonumber(hud.hunger[name])
		local hp = player:get_hp()
	 -- lower saturation by 1 point after xx seconds
		 if HUD_ENABLE_HUNGER then
			if h > 0 then
				h = h-1
				hud.hunger[name] = h
				hud.set_hunger(player)
			end
			
			update_hud(player)
		 end
	end
	
	minetest.after(HUD_HUNGER_TICK, hud.change_hunger)
end

minetest.after(1, hud.update_cycle)
minetest.after(2, hud.change_hunger)
