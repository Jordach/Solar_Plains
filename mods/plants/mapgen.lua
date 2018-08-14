-- bunch flowers into groups to save on pain, grants the same colour, but prevents easy access to all plants

-- red

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:red_rose", "plants:geranium", "plants:poppy"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- orange

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:orange_tulip", "plants:million_bells", "plants:stellar_daisy"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- yelow

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:daffodil", "plants:starflower", "plants:peonie"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- green

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:carnation", "plants:bells_of_terra", "plants:daylilly"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest", "highlands", "jungle"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- blue

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:bluebells", "plants:lily_of_the_dream", "plants:angelface"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest", "highlands"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- violet

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:violet", "plants:pansy", "plants:crocus"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest", "jungle"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- pink / cherry

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:lilac", "plants:allium", "plants:camellia"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest", "jungle"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- white


minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:dandelion", "plants:yarrow", "plants:snapdragon"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})

-- black

minetest.register_decoration({
	deco_type = "simple",
	place_on = "core:grass",
	decoration = {"plants:hellebore", "plants:black_rose", "plants:daylia"},
	sidelen = 80,
	fill_ratio = 0.001,
	biomes = {"plains", "plains_forest", "highlands"},
	height = 1,
	param2 = mcore.options("cross", true, true, false),
})