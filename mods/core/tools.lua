-- functions

mcore.mese_wear_level = {}

mcore.mese_wear_level[1] = 1024 --1024
mcore.mese_wear_level[2] = 2048 --2048
mcore.mese_wear_level[3] = 4096 -- 4096
mcore.mese_wear_level[4] = 8192 -- 8192
mcore.mese_wear_level[5] = 0 -- no change

mcore.mese_dig_spd_pick = {}

mcore.mese_dig_spd_pick[1] = { cracky = {times={[1]=9.00, [2]=4.00, [3]=1.50}, uses=mcore.mese_wear_level[1], maxlevel=0} }
mcore.mese_dig_spd_pick[2] = { cracky = {times={[1]=6.00, [2]=2.00, [3]=0.75}, uses=mcore.mese_wear_level[2], maxlevel=0} }
mcore.mese_dig_spd_pick[3] = { cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=mcore.mese_wear_level[3], maxlevel=0} }
mcore.mese_dig_spd_pick[4] = { cracky = {times={[1]=1.50, [2]=0.50, [3]=0.25}, uses=mcore.mese_wear_level[4], maxlevel=0} }
mcore.mese_dig_spd_pick[5] = { cracky = {times={[1]=1.00, [2]=0.25, [3]=0.12}, uses=mcore.mese_wear_level[5], maxlevel=0} }

mcore.mese_dig_spd_shovel = {}

mcore.mese_dig_spd_shovel[1] = { crumbly = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=mcore.mese_wear_level[1], maxlevel=0} }
mcore.mese_dig_spd_shovel[2] = { crumbly = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=mcore.mese_wear_level[2], maxlevel=0} }
mcore.mese_dig_spd_shovel[3] = { crumbly = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=mcore.mese_wear_level[3], maxlevel=0} }
mcore.mese_dig_spd_shovel[4] = { crumbly = {times={[1]=0.50, [2]=0.25, [3]=0.25}, uses=mcore.mese_wear_level[4], maxlevel=0} }
mcore.mese_dig_spd_shovel[5] = { crumbly = {times={[1]=0.25, [2]=0.25, [3]=0.12}, uses=mcore.mese_wear_level[5], maxlevel=0} }

mcore.mese_dig_spd_axe = {}

mcore.mese_dig_spd_axe[1] = {
							choppy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=mcore.mese_wear_level[1], maxlevel=0},
							snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=mcore.mese_wear_level[1], maxlevel=0},
						   }
						   
mcore.mese_dig_spd_axe[2] = {
							choppy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=mcore.mese_wear_level[2], maxlevel=0},
							snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=mcore.mese_wear_level[2], maxlevel=0},
						   }
						   
mcore.mese_dig_spd_axe[3] = {
							choppy = {times={[1]=1.00, [2]=0.50, [3]=0.50}, uses=mcore.mese_wear_level[3], maxlevel=0},
							snappy = {times={[1]=1.00, [2]=0.50, [3]=0.50}, uses=mcore.mese_wear_level[3], maxlevel=0},
						   }
						   
mcore.mese_dig_spd_axe[4] = {
							choppy = {times={[1]=0.50, [2]=0.25, [3]=1.00}, uses=mcore.mese_wear_level[4], maxlevel=0},
							snappy = {times={[1]=0.25, [2]=0.12, [3]=0.12}, uses=mcore.mese_wear_level[4], maxlevel=0},
						   }
						   
mcore.mese_dig_spd_axe[5] = {
							choppy = {times={[1]=0.25, [2]=0.25, [3]=0.25}, uses=mcore.mese_wear_level[5], maxlevel=0},
							snappy = {times={[1]=0.25, [2]=0.12, [3]=0.12}, uses=mcore.mese_wear_level[5], maxlevel=0},
						   }
						   
mcore.mese_dig_spd_sword = {}
						   
mcore.mese_dig_spd_sword[1] = { snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=mcore.mese_wear_level[1], maxlevel=0} }
mcore.mese_dig_spd_sword[2] = { snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=mcore.mese_wear_level[2], maxlevel=0} }
mcore.mese_dig_spd_sword[3] = { snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=mcore.mese_wear_level[3], maxlevel=0} }
mcore.mese_dig_spd_sword[4] = { snappy = {times={[1]=0.25, [2]=0.12, [3]=0.12}, uses=mcore.mese_wear_level[4], maxlevel=0} }
mcore.mese_dig_spd_sword[5] = { snappy = {times={[1]=0.25, [2]=0.12, [3]=0.12}, uses=mcore.mese_wear_level[5], maxlevel=0} }

-- calculating damage (for mese only);

-- pickaxe = sword damage / 2
-- shovel = sword damage / 2 - 2
-- axe = sword damage - 2

mcore.mese_dmg_sword = {}

mcore.mese_dmg_sword[1] = 4
mcore.mese_dmg_sword[2] = 4
mcore.mese_dmg_sword[3] = 6
mcore.mese_dmg_sword[4] = 8
mcore.mese_dmg_sword[5] = 10

-- calculating swing speeds (for mese only);

-- pickaxe = sword speed + 0.75
-- shovel = sword speed + 1.5
-- axe = sword speed + 0.5

mcore.mese_swing_speed = {}

mcore.mese_swing_speed[1] = 1.75
mcore.mese_swing_speed[2] = 1.25
mcore.mese_swing_speed[3] = 1.0
mcore.mese_swing_speed[4] = 0.75
mcore.mese_swing_speed[5] = 0.375

function mcore.give_mese_exp(itemstack, user, node, digparams)
	
	if itemstack:get_name() == "core:mese_pickaxe_5" or itemstack:get_name() == "core:mese_shovel_5" or itemstack:get_name() == "core:mese_axe_5" or itemstack:get_name() == "core:mese_sword_5" then
		
		itemstack:add_wear(digparams.wear)
        return itemstack

	end
	
	for i=1, 4 do

		if itemstack:get_name() == "core:mese_pickaxe_" .. i and itemstack:get_wear() == 0 then
			
			itemstack:set_name("core:mese_pickaxe_" .. i+1)
			
			if i ~= 4 then
			
				itemstack:set_wear(65535)
				
				minetest.sound_play("core_tool_levelling", {
				
					to_player = user:get_player_name(),
					gain = 6.0,
				
				})
				
			else
			
				--......
			
			end
		
			return itemstack
		
		elseif itemstack:get_name() == "core:mese_pickaxe_" .. i then
	
			local add_to = -65535 / mcore.mese_wear_level[i]

			itemstack:add_wear(add_to)
	
			return itemstack
		
		end
	
	end
end

function mcore.diamonds_are_forever(itemstack, user, node, digparams)

	print("meme")

end

local function register_mese_toolsets()

	for i=1, 5 do
	
		minetest.register_tool("core:mese_pickaxe_" .. i, {
		
			description = "MESE Pickaxe (Level " .. i .. ")",
			inventory_image = "core_mese_pickaxe_".. i .. ".png",
			tool_capabilities = {
			
				full_punch_interval = mcore.mese_swing_speed[i] + 0.75,
				
				max_drop_level = 0,
				
				groupcaps = mcore.mese_dig_spd_pick[i],
				
				damage_groups = mcore.mese_dmg_sword[i] / 2,
			},
			
			after_use = function(itemstack, user, node, digparams)
			
				mcore.give_mese_exp(itemstack, user, node, digparams)
			
			end,
		})
	
	end

end

register_mese_toolsets()

minetest.register_item(":", {
	type = "none",
	wield_image = "wieldhand.png",
	wield_scale = {x=1,y=3,z=4},
	tool_capabilities = {
		full_punch_interval = 0.25,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=6.00, [2]=3.00, [3]=1.50}, uses=0, maxlevel=1},
			snappy = {times={[3]=5.00}, uses=0, maxlevel=1},
			oddly_breakable_by_hand = {times={[1]=3.50,[2]=2.00,[3]=0.70}, uses=0},
			choppy = {times={[3]=6.00}, uses=0}
		},
		damage_groups = {fleshy=1},
	}
	
})

-- items

minetest.register_craftitem("core:clay_lump", {
	description = "Clay Lump",
	inventory_image = "core_clay_lump.png",
	wield_image = "core_clay_lump.png",
})

-- wood tier

minetest.register_tool("core:wooden_pickaxe", {
	description = "Wooden Pickaxe",
	inventory_image = "core_wooden_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		
		damage_groups = {fleshy=1},
	}
})

minetest.register_tool("core:wooden_shovel", {
	description = "Wooden Shovel",
	inventory_image = "core_wooden_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	}
})

minetest.register_tool("core:wooden_axe", {
	description = "Wooden Axe",
	inventory_image = "core_wooden_axe.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
			snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	}
	
})

minetest.register_tool("core:wooden_sword", {
	description = "Wooden Sword",
	inventory_image = "core_wooden_sword.png",
	tool_capabilities = {
		full_punch_interval = 0.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=4.00, [2]=2.00, [3]=1.00}, uses=0, maxlevel=0},
		},
		damage_groups = {fleshy=1},
	},
	
})

-- stone tier

minetest.register_tool("core:stone_pickaxe", {
	description = "Stone Pickaxe",
	inventory_image = "core_stone_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=6.00, [2]=2.00, [3]=0.75}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_shovel", {
	description = "Stone Shovel",
	inventory_image = "core_stone_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_axe", {
	description = "Stone Axe",
	inventory_image = "core_stone_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
			snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

minetest.register_tool("core:stone_sword", {
	description = "Stone Sword",
	inventory_image = "core_stone_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=2.00, [2]=1.00, [3]=0.50}, uses=128, maxlevel=0},
		},
		damage_groups = {fleshy=2},
	},
	
})

-- iron tier

minetest.register_tool("core:iron_pickaxe", {
	description = "Iron Pickaxe",
	inventory_image = "core_iron_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:iron_shovel", {
	description = "Iron Shovel",
	inventory_image = "core_iron_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:iron_axe", {
	description = "Iron Axe",
	inventory_image = "core_iron_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=1024, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:iron_sword", {
	description = "Iron Sword",
	inventory_image = "core_iron_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=6},
	},
	
})

-- ironze tier

minetest.register_tool("core:ironze_pickaxe", {
	description = "Ironze Pickaxe",
	inventory_image = "core_ironze_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=3.00, [2]=1.00, [3]=0.50}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:ironze_shovel", {
	description = "Ironze Shovel",
	inventory_image = "core_ironze_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:ironze_axe", {
	description = "Ironze Axe",
	inventory_image = "core_ironze_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
			snappy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=512, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:ironze_sword", {
	description = "Ironze Sword",
	inventory_image = "core_ironze_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=1.00, [2]=0.50, [3]=0.25}, uses=256, maxlevel=0},
		},
		damage_groups = {fleshy=6},
	},
	
})

-- diamond tier

minetest.register_tool("core:diamond_pickaxe", {
	description = "Diamond Pickaxe",
	inventory_image = "core_diamond_pickaxe.png",
	tool_capabilities = {
		full_punch_interval = 3.0,
		max_drop_level = 0,
		groupcaps = {
			cracky = {times={[1]=1.50, [2]=0.50, [3]=0.25}, uses=8192, maxlevel=0},
		},
		damage_groups = {fleshy=4},
	},
	
})

minetest.register_tool("core:diamond_shovel", {
	description = "Diamond Shovel",
	inventory_image = "core_diamond_shovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 4.0,
		max_drop_level = 0,
		groupcaps = {
			crumbly = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=8192, maxlevel=0},
		},
		damage_groups = {fleshy=3},
	},
	
})

minetest.register_tool("core:diamond_axe", {
	description = "Diamond Axe",
	inventory_image = "core_diamond_axe.png",
	tool_capabilities = {
		full_punch_interval = 2.0,
		max_drop_level = 0,
		groupcaps = {
			choppy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=8192, maxlevel=0},
			snappy = {times={[1]=0.25, [2]=0.12, [3]=0.06}, uses=8192*2, maxlevel=0},
		},
		damage_groups = {fleshy=5},
	},
	
})

minetest.register_tool("core:diamond_sword", {
	description = "Diamond Sword",
	inventory_image = "core_diamond_sword.png",
	tool_capabilities = {
		full_punch_interval = 2.5,
		max_drop_level = 0,
		groupcaps = {
			snappy = {times={[1]=0.50, [2]=0.25, [3]=0.12}, uses=8192, maxlevel=0},
		},
		damage_groups = {fleshy=8},
	},
	
})