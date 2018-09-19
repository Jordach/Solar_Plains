minetest.register_node("plants:daisy", {
	description = "Daisy Patch",
	tiles = {"plants_daisys.png"},
	drawtype = "mesh",
	mesh = "planar_flower.b3d",
	groups = {snappy=3, flora=1, attached_node=1},
	--use_texture_alpha = true,
	paramtype = "light",
	buildable_to = true,
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -5/16, 0.5},
	},
	sounds = mcore.sound_plants,
})

-- register global dyes
-- notes: use flowerbeds for registering the nicer looking farmable flowers.
-- these are registered as :dye:colour

minetest.register_craftitem(":dye:red", {

	description = "Red Dye",
	inventory_image = "dye_red.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:brown", {

	description = "Brown Dye",
	inventory_image = "dye_brown.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:yellow", {

	description = "Yellow Dye",
	inventory_image = "dye_yellow.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:orange", {

	description = "Orange Dye",
	inventory_image = "dye_orange.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:green", {

	description = "Green Dye",
	inventory_image = "dye_green.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:dark_green", {

	description = "Dark Green Dye",
	inventory_image = "dye_dark_green.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:cyan", {

	description = "Cyan Dye",
	inventory_image = "dye_cyan.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:sky_blue", {

	description = "Sky Blue Dye",
	inventory_image = "dye_sky_blue.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:sea_blue", {

	description = "Sea Blue Dye",
	inventory_image = "dye_sea_blue.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:cherry", {

	description = "Cherry Dye",
	inventory_image = "dye_cherry.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:purple", {

	description = "Purple Dye",
	inventory_image = "dye_purple.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:violet", {

	description = "Violet Dye",
	inventory_image = "dye_violet.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:white", {

	description = "White Dye",
	inventory_image = "dye_white.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:light_grey", {

	description = "Light Grey Dye",
	inventory_image = "dye_light_grey.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:dark_grey", {

	description = "Dark Grey Dye",
	inventory_image = "dye_dark_grey.png",
	groups = {dye = 1},

})

minetest.register_craftitem(":dye:black", {

	description = "Black Dye",
	inventory_image = "dye_black.png",
	groups = {dye = 1},

})

-- plants, wild;
-- sorted by colour as described by solar_plains/issue#6

-- todo, write a decent handler for uh, placing plants easier

-- red

minetest.register_node("plants:red_rose", {
	description = "Red Rose",
	tiles = {"plants_rose_red.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,

})

minetest.register_node("plants:geranium", {
	description = "Geranium",
	tiles = {"plants_geranium.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:poppy", {
	description = "Poppy",
	tiles = {"plants_poppy.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- orange

minetest.register_node("plants:orange_tulip", {
	description = "Orange Tulip",
	tiles = {"plants_orange_tulip.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:million_bells", {
	description = "Million Bells",
	tiles = {"plants_million_bells.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:stellar_daisy", { -- african daisy
	description = "Stellar Daisy",
	tiles = {"plants_stellar_daisy.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- yellow

minetest.register_node("plants:daffodil", {
	description = "Daffodil",
	tiles = {"plants_daffodil.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:starflower", { -- note - use custom mesh, realname sunflower
	description = "Starflower",
	tiles = {"plants_starflower.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:peonie", {
	description = "Yellow Peonie",
	tiles = {"plants_peonie.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- green

minetest.register_node("plants:carnation", {
	description = "Carnation",
	tiles = {"plants_carnation.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:bells_of_terra", { -- real name: bells of ireland
	description = "Bells of Terra",
	tiles = {"plants_bells_of_terra.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:daylilly", {
	description = "Daylilly",
	tiles = {"plants_daylilly.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- blue

minetest.register_node("plants:bluebells", {
	description = "Bluebells",
	tiles = {"plants_bluebells.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:lily_of_the_dream", { --real name, lily of the nile
	description = "Lily of the Dream",
	tiles = {"plants_lily_of_the_dream.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:angelface", {
	description = "Angelface",
	tiles = {"plants_angelface.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- violet

minetest.register_node("plants:violet", {
	description = "Violet",
	tiles = {"plants_violet.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:pansy", {
	description = "Pansy",
	tiles = {"plants_pansy.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:crocus", {
	description = "Crocus",
	tiles = {"plants_crocus.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- pink / cherry

minetest.register_node("plants:lilac", {
	description = "Lilac",
	tiles = {"plants_lilac.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:allium", {
	description = "Allium",
	tiles = {"plants_allium.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:camellia", {
	description = "Camellia",
	tiles = {"plants_camellia.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- white

minetest.register_node("plants:dandelion", {
	description = "Dandelion",
	tiles = {"plants_dandelion.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:yarrow", {
	description = "Yarrow",
	tiles = {"plants_yarrow.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:snapdragon", {
	description = "Snapdragon",
	tiles = {"plants_snapdragon.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- black

minetest.register_node("plants:black_rose", {
	description = "Black Rose",
	tiles = {"plants_rose_black.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:hellebore", {
	description = "Hellebore",
	tiles = {"plants_hellebore.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

minetest.register_node("plants:daylia", {
	description = "Daylia",
	tiles = {"plants_daylia.png"},
	waving = 1,
	drawtype = "plantlike",
	paramtype = "light",
	paramtype2 = "meshoptions",
	walkable = false,
	buildable_to = true,
	sunlight_propagates = true,
	groups = {attached_node=1, snappy=3},
	selection_box = {
			type = "fixed",
			fixed = {-0.25, -0.5, -0.25, 0.25, -5/16, 0.25},
	},
	sounds = mcore.sound_plants,
	on_place = function(itemstack, placer, pointed_thing)
		local ret = minetest.item_place_node(itemstack, placer, pointed_thing, mcore.options("cross", true, true, false))
		return itemstack
	end,
})

-- create a mapgen file to handle mapgen for these flowers;
-- also handle crafting for plant -> seed + petals
dofile(minetest.get_modpath("plants").."/mapgen.lua")
dofile(minetest.get_modpath("plants").."/crafting.lua")