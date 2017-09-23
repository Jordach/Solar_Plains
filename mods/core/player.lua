-- Minetest 0.4 mod: player
-- See README.txt for licensing and other information.

-- Player animation blending
-- Note: This is currently broken due to a bug in Irrlicht, leave at 0
default = {}

local animation_blend = 0

default.registered_player_models = { }

-- Local for speed.
local models = default.registered_player_models

function default.player_register_model(name, def)
	models[name] = def
end

-- setting player amour textures;

--[[

The first texture in the table is for 64x32 skins, the original Minecraft
format.

The second texture in the table is for 64x64 skins, introduced in
Minecraft's offical 1.8 update, not the Beta.

The thrid texture in the table is a 64x32 texture, which follows
the same scheme as Minecrafts 64x32 texture, and the same layout.

Use the head in the top left position and not the "hat layer".

The fourth texture in the table is the same texture as above.
Except, the chest has both the main body and arms. Same place
as a normal 64x32 skin.

The fifth texture in the table is the same texture as the helmet,
but uses the top half of the legs texture - note that it does not
use the last 4 pixels of the legs.

The sixth texture in the table is the same texture as the helmet,
but uses the final four pixels of the leg texture.

The seventh texture in the table is teh shield - a 16x16 image
that will cover your own or another's left arm.

A demo texture for armour can be found at;

https://jordach.net/Images/ProtonArt/base_armour.png

Use "ptextures_transparent.png" when not using armour layers and
or the 64x64 skin socket.

--]]

-- Default player appearance
default.player_register_model("character.x", {
	animation_speed = 30,
	textures = {
				"ptextures_transparent.png", 
				"(wardrobe_skin.png^[multiply:#ffffff)",
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png"
	},
	animations = {
		-- Standard animations.
		stand     = { x=  0, y= 79, },
		lay       = { x=162, y=166, },
		walk      = { x=168, y=187, },
		mine      = { x=189, y=198, },
		walk_mine = { x=200, y=219, },
		dead      = { x= 221, y=225, },
		-- Utility animations (not currently used by the game; but still usable by mods).
		sit       = { x= 81, y=160, },
		lay_bed   = { x= 226, y=228, },
		collisionbox = {-0.3, 0.0, -0.3, 0.3, 1.77, 0.3},
		stepheight = 0.6,
	},
})

-- Player stats and animations
local player_model = {}
local player_textures = {}
local player_anim = {}
local player_sneak = {}
default.player_attached = {}

function default.player_get_animation(player)
	local name = player:get_player_name()
	return {
		model = player_model[name],
		textures = player_textures[name],
		animation = player_anim[name],
	}
end

-- Called when a player's appearance needs to be updated
function default.player_set_model(player, model_name)
	local name = player:get_player_name()
	local model = models[model_name]
	if model then
		if player_model[name] == model_name then
			return
		end
		player:set_properties({
			mesh = model_name,
			textures = player_textures[name] or model.textures,
			visual = "mesh",
			visual_size = model.visual_size or {x=1, y=1},
		})
		default.player_set_animation(player, "stand")
	else
		player:set_properties({
			textures = { "player.png", "player_back.png", },
			visual = "upright_sprite",
		})
	end
	player_model[name] = model_name
end

function default.player_set_textures(player, textures)
	local name = player:get_player_name()
	player_textures[name] = textures
	player:set_properties({textures = textures,})
end

function default.player_set_animation(player, anim_name, speed)
	local name = player:get_player_name()
	if player_anim[name] == anim_name then
		return
	end
	local model = player_model[name] and models[player_model[name]]
	if not (model and model.animations[anim_name]) then
		return
	end
	local anim = model.animations[anim_name]
	player_anim[name] = anim_name
	player:set_animation(anim, speed or model.animation_speed, animation_blend)
end

-- Update appearance when the player joins
minetest.register_on_joinplayer(function(player)
	default.player_attached[player:get_player_name()] = false
	default.player_set_model(player, "character.x")
	player:set_local_animation({x=0, y=79}, {x=168, y=187}, {x=189, y=198}, {x=200, y=219}, 30)
	-- anim: stand, sit, lay, walk, mine, walk and mine
	player:hud_set_hotbar_image("hud_hotbar.png")
	player:hud_set_hotbar_selected_image("hud_hotbar_selected.png")
end)

minetest.register_on_leaveplayer(function(player)
	local name = player:get_player_name()
	player_model[name] = nil
	player_anim[name] = nil
	player_textures[name] = nil
end)

-- Localize for better performance.
local player_set_animation = default.player_set_animation
local player_attached = default.player_attached

-- Check each player and apply animations
minetest.register_globalstep(function(dtime)
	for _, player in pairs(minetest.get_connected_players()) do
		local name = player:get_player_name()
		local model_name = player_model[name]
		local model = model_name and models[model_name]
		if model and not player_attached[name] then
			local controls = player:get_player_control()
			local walking = false
			local animation_speed_mod = model.animation_speed or 30

			-- Determine if the player is walking
			if controls.up or controls.down or controls.left or controls.right then
				walking = true
			end

			-- Determine if the player is sneaking, and reduce animation speed if so
			if controls.sneak then
				animation_speed_mod = animation_speed_mod / 2
			end

			-- Apply animations based on what the player is doing
			if player:get_hp() == 0 then
				player_set_animation(player, "dead")
			elseif walking then
				if player_sneak[name] ~= controls.sneak then
					player_anim[name] = nil
					player_sneak[name] = controls.sneak
				end
				if controls.LMB then
					player_set_animation(player, "walk_mine", animation_speed_mod)
				else
					player_set_animation(player, "walk", animation_speed_mod)
				end
			elseif controls.LMB then
				player_set_animation(player, "mine")
			else
				player_set_animation(player, "stand", animation_speed_mod)
			end
		end
	end
end)

minetest.register_node(":newhand:hand", {
	description = "",
	tiles = {"player_singleplayer.png"},
	on_place = function(itemstack, placer, pointed_thing)
		local stack = ItemStack(":")
		local ret = minetest.item_place(stack, placer, pointed_thing)
		return ItemStack("newhand:hand "..itemstack:get_count())
	end,
	visual_scale = 1,
	wield_scale = {x=1,y=1,z=1},
	paramtype = "light",
	drawtype = "mesh",
	mesh = "hand.b3d",
	node_placement_prediction = "",
})

minetest.register_on_joinplayer(function(player)
	--player:get_inventory():set_stack("hand", 1, "newhand:hand")
end)