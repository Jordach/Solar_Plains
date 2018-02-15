hudclock = {}

hudclock.player_hud = { };

local timer = 0;
local positionx = 1;
local positiony = 0;
local last_time = os.time()

local totaldays = 1

hudclock.day = 1
hudclock.month = 1
hudclock.year = 1

ymd = {}

local function floormod ( x, y )
	return (math.floor(x) % y);
end

local function get_time()
	local secs = (60*60*24*minetest.get_timeofday());
	local seconds = floormod(secs, 60);
	local minutes = floormod(secs/60, 60);
	local hours = floormod(secs/3600, 60);
	return ("%02d:%02d"):format(hours, minutes);
end

function hudclock.update_time()

	for _,p in ipairs(minetest.get_connected_players()) do
		local name = p:get_player_name();
		
		if hudclock.player_hud[name] = nil then break end
		
		p:hud_change(hudclock.player_hud[name].timev, "text", get_time())
		p:hud_change(hudclock.player_hud[name].datev, "text", hudclock.day .. "/" .. hudclock.month .. "/" .. hudclock.year)
	
	end
	
	minetest.after(1, hudclock.update_time)
	
end

minetest.after(1, hudclock.update_time)

function hudclock.update_calendar()
	totaldays = minetest.get_day_count()
	
	local totalmonths = 1
	local totalyears = 1
	
	if totaldays == nil or totaldays == 0 then
		totaldays = 1
	end
	
	while totaldays >= 31 do
			
		totaldays = totaldays - 30
		
		totalmonths = totalmonths + 1
			
		if totalmonths == 13 then
		
			totalyears = totalyears + 1
			
			totalmonths = 1
			
		end
		
	end
	
	-- print (totaldays)
	-- print (totalmonths)
	-- print (totalyears)
		
	hudclock.day = totaldays
	hudclock.month = totalmonths
	hudclock.year = totalyears
	minetest.after(30, hudclock.update_calendar)
	
	print ("[Hudclock] Recalculating calendar.\n[Hudclock] The date is: " .. hudclock.day .. " / " .. hudclock.month .. " / " .. hudclock.year)
end

--[[

	seasonal table;
	
	spring: 2, 3 and 4
	summer: 5, 6 and 7
	autumn: 8, 9 and 10
	winter: 11, 12 and 1
	

]]--

minetest.after(1, hudclock.update_calendar)

function hudclock.display_bg(player)
	
	if player:get_attribute("core_display_hud") == "true" then
		
		player:hud_add({
			hud_elem_type = "image",
			position = {x=0.5, y=0.5},
			scale = {x=-100, y=-100},
			text = "hud_vignette.png"
		})
	
		player:hud_add({
			hud_elem_type = "image",
			position = {x=1, y=0},
			offset = {x=-120, y=64},
			scale = {x=1, y=1},
			text = "mthudclock.png",
		})
	
		local name = player:get_player_name()
		
		hudclock.player_hud[name] = {}
		
		local t = player:hud_add({
			
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = get_time(),
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=118}, -- 21px difference!
			
		})
		
		local d = player:hud_add({
		
			hud_elem_type = "text",
			position = {x=1, y=0},
			text = hudclock.day .. "/" .. hudclock.month .. "/" .. hudclock.year,
			number = 0xFFFFFF,
			alignment = {x=1, y=0},
			offset = {x=-233, y=138},
		
		})

		hudclock.player_hud[name].timev = t
		hudclock.player_hud[name].datev = d
		
		
	end
	
end