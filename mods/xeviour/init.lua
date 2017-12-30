local player_relative = {x=0, y=-10, z=0}
local player_rot = {x=0, y=0, z=0}
local default_eye_offset = {x=0, y=0, z=0}
local flying_eye_offset = {x=0, y=-6, z=-25}
local flying_eye_offset_3r = {x=0, y=-10, z=0}

local function xev_get_yaw_to_vec(rads, mult) -- forwards only.

	local z = math.cos(rads) * mult
	
	local x = (math.sin(rads) * -1) * mult
	
	return x, z

end

-- strafing yaw to vec. bool for right, otherwise left.

local function xev_get_yaw_to_vec_str(rads, mult, left)
	
	local nrads = rads + math.pi/2
	
	if left then
	
		nrads = rads - math.pi/2
	
	end
	
	local x = (math.cos(nrads) * -1) * mult
	
	local z = math.sin(nrads) * mult
	
	return z, x
	
end

local function drain_stamina(player)
  
	local player_stamina = tonumber(player:get_attribute("stamina"))

	local stam = player_stamina - 10
	
	if player_stamina > 9 then
  
		player:set_attribute("stamina", stam)
  
	end
  
	if stam < 20 then hb.unhide_hudbar(player, "stamina") end
    
	hb.change_hudbar(player, "stamina", stam)
	
end

local xev_pack_special = {

	visual = "mesh",
	mesh = "xeviance.b3d",
	textures = {"ptextures_transparent.png"},
	visual_size = {x=1,y=1},
	player_id = nil,
	ttime = 0,
	backface_culling = false,
	xv = 0,
	yv = 0,
	zv = 0,
	is_boosting = false,
	timer = 0,
	anim_state = "idle",
	physical = true,
	collide_with_objects = true,
	pointable = false,
}

function xev_pack_special:on_step(dtime)
	
	if self.player_id ~= nil then
		
		-- animation system here:
		
		if self.is_boosting then
			
			if self.anim_state == "boost" then
			
				if self.player_id:get_player_control().left then
				
					-- roll left
					
					self.object:set_animation({x=92, y=122}, 60, 0, false)
					
				else
				
					-- roll right
					
					self.object:set_animation({x=61, y=91}, 60, 0, false)
					
				end
				
				self.anim_state = "boost1"
				
			end
			
			self.timer = self.timer + dtime
			
			if self.timer > 0.5 then
			
				self.timer = 0
				
				self.is_boosting = false
				
				self.object:set_animation({x=0, y=59}, 30, 0)
				
				self.anim_state = "idle"
				
			end
		
		end
		
		-- process air resistance and drag here
		
		self.xv = self.xv * 0.96
		self.yv = self.yv * 0.96
		self.zv = self.zv * 0.96
		
		-- round down numbers in the case of e-11
		
		if math.abs(self.xv) < 0.05 then self.xv = 0 end
		if math.abs(self.yv) < 0.05 then self.yv = 0 end
		if math.abs(self.zv) < 0.05 then self.zv = 0 end
		
		-- get rotational information.
		
		local pyaw = self.player_id:get_look_horizontal()
		
		self.object:set_yaw(pyaw)
				
		if self.player_id:get_player_control().up then -- move forwards now.
			
			local xr, zr = xev_get_yaw_to_vec(pyaw, 0.6)
			
			if self.player_id:get_player_control().aux1 then
			
				if self.is_boosting == false then
				
					local player_stamina = tonumber(self.player_id:get_attribute("stamina"))
					
					if player_stamina > 9 then
					
						-- consume AP here
					
						drain_stamina(self.player_id)
						
						self.is_boosting = true
						
						if self.anim_state == "idle" then -- set anim state here
					
							self.anim_state = "boost"
						
						end
						
						xr = xr * 300
						self.yv = self.yv * 8
						zr = zr * 300
					
					end
					
				end
				
			end
			
			self.xv = self.xv + xr
			self.zv = self.zv + zr
		
		elseif self.player_id:get_player_control().down then -- slow down
		
			self.xv = self.xv * 0.8
			self.yv = self.yv * 0.8
			self.zv = self.zv * 0.8
			
		end
		
		if self.player_id:get_player_control().left then
		
			local xr, zr = xev_get_yaw_to_vec_str(pyaw, 0.15, true)
			
			self.xv = self.xv + xr
			self.zv = self.zv + zr
		
		elseif self.player_id:get_player_control().right then
		
			local xr, zr = xev_get_yaw_to_vec_str(pyaw, 0.15, false)
			
			self.xv = self.xv + xr
			self.zv = self.zv + zr
		
		end
		
		if self.player_id:get_player_control().sneak then
		
			self.yv = self.yv - 0.25
		
		elseif self.player_id:get_player_control().jump then
		
			self.yv = self.yv + 0.25
		
		end
		
		if self.player_id:get_player_control().aux1 and self.player_id:get_player_control().sneak then 
			
			if self.player_id:get_player_control().up == false then
				
				self.xv = 0
				self.yv = 0
				self.zv = 0
				
				self.player_id:set_detach() 
					
				wardrobe.apply_to_player(self.player_id, nil)	
				
				self.player_id:set_eye_offset(default_eye_offset, default_eye_offset)
				
				self.player_id:hud_set_flags({crosshair = true, hotbar = true, healthbar = false, wielditem = true, breathbar = false})
				
				local p_inv = self.player_id:get_inventory()
				
				if p_inv:room_for_item("main", "xeviour:pack 1") then
				
					p_inv:add_item("main", "xeviour:pack 1")
				
				else
				
					minetest.add_item(self.player_id:get_pos(), "xeviour:pack")
				
				end
				
				self.player_id:set_attribute("xev_pack_equipped", "false")
				
				self.object:remove()
				
				return
				
			end
		
		end
		
		self.object:set_velocity({x=self.xv, y=self.yv, z=self.zv})
		
	end
	
	if self.player_id == nil then self.object:remove() end
	
end

minetest.register_entity("xeviour:special", xev_pack_special)

local function equip_jetpack(player)

	local pos = player:get_pos()
	
	player:set_attribute("xev_pack_equipped", "true")
	
	pos.y = pos.y + 1
	
	local jp = minetest.add_entity(pos, "xeviour:special")
	
	local pack = jp:get_luaentity()
	
	local pname = player:get_player_name()
	
	pack.player_id = player
	
	jp:set_animation({x=0, y=59}, 30, 0)
	
	player:set_properties({
	
		textures = {
		
			"ptextures_transparent.png", 
			"ptextures_transparent.png", 
			"ptextures_transparent.png", 
			"ptextures_transparent.png", 
			"ptextures_transparent.png", 
			"ptextures_transparent.png", 
			"ptextures_transparent.png"
		}
	
	})
	
	jp:set_properties({
	
		textures = {
			"(wardrobe_skin"..                                                   ".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][1]..  ")^"..
			"(wardrobe_eyes_white_"..  wardrobe.formspec_selections[pname][1]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][2]..  ")^"..
			"(wardrobe_eyes_pupil_"..  wardrobe.formspec_selections[pname][2]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][3]..  ")^"..
			"(wardrobe_hair_"..        wardrobe.formspec_selections[pname][3]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][4]..  ")^"..
			"(wardrobe_mouth_"..       wardrobe.formspec_selections[pname][4]  ..".png)^"..
			"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][5]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][5]..  ")^"..
			"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][6]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][6]..  ")^"..
			"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][7]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][7]..  ")^"..
			"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][8]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][8]..  ")^"..
			"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][9]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][9]..  ")^"..
			"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][10] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][10].. ")^"..
			"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][11] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][11].. ")^"..
			"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][12] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][12].. ")^"..
			"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][13] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][13].. ")^"..
			"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][14] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][14].. ")^"..		
			"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][15] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][15].. ")^"..
			"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][16] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][16].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][17] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][17].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][18] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][18].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][19] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][19].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][20] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][20].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][21] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][21].. ")^"..
			"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][22] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][22].. ")^"..
			"(xev_overlay_c1.png^[multiply:#ffffff)^(xev_overlay_c2.png^[multiply:#44aaff)", -- un hardcode me sometime
		}
	
	})
	
	player:hud_set_flags({crosshair = false, hotbar = true, healthbar = false, wielditem = false, breathbar = false})
	
	player:set_eye_offset(flying_eye_offset, flying_eye_offset_3r)
	
	player:set_attach(pack.object, "", player_relative, player_rot)

end

minetest.register_craftitem("xeviour:pack", {

	description = "Jetpack",
	inventory_image = "xev_inv_icon.png",
	
	max_stack = 1,
	
	on_place = function(itemstack, user, pointed_thing)
	
		equip_jetpack(user)
		
		itemstack:take_item()
		
		return itemstack
		
	end,
	
	on_secondary_use = function(itemstack, user, pointed_thing)
	
		equip_jetpack(user)
		
		itemstack:take_item()
		
		return itemstack
	
	end,
	
})

minetest.register_on_joinplayer(function(player)

	if player:get_attribute("xev_pack_equipped") == "true" then
	
		local p_inv = player:get_inventory()
				
		if p_inv:room_for_item("main", "xeviour:pack 1") then
				
			p_inv:add_item("main", "xeviour:pack 1")
			
		else
				
			minetest.add_item(player:get_pos(), "xeviour:pack")
				
		end
				
		player:set_attribute("xev_pack_equipped", "false")
		
		minetest.chat_send_player(player:get_player_name(), "WARNING: Please don't exit the game or server without unequipping the jetpack first!")
		
	end
end)