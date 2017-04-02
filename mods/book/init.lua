-- register the global variable.

book = {}

book.fs_esc = minetest.formspec_escape()

-- basic settings

-- default book size is A4 (portrait) in Formspec inventory slots with rounding.

book.formspec_size = "size[8,11]"

-- book background; each book can have their own or copy the default
-- for Solar Plains this applies to all "books"
-- Player written books will probably resemble a notepad

book.bg_img_basic = "background[-0.45,-0.5;8.9,12.25;book_bg_basic.png]"

book.bg_img_wardrobe = "background[-0.45,-0.5;8.9,12;book_bg_wardrobe.png]"

book.bg_img_colours = "background[-0.45,-0.5;8.9,12;book_bg_.png]"

book.bg_img_market = "background[-0.45,-0.5;8.9,12;book_bg_basic.png]"

book.solar_plains_img = "image[-0.1,0.2;11,11;intro_title.png]"

-- page up and page down buttons;

--                image_button[<X>,<Y>;<W>,<H>;<texture name>;<name>;<label>;<noclip>;<drawborder>;<pressed texture name>]`

book.page_down = "image_button[6.85,10;1,1;book_pg_right.png;book_pg_up;;true;false;book_pg_right_pressed.png]"
book.page_up = "image_button[0.35,10;1,1;book_pg_left.png;book_pg_down;;true;false;book_pg_left_pressed.png]"

-- position for label positioning margins

book.left_margin = "0.35,"
book.centered = "3.35,"

-- register book types;

book.basics = {}

book.wardrobe = {}

book.common_colours = {}

book.market = {}

-- book page tables

book.basics.page = {}

book.wardrobe.page = {}

book.common_colours.page = {}

book.market.page = {}

-- book 

book.basics.page[1] = book.formspec_size .. book.bg_img_basic .. book.page_down .. book.page_up ..
					  book.solar_plains_img
					  
book.basics.page[2] = book.formspec_size .. book.bg_img_basic .. book.page_down .. book.page_up

function book.display_formspec_basic(itemstack, user)
	
	local meta = itemstack:get_meta()
		
	local page = meta:get_int("book_page")
	
	if page == nil or page == 0 then
		
		page = 1
		
		meta:set_int("book_page", 1)
		user:set_wielded_item(itemstack)
	end
	
	print (meta:get_int("book_page") .. " meta display_form")
	minetest.show_formspec(user:get_player_name(), "book:open", book.basics.page[page])
	
	return itemstack
end

-- register book items

minetest.register_craftitem("book:basics", {
	inventory_image = "book_tutorial.png",
	stack_max = 1,
	description = "Tutorial Book",
	
	on_place = function(itemstack, user)
		
		return book.display_formspec_basic(itemstack, user)
		
	end,
	
	on_secondary_use = function(itemstack, user)
	
		return book.display_formspec_basic(itemstack, user)
	
	end,
})

-- minetest.register_craftitem("book:wardrobe", {

-- })

-- minetest.register_craftitem("book:colours", {

-- })

-- minetest.register_craftitem("book:market", {

-- })

minetest.register_on_player_receive_fields(function(player, formname, fields)

	--if formname ~= "book:open" then return end
	
	local item = player:get_wielded_item()
	
	if item:get_name() == "book:basics" then
		
		local meta = item:get_meta()
	
		local page = meta:get_int("book_page")
		
		if fields.book_pg_up then
					
			if page ~= #book.basics.page then
				page = page + 1
				meta:set_int("book_page", page)
			end
			
			player:set_wielded_item(item)
			
			minetest.show_formspec(player:get_player_name(), "book:open", book.basics.page[page])
		end
		
		if fields.book_pg_down then
		
			if page ~= 1 then
				page = page - 1
				meta:set_int("book_page", page)
			end
			
			player:set_wielded_item(item)
			
			minetest.show_formspec(player:get_player_name(), "book:open", book.basics.page[page])
		
		end
		
	end
	
end)