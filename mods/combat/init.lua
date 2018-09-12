local battlefields = {}

local active_battlefields = {}

local function create_battlefield(name, top, side, bottom)
    battlefields[name] = {
		visual = "mesh",
		mesh = "battlefield.x",
		textures = {
			top .. "^core_darken_circle.png",
			side .. "^core_darken.png^core_darken_circle.png",
			bottom .. "^core_darken.png^core_darken.png^core_darken_circle.png"
		},
		visual_size = {x=10, y=10},
		physical = true,
		collisionbox = {-7.5, -0.5, -8.5, 8.5, 0.5, 7.5},
		selectionbox = {-7.5, -0.5, -8.5, 8.5, 0.5, 7.5},
	}

	minetest.register_entity("combat:battlefield_" .. name, battlefields[name])
end

local high_tree = {
	visual = "mesh",
	mesh = "combat_high_tree_model.b3d",
	visual_size = {x=10, y=10},
	use_texture_alpha = true,
}

minetest.register_entity("combat:tree_cover", high_tree)

local low_plant = {
	visual = "mesh",
	mesh = "combat_low_plant.b3d",
	backface_culling = false,
	visual_size = {x=10, y=10},
}

minetest.register_entity("combat:plant_cover", low_plant)

local function battlefield_generator(battle_id, biome) -- battle_id refers entirely to the name of the person or creature that initiated the round
	local natural_low
	local natural_high
	local low_chance = 0
	local high_chance = 0

	if biome == "plains" then
		natural_low = "core_long_grass_2.png"
		low_chance = 7
		natural_high = "non_acacia"
		high_chance = 30
	end
	
	active_battlefields[battle_id] = {}
	active_battlefields[battle_id].biome = biome

	for x=1, 16 do
		active_battlefields[battle_id][x] = {} -- fucks given. 0
		for y=1, 16 do
			active_battlefields[battle_id][x][y] = {}

			active_battlefields[battle_id][x][y].model = "air"
			active_battlefields[battle_id][x][y].texture = "air"

			if math.random(1, low_chance) == 2 then
				active_battlefields[battle_id][x][y].model = "combat:plant_cover"
				active_battlefields[battle_id][x][y].texture = natural_low
			end

			if math.random(1, high_chance) == 2 then
				active_battlefields[battle_id][x][y].model = "combat:tree_cover"
				if natural_high == "non_acacia" then
					local randr = math.random(1, 3)
					if randr == 1 then
						active_battlefields[battle_id][x][y].texture = "combat_oak.png"
					elseif randr == 2 then
						active_battlefields[battle_id][x][y].texture = "combat_birch.png"
					else
						active_battlefields[battle_id][x][y].texture = "combat_cherry.png"
					end
				end
			end

			
		end
	end

end

local function destroy_battlefield(pos)

end

local function render_battlefield(battle_id, pos)
	-- todo, destroy old map here when done or re-rendering instead of abusing /clearobjects

	-- we want nice round numbers not shitty floating points
	local px = math.floor(pos.x)
	local py = math.floor(pos.y)
	local pz = math.floor(pos.z)

	minetest.add_entity({x=px, y=py, z=pz}, "combat:battlefield_" .. active_battlefields[battle_id].biome)

	for x=1, 16 do -- offset entity positions by uh -8 on x, and y * -1
		for y=1, 16 do
			if active_battlefields[battle_id][x][y].model ~= "air" then
				minetest.add_entity({x=(px - 8) + x, y=py, z=(pz - 9) + y}, active_battlefields[battle_id][x][y].model)
				local texel = minetest.get_objects_inside_radius({x=(px - 8) + x, y=py, z=(pz - 9) + y}, 0.05)
				texel[1]:set_properties({
					textures = {
						active_battlefields[battle_id][x][y].texture
					}
				})
				texel[1]:set_yaw((90*(math.pi/180))*math.random(1,4))
			end
		end
	end

end

create_battlefield("plains", "core_grass.png", "core_dirt.png^core_grass_side.png", "core_dirt.png")

minetest.register_chatcommand("test_battle", {
	
	description = "generates a test battlefield",
	param = "lol k",
	func = function(name, param)
		
		battlefield_generator(name .. "_testing", "plains")

		local player = minetest.get_player_by_name(name)

		local pos = player:get_pos()

		render_battlefield(name .. "_testing", pos)
	
		return true, "Battlefield generated."
	end,

})