bucket = {}

bucket.place = {} -- list of liquids to place

bucket.fill = {} -- list of liquids to loop over and set to air

bucket.name = {} -- list of bucket names to return after using the empty bucket


function bucket.give_filled(user, ltype)

	local inv = user:get_inventory()

	if inv:room_for_item("main", {name = ltype}) then
		inv:add_item("main", ltype)
	else
		local pos = user:getpos()
		pos.y = math.floor(pos.y + 0.5)
		core.add_item(pos, ltype)
	end
end


minetest.register_craftitem("bucket:bucket", {
	description = "Empty Bucket",
	inventory_image = "bucket_bucket.png",
	liquids_pointable = true,
	stack_max = 99,

	on_place = function(itemstack, user, pointed_thing)

		if pointed_thing.type ~= "node" then
			return
		end

		local pos = pointed_thing.under

		if minetest.is_protected(pos, user:get_player_name()) then
			minetest.record_protection_violation(pos, user:get_player_name())
			return itemstack
		end

		local stack_count = user:get_wielded_item():get_count()
		local return_item = itemstack

		for i = 1, bucket.count do

			if minetest.get_node(pos).name == bucket.fill[i] then

				return_item = bucket.name[i] .. " 1"

				if user:get_wielded_item():get_count() > 1 then

					bucket.give_filled(user, bucket.name[i])

					return_item = "bucket:bucket " .. tostring(stack_count - 1)

				end

				minetest.add_node(pos, {name = "air"})
			end

		end

		return ItemStack(return_item)
	end,
})


-- how to register a filled bucket:

--[[
	name (string) refers to the item name of the bucket, eg:
	"lava", "water", "decay_water", the after result will look like this, eg:
	"bucket:lava", "bucket:water", "bucket:decay_water"
	
	image (string) refers to the inventory image used to display the bucket, eg:
	"bucket_water.png" or "bucket_empty.png^water_overlay.png"
	
	liquid_source (string) is the node name of the liquid source block that the
	empty bucket should pick up, eg:
	"core:water_source", "core:lava_source", "core:acid_source"
	
	desc (string) is the description of the filled bucket, eg:
	"Lava Bucket", "Bucket of Water", "Bucket of Lava"
	
	to_place (string) is the node name of the water source that the bucket should place,
	eg: "core:water_source" "core:lava_source"
	
]]--


bucket.count = 0

function bucket.register_bucket(name, image, liquid_source, desc, to_place)

	bucket.count = bucket.count + 1

	bucket.fill[bucket.count] = liquid_source

	bucket.place[bucket.count] = to_place

	--bucket.name[bucket.count] = "bucket:"..name.."_bucket",
	bucket.name[bucket.count] = "bucket:bucket_" .. name,

	--minetest.register_craftitem("bucket:"..name.."_bucket", {
	minetest.register_craftitem("bucket:bucket_" .. name, {
		description = desc,
		inventory_image = image,
		stack_max = 1,
		liquids_pointable = true,

		on_place = function(itemstack, user, pointed_thing)

			if pointed_thing.type ~= "node" then
				return
			end

			local node = minetest.get_node_or_nil(pointed_thing.under)
			local npos
			local nodedef = minetest.registered_nodes[node.name]

			if nodedef and nodedef.on_rightclick and not user:get_player_control().sneak then
				return nodedef.on_rightclick(pointed_thing.under, node, user, itemstack)
			end

			if nodedef and nodedef.buildable_to then
				npos = pointed_thing.under
			else
				npos = pointed_thing.above
				node = minetest.get_node_or_nil(pointed_thing.above)

				local above_node = minetest.registered_nodes[node.name]

				if not above_node.buildable_to then
					return itemstack
				end
			end

			if minetest.is_protected(npos, user:get_player_name()) then
				minetest.record_protection_violation(npos, user:get_player_name())
				return itemstack
			end

			minetest.add_node(npos, {name = to_place})

			return ItemStack("bucket:bucket 1")
		end,
	})
end


bucket.register_bucket("water", "bucket_water.png", "core:water_source", "Bucket of Water", "core:water_source")