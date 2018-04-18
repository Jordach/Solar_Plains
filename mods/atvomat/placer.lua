-- placer.lua, part of atvomat, solar plains

atvomat.placer_blacklist = {}

-- depend on this mod and in your own mod, write atvomat.placer_blacklist["node:name"] = ""
-- it doesn't matter what value the key value contains, it's just better that the key value exists, so that looping through
-- atvomat.placer_blacklist is considerably easier than say having to filter through hundreds of potential values derived from keys

-- actual blacklist starts here:

atvomat.placer_blacklist["core:chest"] = ""
atvomat.placer_blacklist["core:chest_locked"] = ""
atvomat.placer_blacklist["core:lava_source"] = ""
atvomat.placer_blacklist["core:lava_flowing"] = ""
atvomat.placer_blacklist["core:water_source"] = ""
atvomat.placer_blacklist["core:water_flowing"] = ""
atvomat.placer_blacklist["core:furnace"] = ""
atvomat.placer_blacklist["core:furnace_active"] = ""
atvomat.placer_blacklist["air"] = ""
atvomat.placer_blacklist["ignore"] = ""
atvomat.placer_blacklist["atvomat:breaker_1"] = ""
atvomat.placer_blacklist["atvomat:breaker_2"] = ""
atvomat.placer_blacklist["atvomat:placer"] = ""
atvomat.placer_blacklist["atvomat:sorter"] = ""
atvomat.placer_blacklist["atvomat:mover"] = ""

-- note, if you're implementing your own mod with node meta, or similar, feel free to blacklist them so that the placer will refuse
-- any nodes with meta. in future - i could probably do this with a custom node field.

local at_placer = "size[8,9]" ..
    "list[current_name;main;2.5,0;3,3]" ..
    "list[current_player;main;0,4.5;8,1;]" ..
    "list[current_player;main;0,6;8,3;8]" ..
    "listring[current_name;main]" ..
	"listring[current_player;main]" ..
	"background[-0.45,-0.5;8.9,10;atvomat_placer_interface.png]"..
    "listcolors[#3a4466;#8b9bb4;#ffffff;#4e5765;#ffffff]"

local function place_block(pos, elapsed)

    local inv = minetest.get_meta(pos):get_inventory()

    local fpos = mcore.get_node_from_front(table.copy(pos)) -- lets get the position for the node where the targeter is

    if minetest.get_node_or_nil(fpos).name == nil then return true end
    if minetest.get_node_or_nil(fpos).name ~= "air" then return true end    

    if minetest.get_node_or_nil(fpos).name == "air" then
        
        for i=1,9 do

            local stack = inv:get_stack("main", i)
            local stackname = stack:get_name()
            
            if stackname ~= "" then

                -- let's check if the node is blacklisted or not

                for k, v in pairs(atvomat.placer_blacklist) do
                
                    minetest.chat_send_all("stackname: " .. stackname)
                    minetest.chat_send_all("blacklist: " .. k)

                    if stackname == k then

                        local meta = minetest.get_meta(pos)

                        meta:set_string("infotext", "Auto Block Placer, ERROR, please remove:\n" .. minetest.registered_items[stackname]["description"] .. " (" .. stackname .. ")\nfrom the inventory.\nPunch twice to restart.")
                        
                        return false

                    end

                end

                minetest.add_node(fpos, {name=stackname})
                minetest.get_meta(pos):set_string("infotext", "Auto Block Placer, Enabled.")
                return true

            end

        end

    end

end

minetest.register_node("atvomat:placer", {

    description = "Placer (Target is highlighted)",
    drawtype = "mesh",
    tiles = {"atvomat_breaker_t1_body.png"},
    mesh = "atvomat_breaker.b3d",

    paramtype2 = "facedir",
	
	sounds = mcore.sound_metallic,
	
	on_place = mcore.rotate_axis,
	
	groups = {oddly_breakable_by_hand=2},
	
	on_construct = function(pos)
	
		local meta = minetest.get_meta(pos)
		
		meta:set_string("infotext", "Auto Block Placer, Disabled.")
		
		meta:set_string("formspec", at_placer)
		local inv = meta:get_inventory()
		inv:set_size("main", 9)
				
		minetest.get_node_timer(pos):start(1)
		
	end,
	
	on_timer = place_block,
    
    on_punch = function(pos, node, puncher)

        local meta = minetest.get_meta(pos)
            
        if meta:get_string("active") == "false" then
            
            meta:set_string("active", "true")
            minetest.get_node_timer(pos):start(1)			
            meta:set_string("infotext", "Auto Block Placer, Enabled.")
                
        else
            
            meta:set_string("active", "false")
            minetest.get_node_timer(pos):stop()
            meta:set_string("infotext", "Auto Block Placer, Disabled.")
                
        end
    
    end,

})