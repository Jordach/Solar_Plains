-- Keep these for backwards compatibility
function hud.save_hunger(player)
	hud.set_hunger(player)
end
function hud.load_hunger(player)
	hud.get_hunger(player)
end

-- Poison player
local function poisenp(tick, time, time_left, player)
	time_left = time_left + tick
	if time_left < time then
		minetest.after(tick, poisenp, tick, time, time_left, player)
	end
	if player:get_hp()-1 > 0 then
		player:set_hp(player:get_hp()-1)
	end
	
end

function hud.item_eat(hunger_change, replace_with_item, poisen)
	return function(itemstack, user, pointed_thing)
		if itemstack:take_item() ~= nil and user ~= nil then
			local name = user:get_player_name()
			local h = tonumber(hud.hunger[name])
			h=h+hunger_change
			if h>30 then h=30 end
			hud.hunger[name]=h
			hud.set_hunger(user)
			itemstack:add_item(replace_with_item) -- note: replace_with_item is optional
			--sound:eat
			if poisen then
				poisenp(1.0, poisen, 0, user)
			end
		end
		return itemstack
	end
end

local function overwrite(name, hunger_change, replace_with_item, poisen)
	local tab = minetest.registered_items[name]
	if tab == nil then return end
	tab.on_use = hud.item_eat(hunger_change, replace_with_item, poisen)
	minetest.registered_items[name] = tab
end

--overwrite("default:apple", 2)
--overwrite("farming:bread", 4)

