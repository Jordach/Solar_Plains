hudclock = {}

hudclock.player_hud = { };

local timer = 0;
local positionx = 0;
local positiony = 1;
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
		if p:get_attribute("core_display_hud") == "true" then
			local h = p:hud_add({
				hud_elem_type = "text",
				position = {x=positionx, y=positiony},
				text = "Time: " .. get_time() .. "\n\n" .. "Day: " .. hudclock.day .. "\nMonth: " .. hudclock.month .. "\nYear: " .. hudclock.year,
				number = 0xFFFFFF,
				offset = {x=48, y=-48},
			});
		
		
		if (hudclock.player_hud[name]) then
			p:hud_remove(hudclock.player_hud[name]);
		end
					
		hudclock.player_hud[name] = h
		end
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
	minetest.after(25, hudclock.update_calendar)
end

--[[

	seasonal table;
	
	spring: 2, 3 and 4
	summer: 5, 6 and 7
	autumn: 8, 9 and 10
	winter: 11, 12 and 1
	

]]--

minetest.after(1, hudclock.update_calendar)

-- minetest.register_chatcommand("hcr", {
-- 	params = "",
-- 	description = "This should reset your hudclock.",
-- 	func = function(name, param)
-- 		local player = minetest.get_player_by_name(name)
-- 		if not player then
-- 			return
-- 		end
-- 		player:hud_remove(player_hud[name]);
-- 		player_hud[name] = nil
-- 	end,
-- })

minetest.register_on_joinplayer(function(player)
	local name = player:get_player_name()
	if hudclock.player_hud[name] ~= nil then
		player:hud_remove(hudclock.player_hud[name]);
		hudclock.player_hud[name] = nil
	end
	minetest.after(1, hudclock.update_calendar)
	return true
end)

function hudclock.display_bg(player)
	
	player:hud_add({
		hud_elem_type = "image",
		position = {x=0.5, y=0.5},
		scale = {x=-100, y=-100},
		text = "hud_vignette.png"
	})
	
	player:hud_add({
		hud_elem_type = "image",
		position = {x=positionx, y=positiony},
		offset = {x=128-54, y=-48},
		scale = {x=1.333, y=1.333},
		text = "mthudclock.png",
	})

end

print ("calculating current ingame time!")