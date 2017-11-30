-- AutoBlockBreaker mod by sfan5

minetest.register_craft({
    output = 'autoblockbreaker:breaker',
    recipe = {
        {'default:cobble', 'default:wood', 'default:cobble'},
        {'default:cobble', 'default:cobble', "default:pick_stone"},
        {'default:cobble', 'default:cobble', 'default:cobble'},
    },
})

local autoblockbreaker_texture = "default_cobble.png^(default_wood.png^[mask:autoblockbreaker_mask.png)"

minetest.register_node("autoblockbreaker:breaker", {
	tiles = {autoblockbreaker_texture .. "^autoblockbreaker_off.png", "default_cobble.png", "default_cobble.png",
		"default_cobble.png", "default_cobble.png", "default_cobble.png^autoblockbreaker_drill.png"},
	paramtype2 = "facedir",
	description = "Auto Block Breaker",
	groups = {cracky=2},
	on_construct = function(pos)
		minetest.get_meta(pos):set_string("infotext", "Auto Block Breaker (disabled)")
	end,
	on_punch = function(pos, node, puncher)
		node.name = "autoblockbreaker:breaker_on"
		minetest.set_node(pos, node)
		minetest.get_meta(pos):set_string("infotext", "Auto Block Breaker (enabled)")
	end,
})

minetest.register_node("autoblockbreaker:breaker_on", {
	tiles = {
		autoblockbreaker_texture .. "^autoblockbreaker_on.png", "default_cobble.png", "default_cobble.png",
		"default_cobble.png", "default_cobble.png",
		{
			image = "[combine:16x32:0,0=default_cobble.png:0,16=default_cobble.png^autoblockbreaker_drill_animated.png",
			backface_culling = false,
			animation = {
				type = "vertical_frames",
				aspect_w = 16,
				aspect_h = 16,
				length = 1
			},
		},
	},
	paramtype2 = "facedir",
	groups = {cracky=2},
	on_punch = function(pos, node, puncher)
		node.name = "autoblockbreaker:breaker"
		minetest.set_node(pos, node)
		minetest.get_meta(pos):set_string("infotext", "Auto Block Breaker (disabled)")
	end,
	drop = "autoblockbreaker:breaker",
})

minetest.register_abm({
	nodenames = {"autoblockbreaker:breaker_on"},
	interval = 1.25,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		local p = pos
		local p2 = minetest.facedir_to_dir(node.param2)
		p = {x=p.x - p2.x, y=p.y, z=p.z - p2.z}
		p2 = nil
		local n = minetest.get_node(p)
		if n.name == "air" or n.name == "ignore" then return end
		minetest.remove_node(p)
		nodeupdate(p)
		local drops = minetest.get_node_drops(n.name, "default:pick_stone")
		local haschest = (minetest.get_node({x=pos.x, y=pos.y-1, z=pos.z}).name == "default:chest")
		for _, drop in ipairs(drops) do
			if haschest then
			    minetest.get_meta({x=pos.x, y=pos.y-1, z=pos.z}):get_inventory():add_item("main", drop)
			else
			    minetest.add_item({x=pos.x, y=pos.y+1, z=pos.z}, drop)
			end
		end
	end,
})
