-- naturum
-- replacement for farming_plus
-- License: what's a license

-- register you plants here:

-- information about registering your plants:

--[[

	time is the time in seconds for the current plant stage to grow
	chance is the random chance for the plant to grow when the timer is called
	current_node is the node that will be going from a to b
	time_next is the time in seconds for the next plant stage to grow
	next_node is the node that the plant will grow into
	farm_dry is the node that the plant will need to be watered
	farm_wet is the nodes below the plant that might be valid for it to grow,
	farm_wet is the node that the plant will grow on without issues
	drink is a bool whether wet soil is enough to grow the plant
]]--

local function emit_particle(p_texture, p_pos)
	minetest.add_particle({
		pos = {
			x = p_pos.x + (math.random(-5, 5) / 100),
			y = (p_pos.y + 0.35) + (math.random(-15, 5) / 100),
			z = p_pos.z + (math.random(-5, 5) / 100),
		},
		vel = {
			x = 0.0,
			y = math.random(13, 19) / 100,
			z = 0.0,
		},
		expirationtime = math.random(8, 12) / 10,
		size = math.random(175, 225) / 100,
		collisiondetection = true,
		texture = p_texture,
		glow = 8,
	})
end

function naturum.plant_grow_stage(time, chance, current_node, time_next, next_node, farm_dry, farm_wet, drink)
	-- override nodes here:
	minetest.override_item(current_node, {
		on_timer = function(pos, elapsed)
			-- grow to next plant
			if chance == 1 or math.random(1, chance) == 1 then
				local can_grow = false
				
				-- check for light
				if minetest.get_node_light(pos) < 8 then
					emit_particle("naturum_light.png^naturum_question.png", pos)
					return true
				end

				local f_pos = table.copy(pos)
				f_pos.y = f_pos.y - 1
				local farm = minetest.get_node(f_pos)

				if farm.name == farm_dry then
					emit_particle("bucket_water.png^naturum_question.png", pos)
					return true
				elseif farm.name == farm_dry and drink then
					can_grow = true
					minetest.set_node({x = pos.x, y = pos.y-1, z = pos.z}, {name = farm_dry})
					local timer = minetest.get_node_timer({x = pos.x, y = pos.y-1, z = pos.z})
					timer:start(55+math.random(-20, 20))
				elseif farm.name == farm_wet then
					can_grow = true
					minetest.set_node({x = pos.x, y = pos.y-1, z = pos.z}, {name = farm_dry})
					local timer = minetest.get_node_timer({x = pos.x, y = pos.y-1, z = pos.z})
					timer:start(55+math.random(-20, 20))
				else
					emit_particle("farming_tool_steelhoe.png^naturum_question.png", pos)
				end
				
				if can_grow then
					minetest.swap_node(pos, {name = next_node}) --keeps param2 btw
					local timer = minetest.get_node_timer(pos)
					timer:start(time_next+math.random(-20, 20))
					return true
				end
			end

			return true
		end,
	})
end