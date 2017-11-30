--solarinfuser, a neat and fancy energy mod

-- namespacing, as per usual.

solarinfuser = {}

-- create the pipe nodeboxes

solarinfuser.pipe_middle = {-0.125, -0.125, -0.125, 0.125, 0.125, 0.125} -- Core

solarinfuser.pipe_south = {

	{-0.125, -0.125, 0.125, 0.125, 0.125, 0.5}, -- PipeNorth
	--{-0.1875, -0.1875, 0.3125, 0.1875, 0.1875, 0.375}, -- RingNorth
	--{-0.1875, -0.1875, 0.375, 0.1875, 0.1875, 0.5}, -- ConnectorNorth
}

solarinfuser.pipe_east = {
	
	{0.125, -0.125, -0.125, 0.5, 0.125, 0.125}, -- PipeEast
	--{0.3125, -0.1875, -0.1875, 0.375, 0.1875, 0.1875}, -- RingEast
	--{0.375, -0.1875, -0.1875, 0.5, 0.1875, 0.1875}, -- ConnectorEast
}

solarinfuser.pipe_north = {

	{-0.125, -0.125, -0.5, 0.125, 0.125, -0.125}, -- PipeSouth
	--{-0.1875, -0.1875, -0.375, 0.1875, 0.1875, -0.3125}, -- RingSouth
	--{-0.1875, -0.1875, -0.5, 0.1875, 0.1875, -0.375}, -- ConnectorSouth
}

solarinfuser.pipe_west = {
	
	{-0.5, -0.125, -0.125, -0.125, 0.125, 0.125}, -- PipeWest
	--{-0.375, -0.1875, -0.1875, -0.3125, 0.1875, 0.1875}, -- RingWest
	--{-0.5, -0.1875, -0.1875, -0.375, 0.1875, 0.1875}, -- ConnectorWest
	
}

solarinfuser.pipe_top = {

	{-0.125, 0.125, -0.125, 0.125, 0.5, 0.125}, -- PipeTop
	--{-0.1875, 0.3125, -0.1875, 0.1875, 0.375, 0.1875}, -- RingTop	
	--{-0.1875, 0.375, -0.1875, 0.1875, 0.5, 0.1875}, -- ConnectorTop
}

solarinfuser.pipe_bottom = {

	{-0.125, -0.5, -0.125, 0.125, -0.125, 0.125}, -- PipeBottom
	--{-0.1875, -0.375, -0.1875, 0.1875, -0.3125, 0.1875}, -- RingBottom
	--{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, -- ConnectorBottom
}

minetest.register_node("solarinfusion:pipe", {
	tiles = { "solarcatcher_pipe.png" },
	drawtype = "nodebox",
	paramtype = "light",
	
	node_box = {
	
		type = "connected",
		
		fixed = solarinfuser.pipe_middle,
		
		connect_front = solarinfuser.pipe_north,
		connect_right = solarinfuser.pipe_east,
		connect_back = solarinfuser.pipe_south,
		connect_left = solarinfuser.pipe_west,
		connect_top = solarinfuser.pipe_top,
		connect_bottom = solarinfuser.pipe_bottom,
	
	},
	
	connects_to = {"core:furnace", "solarinfusion:pipe"},
	groups = {oddly_breakable_by_hand = 2},
	sunlight_propagates = true,
	
})