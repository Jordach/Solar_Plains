-- GENERATED CODE
-- Node Box Editor, version 0.8.1 - Glass
-- Namespace: test

minetest.register_node("test:node_1", {
	tiles = {
		"solarcatcher_pipe.png",
		"solarcatcher_pipe.png",
		"solarcatcher_pipe.png",
		"solarcatcher_pipe.png",
		"solarcatcher_pipe.png",
		"solarcatcher_pipe.png"
	},
	drawtype = "nodebox",
	paramtype = "light",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.1875, -0.1875, 0.375, 0.1875, 0.1875, 0.5}, -- ConnectorNorth
			{-0.1875, -0.1875, -0.5, 0.1875, 0.1875, -0.375}, -- ConnectorSouth
			{0.375, -0.1875, -0.1875, 0.5, 0.1875, 0.1875}, -- ConnectorEast
			{-0.5, -0.1875, -0.1875, -0.375, 0.1875, 0.1875}, -- ConnectorWest
			{-0.1875, 0.375, -0.1875, 0.1875, 0.5, 0.1875}, -- ConnectorTop
			{-0.1875, -0.5, -0.1875, 0.1875, -0.375, 0.1875}, -- ConnectorBottom
		}
	}
})

