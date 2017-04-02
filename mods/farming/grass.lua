
for i = 1, 3 do

	-- Override default grass and have it drop Wheat Seeds

	minetest.override_item("core:grass_" .. i, {
		drop = {
			max_items = 1,
			items = {
				{items = {'farming:seed_wheat'}, rarity = 5},
				{items = {'farming:seed_barley'}, rarity = 6},
				{items = {'farming:seed_cotton'}, rarity = 8},
				{items = {'core:grass_1'}},
			}
		},
	})
end