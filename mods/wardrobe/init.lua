-- how to add your own textures to the wardrobe;

--[[

Make sure your textures are in greyscale, eg, from black to white in 0-255 steps

The engine prefers this colour as it is easier to look right once a player has
set their colour preferences for a specific piece of clothing.

The only non-colourable texture is the mouth, as that either lightly shades the mouth area or 

Textures that can be added to the wardrobe;

wardrobe_under_shirt_[number].png
wardrobe_shirt_[number].png
wardrobe_socks_[number].png
wardrobe_shoes_[number].png
wardrobe_leggings_[number].png
wardrobe_trousers_[number].png
wardrobe_hair_[number].png
wardrobe_eyes_white_[number].png 
wardrobe_eyes_pupil_[number].png
wardrobe_mouth_[number].png
wardrobe_acc_[number].png


]]--

-- wardrobe vars

wardrobe = {}

wardrobe.texture_path = minetest.get_modpath("wardrobe").."/textures/"

wardrobe.player_materials = {}

wardrobe.formspec_selections = {}
wardrobe.formspec_selections_rgb = {}

--clothing

wardrobe.undershirts = 1
wardrobe.shirts = 1
wardrobe.under_trousers = 1
wardrobe.trousers = 1
wardrobe.socks = 1
wardrobe.shoes = 1
wardrobe.accessories = 1

--biological features

wardrobe.mouth_parts = 1
wardrobe.hair_styles = 1
wardrobe.eyes = 1
wardrobe.pupils = 1

-- load textures (indented to show it's a hybrid of a function and a loop)

--logic will always overcount by ONE, unless the total is exactly ONE, 
--however, there will always be a minimum of TWO textures.
	
	-- under shirts
	
	local f
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_under_shirt_"..wardrobe.undershirts..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.undershirts = wardrobe.undershirts + 1
	end
	wardrobe.undershirts = wardrobe.undershirts - 1
	print ("[Wardrobe]: "..wardrobe.undershirts.." Under Shirts detected")
	
	-- shirts
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_shirt_"..wardrobe.shirts..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.shirts = wardrobe.shirts + 1
	end
	wardrobe.shirts = wardrobe.shirts - 1
	print ("[Wardrobe]: "..wardrobe.shirts.." Over Shirts detected")
	
	-- trousers / leggings
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_leggings_"..wardrobe.under_trousers..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.under_trousers = wardrobe.under_trousers + 1
	end
	wardrobe.under_trousers = wardrobe.under_trousers - 1
	print ("[Wardrobe]: "..wardrobe.under_trousers.." Pair(s) of Leggings detected")
	
	-- overalls / "trousers"
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_trousers_"..wardrobe.trousers..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.trousers = wardrobe.trousers + 1
	end
	wardrobe.trousers = wardrobe.trousers - 1
	print ("[Wardrobe]: "..wardrobe.trousers.." Pair(s) of Trousers detected")
	
	-- socks
	
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_socks_"..wardrobe.socks..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.socks = wardrobe.socks + 1
	end
	wardrobe.socks = wardrobe.socks - 1
	print ("[Wardrobe]: "..wardrobe.socks.." Pair(s) of Socks detected")
	
	-- shoes
	
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_shoes_"..wardrobe.shoes..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.shoes = wardrobe.shoes + 1
	end
	wardrobe.shoes = wardrobe.shoes - 1
	print ("[Wardrobe]: "..wardrobe.shoes.." Pair(s) of Shoes detected")
	
	-- accessories
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_acc_"..wardrobe.accessories..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.accessories = wardrobe.accessories + 1
	end
	wardrobe.accessories = wardrobe.accessories - 1
	print ("[Wardrobe]: "..wardrobe.accessories.." Accessories detected")
	
	-- hair
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_hair_"..wardrobe.hair_styles..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.hair_styles = wardrobe.hair_styles + 1
	end
	wardrobe.hair_styles = wardrobe.hair_styles - 1
	print ("[Wardrobe]: "..wardrobe.hair_styles.." Hair Styles detected")
	
	-- eyes & pupils
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_eyes_white_"..wardrobe.eyes..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.eyes = wardrobe.eyes + 1
	end
	wardrobe.eyes = wardrobe.eyes - 1
	print ("[Wardrobe]: "..wardrobe.eyes.." Eye Whites detected")
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_eyes_pupil_"..wardrobe.pupils..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.pupils = wardrobe.pupils + 1
	end
	wardrobe.pupils = wardrobe.pupils - 1
	print ("[Wardrobe]: "..wardrobe.pupils.." Eye Pupils detected")
	
	-- mouth
	
	while true do
	
		f = io.open(wardrobe.texture_path.."wardrobe_mouth_"..wardrobe.mouth_parts..".png")
		if not f then break end
		
		f:close()
		
		wardrobe.mouth_parts = wardrobe.mouth_parts + 1
	end
	wardrobe.mouth_parts = wardrobe.mouth_parts - 1
	print ("[Wardrobe]: "..wardrobe.mouth_parts.." Mouth Overlays detected")
	
-- test dummy 

minetest.register_entity("wardrobe:dummy", {
	collisionbox = {0,0,0,0,0,0},
	
	visual = "mesh",
	mesh = "wardrobe_dummy.x",
	textures = {
				"ptextures_transparent.png", 
				"(wardrobe_skin.png^[multiply:#ffffff)",
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png"
	},
	visual_size = {x=1, y=1},
})

function wardrobe.formspec_meta(texture_table, rgb_table )
			
			--[[ texture ID's (21 vars)
			eye, 
			hair,
			mouth,
			ushirt, ushirt2,
			utrou, utrou2, 
			socks, socks2, 
			jacket, jacket2,
			trous, trous2,
			shoes, shoes2,
			acc1, acc2, acc3, acc4, acc5, acc6,
			-- RGB colours (22 vars)
			skinrgb,
			eyergb,
			pupilrgb,
			hairrgb,
			ushirtrgb, ushirt2rgb,
			utrourgb, utrou2rgb, 
			socksrgb, socks2rgb, 
			jacketrgb, jacket2rgb,
			trousrgb, trous2rgb,
			shoesrgb, shoes2rgb,
			acc1rgb, acc2rgb, acc3rgb, acc4rgb, acc5rgb, acc6rgb
			)
				]]-- notice - old varnames

	local formspec = 
		
		"size[15,11]"..
		
		-- Skin Tone setting
		"label[0,0.15;Skin Tone:]"..
		"field[2,0.3;3.22,1;skintone;;"..rgb_table[1].."]".. --//
		--
		
		-- Eye White (Schelra Colouring and Eye Styling)
		"label[0,1.0;Eye Type and]"..
		"label[0,1.38;Eye Colour:]"..
		"button[1.7,1;1,1;eyedown;<-]".. --\\
		"field[2.75,1.32;1.75,1;ewhite;;"..rgb_table[2].."]".. --//
		"button[3.97,1;1,1;eyeup;->]"..  --\\
		--
		
		-- Pupil Colours
		-- Eye White (Schelra Colouring and Eye Styling)
		"label[0,2.0;Pupil Style &]"..
		"label[0,2.38;Pupil Colour:]"..
		"button[1.7,2;1,1;pupdown;<-]".. --\\
		"field[2.75,2.32;1.75,1;pcolour;;"..rgb_table[3].."]".. --//
		"button[3.97,2;1,1;pupup;->]"..  --\\
		--
		
		-- Hair styling and dyes, not only just to look good...or bald.
		"label[0,3;Hair Style and]"..
		"label[0,3.38;Hair Colour:]"..
		"button[1.7,3;1,1;hairdown;<-]".. --\\
		"field[2.75,3.32;1.75,1;hairdye;;"..rgb_table[4].."]".. --//
		"button[3.97,3;1,1;hairup;->]"..  --\\
		--
		
		-- Mouth Shape, not coloured - but for those who want to eat...or wanting to scream
		"label[0, 4.18;Mouth Shape:]"..
		"button[1.7,4;1.5,1;mouthdown;<-]".. --\\
		"button[3.47,4;1.5,1;mouthup;->]"..  --\\
		--
		
		-- Under Shirt Layer 1
		"label[0, 5;Under Shirt]"..
		"label[0, 5.38;Layer 1:]"..
		"button[1.7,5;1,1;ushirtdown;<-]".. --\\
		"field[2.75,5.32;1.75,1;undshirt;;"..rgb_table[5].."]".. --//
		"button[3.97,5;1,1;ushirtup;->]"..  --\\
		--
		
		-- Under Shirt Layer 2
		"label[0, 6;Under Shirt]"..
		"label[0, 6.38;Layer 2:]"..
		"button[1.7,6;1,1;ushirtdown2;<-]".. --\\
		"field[2.75,6.32;1.75,1;undshirt2;;"..rgb_table[6].."]".. --//
		"button[3.97,6;1,1;ushirtup2;->]"..  --\\
		--
		
		-- Leggings Layer 1
		"label[0, 7;Leggings]"..
		"label[0, 7.38;Layer 1:]"..
		"button[1.7,7;1,1;leggdown;<-]".. --\\
		"field[2.75,7.32;1.75,1;leggings;;"..rgb_table[7].."]".. --//
		"button[3.97,7;1,1;leggup;->]"..  --\\
		--
		
		-- Leggings Layer 2
		"label[0, 8;Leggings]"..
		"label[0, 8.38;Layer 2:]"..
		"button[1.7,8;1,1;leggdown2;<-]".. --\\
		"field[2.75,8.32;1.75,1;leggings2;;"..rgb_table[8].."]".. --//
		"button[3.97,8;1,1;leggup2;->]"..  --\\
		--
		
		-- Socks Layer 1
		"label[0, 9;Socks]"..
		"label[0, 9.38;Layer 1:]"..
		"button[1.7,9;1,1;sockdown;<-]".. --\\
		"field[2.75,9.32;1.75,1;socks;;"..rgb_table[9].."]".. --//
		"button[3.97,9;1,1;sockup;->]"..  --\\	
		--
		
		-- Socks Layer 1
		"label[0, 10;Socks]"..
		"label[0, 10.38;Layer 2:]"..
		"button[1.7,10;1,1;sockdown2;<-]".. --\\
		"field[2.75,10.32;1.75,1;socks2;;"..rgb_table[10].."]".. --//
		"button[3.97,10;1,1;sockup2;->]"..  --\\	
		--
		
		-- Shirt Layer 1
		"label[5,0;Over Shirt]"..
		"label[5,0.38;Layer 1:]"..
		"button[6.7,0;1,1;topshirtdown;<-]".. --\\
		"field[7.75,0.32;1.75,1;topshirt;;"..rgb_table[11].."]".. --//
		"button[8.97,0;1,1;topshirtup;->]"..  --\\
		--
		
		-- Shirt Layer 2
		"label[5,1;Over Shirt]"..
		"label[5,1.38;Layer 2:]"..
		"button[6.7,1;1,1;topshirtdown2;<-]".. --\\
		"field[7.75,1.32;1.75,1;topshirt2;;"..rgb_table[12].."]".. --//
		"button[8.97,1;1,1;topshirtup2;->]"..  --\\
		--
		
		-- Trousers Layer 1
		"label[5,2;Trousers]"..
		"label[5,2.38;Layer 2:]"..
		"button[6.7,2;1,1;troudown;<-]".. --\\
		"field[7.75,2.32;1.75,1;trousers;;"..rgb_table[13].."]".. --//
		"button[8.97,2;1,1;trouup;->]"..  --\\
		--
		
		-- Trousers Layer 2
		"label[5,3;Trousers]"..
		"label[5,3.38;Layer 2:]"..
		"button[6.7,3;1,1;troudown2;<-]".. --\\
		"field[7.75,3.32;1.75,1;trousers2;;"..rgb_table[14].."]".. --//
		"button[8.97,3;1,1;trouup2;->]"..  --\\
		--
		
		-- Shoes Layer 1
		"label[5,4;Shoes]"..
		"label[5,4.38;Layer 1:]"..
		"button[6.7,4;1,1;shoedown;<-]".. --\\
		"field[7.75,4.32;1.75,1;shoes;;"..rgb_table[15].."]".. --//
		"button[8.97,4;1,1;shoeup;->]"..  --\\
		--
		
		-- Shoes Layer 2
		"label[5,5;Shoes]"..
		"label[5,5.38;Layer 2:]"..
		"button[6.7,5;1,1;shoedown2;<-]".. --\\
		"field[7.75,5.32;1.75,1;shoes2;;"..rgb_table[16].."]".. --//
		"button[8.97,5;1,1;shoeup2;->]"..  --\\
		--
		
		-- Accessory Layer 1
		"label[10,0;Accessory]"..
		"label[10,0.38;Layer 1:]"..
		"button[11.7,0;1,1;acc1down;<-]".. --\\
		"field[12.75,0.32;1.75,1;acc1;;"..rgb_table[17].."]".. --//
		"button[13.97,0;1,1;acc1up;->]"..  --\\
		--
		
		-- Accessory Layer 2
		"label[10,1;Accessory]"..
		"label[10,1.38;Layer 2:]"..
		"button[11.7,1;1,1;acc2down;<-]".. --\\
		"field[12.75,1.32;1.75,1;acc2;;"..rgb_table[18].."]".. --//
		"button[13.97,1;1,1;acc2up;->]"..  --\\
		--
		
		-- Accessory Layer 3
		"label[10,2;Accessory]"..
		"label[10,2.38;Layer 3:]"..
		"button[11.7,2;1,1;acc3down;<-]".. --\\
		"field[12.75,2.32;1.75,1;acc3;;"..rgb_table[19].."]".. --//
		"button[13.97,2;1,1;acc3up;->]"..  --\\
		--
		
		-- Accessory Layer 4
		"label[10,3;Accessory]"..
		"label[10,3.38;Layer 4:]"..
		"button[11.7,3;1,1;acc4down;<-]".. --\\
		"field[12.75,3.32;1.75,1;acc4;;"..rgb_table[20].."]".. --//
		"button[13.97,3;1,1;acc4up;->]"..  --\\
		--
		
		-- Accessory Layer 5
		"label[10,4;Accessory]"..
		"label[10,4.38;Layer 5:]"..
		"button[11.7,4;1,1;acc5down;<-]".. --\\
		"field[12.75,4.32;1.75,1;acc5;;"..rgb_table[21].."]".. --//
		"button[13.97,4;1,1;acc5up;->]"..  --\\
		--
		
		-- Accessory Layer 6
		"label[10,5;Accessory]"..
		"label[10,5.38;Layer 6:]"..
		"button[11.7,5;1,1;acc6down;<-]".. --\\
		"field[12.75,5.32;1.75,1;acc6;;"..tostring(rgb_table[22]).."]".. --//
		"button[13.97,5;1,1;acc6up;->]"..  --\\
		--
		
		--Apply Texture to Dummy Player;
		"button[12.97,10;2,1;preview;Preview]"..
		
		--Apply Texture to Real Player;
		"button[10.97,10;2,1;apply;Apply to Me!]"
		
		--Apply Texture to Player;
	return formspec
end

minetest.register_node("wardrobe:node", {
	description = "Mirror (Customise Player)",
	drawtype = "mesh",
	mesh = "wardrobe_mirror.b3d",
	tiles = {"wardrobe_mirror.png"},
	groups = {crumbly=3},
	paramtype = "light",
	paramtype2 = "facedir",
	
	after_dig_node = function(pos)
	
		local entity = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.1)
		
		entity[1]:remove()
		
	end,
	
	on_punch = function(pos, node, puncher)
		
		local meta = minetest.get_meta(pos)
		local pchoices = {}
		local pname = puncher:get_player_name()
		
		meta:set_string("formspec",	wardrobe.formspec_meta(wardrobe.formspec_selections[pname], wardrobe.formspec_selections_rgb[pname]))
		
		wardrobe.update_dummy(pos, puncher)
	
	end,
	
	after_place_node = function(pos, placer)
		local meta = minetest.get_meta(pos)
		local pchoices = {}
		local pname = placer:get_player_name()
		
		meta:set_string("formspec",	wardrobe.formspec_meta(wardrobe.formspec_selections[pname], wardrobe.formspec_selections_rgb[pname]))
		
		wardrobe.update_dummy(pos, placer)

	end,
	
	on_receive_fields = function(pos, formname, fields, sender)
		
		if fields.quit then	return end
		
		local pname = sender:get_player_name()
		local meta = minetest.get_meta(pos)
		
		wardrobe.save_text_fields(fields, pname)
		meta:set_string("formspec",	wardrobe.formspec_meta(wardrobe.formspec_selections[pname], wardrobe.formspec_selections_rgb[pname]))
		
		-- eyes (1)
		if (fields.eyedown) then
			wardrobe.table_incrementer(1, false, sender, wardrobe.eyes)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.eyeup) then
			wardrobe.table_incrementer(1, true, sender, wardrobe.eyes)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- pupils (2)
		
		if (fields.pupdown) then
			wardrobe.table_incrementer(2, false, sender, wardrobe.pupils)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.pupup) then
			wardrobe.table_incrementer(2, true, sender, wardrobe.pupils)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- hair (3)
		
		if (fields.hairdown) then
			wardrobe.table_incrementer(3, false, sender, wardrobe.hair_styles)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.hairup) then
			wardrobe.table_incrementer(3, true, sender, wardrobe.hair_styles)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- mouth (4)
		
		if (fields.mouthdown) then
			wardrobe.table_incrementer(4, false, sender, wardrobe.mouth_parts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.mouthup) then
			wardrobe.table_incrementer(4, true, sender, wardrobe.mouth_parts)
			wardrobe.update_dummy(pos, sender)

		end
		
		-- undershirt L1 + L2 (5, 6)
		
		if (fields.ushirtdown) then
			wardrobe.table_incrementer(5, false, sender, wardrobe.undershirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.ushirtup) then
			wardrobe.table_incrementer(5, true, sender, wardrobe.undershirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.ushirtdown2) then
			wardrobe.table_incrementer(6, true, sender, wardrobe.undershirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.ushirtup2) then
			wardrobe.table_incrementer(6, true, sender, wardrobe.undershirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Leggings L1 + L2 (7, 8)
		
		if (fields.leggdown) then
			wardrobe.table_incrementer(7, false, sender, wardrobe.under_trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.leggup) then
			wardrobe.table_incrementer(7, true, sender, wardrobe.under_trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.leggdown2) then
			wardrobe.table_incrementer(8, false, sender, wardrobe.under_trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.leggup2) then
			wardrobe.table_incrementer(8, true, sender, wardrobe.under_trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Socks L1 + L2 (9, 10)
		
		if (fields.sockdown) then
			wardrobe.table_incrementer(9, false, sender, wardrobe.socks)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.sockup) then
			wardrobe.table_incrementer(9, true, sender, wardrobe.socks)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.sockdown2) then
			wardrobe.table_incrementer(10, false, sender, wardrobe.socks)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.sockup2) then
			wardrobe.table_incrementer(10, true, sender, wardrobe.socks)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Over Shirt L1 + L2 (11, 12)
		
		if (fields.topshirtdown) then
			wardrobe.table_incrementer(11, false, sender, wardrobe.shirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.topshirtup) then
			wardrobe.table_incrementer(11, true, sender, wardrobe.shirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.topshirtdown2) then
			wardrobe.table_incrementer(12, false, sender, wardrobe.shirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.topshirtup2) then
			wardrobe.table_incrementer(12, true, sender, wardrobe.shirts)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Overalls / Trousers L1 + L2 (13, 14)
		
		if (fields.troudown) then
			wardrobe.table_incrementer(13, false, sender, wardrobe.trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.trouup) then
			wardrobe.table_incrementer(13, true, sender, wardrobe.trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.troudown2) then
			wardrobe.table_incrementer(14, false, sender, wardrobe.trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.trouup2) then
			wardrobe.table_incrementer(14, true, sender, wardrobe.trousers)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Shoes L1 + L2 (15, 16)
		
		if (fields.shoedown) then
			wardrobe.table_incrementer(15, false, sender, wardrobe.shoes)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.shoeup) then
			wardrobe.table_incrementer(15, true, sender, wardrobe.shoes)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.shoedown2) then
			wardrobe.table_incrementer(16, false, sender, wardrobe.shoes)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.shoeup2) then
			wardrobe.table_incrementer(16, true, sender, wardrobe.shoes)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Acessories L1 -> L6 (17, 18, 19, 20, 21, 22)
		
		if (fields.acc1down) then
			wardrobe.table_incrementer(17, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc1up) then
			wardrobe.table_incrementer(17, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		--
		
		if (fields.acc2down) then
			wardrobe.table_incrementer(18, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc2up) then
			wardrobe.table_incrementer(18, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		--
		
		if (fields.acc3down) then
			wardrobe.table_incrementer(19, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc3up) then
			wardrobe.table_incrementer(19, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		--
		
		if (fields.acc4down) then
			wardrobe.table_incrementer(20, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc4up) then
			wardrobe.table_incrementer(20, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		--
		
		if (fields.acc5down) then
			wardrobe.table_incrementer(21, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc5up) then
			wardrobe.table_incrementer(21, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		--
		
		if (fields.acc6down) then
			wardrobe.table_incrementer(22, false, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.acc6up) then
			wardrobe.table_incrementer(22, true, sender, wardrobe.accessories)
			wardrobe.update_dummy(pos, sender)
		end
		
		-- Apply current data to entity.
		
		if (fields.preview) then
			wardrobe.update_dummy(pos, sender)
		end
		
		if (fields.apply) then
			wardrobe.apply_to_player(sender)
		end
	end,
})

function wardrobe.update_player(player)

	print("meow")

end

function wardrobe.update_dummy(pos, player)
	local pname = player:get_player_name()
	local entity = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.1)
			
	if entity[1] == nil then
				
		minetest.add_entity({x=pos.x, y=pos.y+0.5, z=pos.z}, "wardrobe:dummy")
			
		entity = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.1)
				
		entity[1]:set_animation({x=0, y=1339}, 60, 0)	
	end
		
	entity = minetest.get_objects_inside_radius({x=pos.x, y=pos.y+0.5, z=pos.z}, 0.1)
			
	if entity[1] then
		entity[1]:set_animation({x=0, y=1339}, 60, 0)			
		entity[1]:set_properties({
			textures = {
				"ptextures_transparent.png", 
					"(wardrobe_skin"..                                                   ".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][1]..  ")^"..
					"(wardrobe_eyes_white_"..  wardrobe.formspec_selections[pname][1]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][2]..  ")^"..
					"(wardrobe_eyes_pupil_"..  wardrobe.formspec_selections[pname][2]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][3]..  ")^"..
					"(wardrobe_hair_"..        wardrobe.formspec_selections[pname][3]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][4]..  ")^"..
					"(wardrobe_mouth_"..       wardrobe.formspec_selections[pname][4]  ..".png)^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][5]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][5]..  ")^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][6]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][6]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][7]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][7]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][8]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][8]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][9]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][9]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][10] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][10].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][11] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][11].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][12] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][12].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][13] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][13].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][14] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][14].. ")^"..		
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][15] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][15].. ")^"..
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][16] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][16].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][17] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][17].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][18] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][18].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][19] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][19].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][20] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][20].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][21] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][21].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][22] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][22].. ")",
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png"
			}
		})
		
	end
	wardrobe.save_user_data(player)
end

-- Caution: this function changes the players appearance only temporarily; use for when sleeping and such.
-- It can be reset when you run wardrobe.apply_to_player(player)

function wardrobe.close_eyes(player)

	if minetest.get_modpath("wardrobe") ~= nil and beds.use_wardrobe_support then
	
		local pname = player:get_player_name()
		
		player:set_properties({
			textures = {
				"ptextures_transparent.png", 
					"(wardrobe_skin"..                                                   ".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][1]..  ")^"..
					"(beds_eyes_white_"..      wardrobe.formspec_selections[pname][1]  ..".png^[opacity:10^beds_eyes_white_".. wardrobe.formspec_selections[pname][1] .. "_ovl.png)^"..
					"(beds_eyes_pupil_"..      wardrobe.formspec_selections[pname][2]  ..".png^[opacity:10)^"..
					"(wardrobe_hair_"..        wardrobe.formspec_selections[pname][3]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][4]..  ")^"..
					"(wardrobe_mouth_"..       wardrobe.formspec_selections[pname][4]  ..".png)^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][5]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][5]..  ")^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][6]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][6]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][7]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][7]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][8]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][8]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][9]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][9]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][10] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][10].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][11] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][11].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][12] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][12].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][13] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][13].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][14] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][14].. ")^"..		
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][15] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][15].. ")^"..
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][16] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][16].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][17] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][17].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][18] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][18].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][19] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][19].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][20] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][20].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][21] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][21].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][22] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][22].. ")",
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png"
			}
		})
	
	end

end

function wardrobe.apply_to_player(player)
	
	-- We like being sane and not crashing
	if player == nil then
		return
	end
	
	local pname = player:get_player_name()
	
	player:set_properties({
			textures = {
				"ptextures_transparent.png", 
					"(wardrobe_skin"..                                                   ".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][1]..  ")^"..
					"(wardrobe_eyes_white_"..  wardrobe.formspec_selections[pname][1]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][2]..  ")^"..
					"(wardrobe_eyes_pupil_"..  wardrobe.formspec_selections[pname][2]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][3]..  ")^"..
					"(wardrobe_hair_"..        wardrobe.formspec_selections[pname][3]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][4]..  ")^"..
					"(wardrobe_mouth_"..       wardrobe.formspec_selections[pname][4]  ..".png)^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][5]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][5]..  ")^"..
					"(wardrobe_under_shirt_".. wardrobe.formspec_selections[pname][6]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][6]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][7]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][7]..  ")^"..
					"(wardrobe_leggings_"..    wardrobe.formspec_selections[pname][8]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][8]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][9]  ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][9]..  ")^"..
					"(wardrobe_socks_"..       wardrobe.formspec_selections[pname][10] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][10].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][11] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][11].. ")^"..
					"(wardrobe_shirt_"..       wardrobe.formspec_selections[pname][12] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][12].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][13] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][13].. ")^"..
					"(wardrobe_trousers_"..    wardrobe.formspec_selections[pname][14] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][14].. ")^"..		
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][15] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][15].. ")^"..
					"(wardrobe_shoes_"..       wardrobe.formspec_selections[pname][16] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][16].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][17] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][17].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][18] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][18].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][19] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][19].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][20] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][20].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][21] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][21].. ")^"..
					"(wardrobe_acc_"..         wardrobe.formspec_selections[pname][22] ..".png^[multiply:#".. wardrobe.formspec_selections_rgb[pname][22].. ")",
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png", 
				"ptextures_transparent.png"
			}
		})
		
	wardrobe.save_user_data(player)
end
	
function wardrobe.table_incrementer(arraynum, operator, player, maxval)
	if operator then
		
		if wardrobe.formspec_selections[player:get_player_name()][arraynum] == maxval then
			--nothing
		else
			wardrobe.formspec_selections[player:get_player_name()][arraynum] = wardrobe.formspec_selections[player:get_player_name()][arraynum] + 1
		end
		
	else
		if wardrobe.formspec_selections[player:get_player_name()][arraynum] == 1 then
			-- nothing
		else
			wardrobe.formspec_selections[player:get_player_name()][arraynum] = wardrobe.formspec_selections[player:get_player_name()][arraynum] - 1
		end
	end
end

function wardrobe.number_or_nil(number)

	return number or 1

end

function wardrobe.save_text_fields(fields, pname)
	
	wardrobe.formspec_selections_rgb[pname][1] = wardrobe.is_save_hex(fields.skintone)
	wardrobe.formspec_selections_rgb[pname][2] = wardrobe.is_save_hex(fields.ewhite)
	wardrobe.formspec_selections_rgb[pname][3] = wardrobe.is_save_hex(fields.pcolour)
	wardrobe.formspec_selections_rgb[pname][4] = wardrobe.is_save_hex(fields.hairdye)
	wardrobe.formspec_selections_rgb[pname][5] = wardrobe.is_save_hex(fields.undshirt)
	wardrobe.formspec_selections_rgb[pname][6] = wardrobe.is_save_hex(fields.undshirt2)
	wardrobe.formspec_selections_rgb[pname][7] = wardrobe.is_save_hex(fields.leggings)
	wardrobe.formspec_selections_rgb[pname][8] = wardrobe.is_save_hex(fields.leggings2)
	wardrobe.formspec_selections_rgb[pname][9] = wardrobe.is_save_hex(fields.socks)
	wardrobe.formspec_selections_rgb[pname][10] = wardrobe.is_save_hex(fields.socks2)
	wardrobe.formspec_selections_rgb[pname][11] = wardrobe.is_save_hex(fields.topshirt)
	wardrobe.formspec_selections_rgb[pname][12] = wardrobe.is_save_hex(fields.topshirt2)
	wardrobe.formspec_selections_rgb[pname][13] = wardrobe.is_save_hex(fields.trousers)
	wardrobe.formspec_selections_rgb[pname][14] = wardrobe.is_save_hex(fields.trousers2)
	wardrobe.formspec_selections_rgb[pname][15] = wardrobe.is_save_hex(fields.shoes)
	wardrobe.formspec_selections_rgb[pname][16] = wardrobe.is_save_hex(fields.shoes2)
	wardrobe.formspec_selections_rgb[pname][17] = wardrobe.is_save_hex(fields.acc1)
	wardrobe.formspec_selections_rgb[pname][18] = wardrobe.is_save_hex(fields.acc2)
	wardrobe.formspec_selections_rgb[pname][19] = wardrobe.is_save_hex(fields.acc3)
	wardrobe.formspec_selections_rgb[pname][20] = wardrobe.is_save_hex(fields.acc4)
	wardrobe.formspec_selections_rgb[pname][21] = wardrobe.is_save_hex(fields.acc5)
	wardrobe.formspec_selections_rgb[pname][22] = wardrobe.is_save_hex(fields.acc6)
		
end

function wardrobe.is_save_hex(textfield)
	
	if string.match(textfield, "^[0-9a-fA-F]+$") and #textfield == 6 then
		return textfield	
	else
		return "ffffff"
	end
	
end
-- minetest.serialize(table)`: returns a string
-- minetest.deserialize(string)`: returns a table

function wardrobe.load_user_data(player)
	
	local pname = player:get_player_name()
	
	-- load non-RGB choices					 --0 0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1 1 1 2 2 2
											 --1 2 3 4 5 6 7 8 9 0 1 2 3 4 5 6 7 8 9 0 1 2
	if player:get_attribute("wardrobe_choices") == nil then
		wardrobe.formspec_selections[pname] = {2,2,2,1,2,1,2,1,2,1,2,1,1,1,2,1,1,1,1,1,1,1}
		print ("[Wardrobe] Failed Loading Texture Data for Player: " .. pname)
		player:set_attribute("wardrobe_choices", minetest.serialize(wardrobe.formspec_selections[pname]))
		
	else
		wardrobe.formspec_selections[pname] = minetest.deserialize(player:get_attribute("wardrobe_choices"))
		print ("[Wardrobe] Loaded Texture Data for Player: " .. pname)
		
	end
	
	-- load RGB
	
	if player:get_attribute("wardrobe_rgb") == nil then
		wardrobe.formspec_selections_rgb[pname] = {}
		
		wardrobe.formspec_selections_rgb[pname][1] = "e3c0a3"
		wardrobe.formspec_selections_rgb[pname][2] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][3] = "3636eb"
		wardrobe.formspec_selections_rgb[pname][4] = "4a301b"
		wardrobe.formspec_selections_rgb[pname][5] = "dddddd"
		wardrobe.formspec_selections_rgb[pname][6] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][7] = "1b275d"
		wardrobe.formspec_selections_rgb[pname][8] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][9] = "777777"
		wardrobe.formspec_selections_rgb[pname][10] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][11] = "39881c"
		wardrobe.formspec_selections_rgb[pname][12] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][13] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][14] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][15] = "141414"
		wardrobe.formspec_selections_rgb[pname][16] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][17] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][18] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][19] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][20] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][21] = "ffffff"
		wardrobe.formspec_selections_rgb[pname][22] = "ffffff"
		
		print ("[Wardrobe] Failed Loading RGB Data for Player: " .. pname)
		player:set_attribute("wardrobe_rgb", minetest.serialize(wardrobe.formspec_selections_rgb[pname]))
	
	else
		wardrobe.formspec_selections_rgb[pname] = minetest.deserialize(player:get_attribute("wardrobe_rgb"))	
		print ("[Wardrobe] Loaded RGB Data for Player: " .. pname)
		
	end
	
end

function wardrobe.save_user_data(player)
	local pname = player:get_player_name()
	
	player:set_attribute("wardrobe_choices", minetest.serialize(wardrobe.formspec_selections[pname]))
	player:set_attribute("wardrobe_rgb", minetest.serialize(wardrobe.formspec_selections_rgb[pname]))

end

minetest.register_on_joinplayer(function(player)
	local pname = player:get_player_name()
	
	wardrobe.load_user_data(player)
	
	wardrobe.apply_to_player(player)
end)