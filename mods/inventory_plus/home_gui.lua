
-- static spawn position
local statspawn = (minetest.setting_get_pos("static_spawnpoint") or {x = 0, y = 12, z = 0})
local home_gui = {}

-- get_formspec
home_gui.get_formspec = function(player)

	local formspec = "size[6,2]"
		.. default.gui_bg
		.. default.gui_bg_img
		.. default.gui_slots
		.. "button[0,0;2,0.5;main;Back]"
		.. "button_exit[0,1.5;2,0.5;home_gui_set;Set Home]"
		.. "button_exit[2,1.5;2,0.5;home_gui_go;Go Home]"
		.. "button_exit[4,1.5;2,0.5;home_gui_spawn;Spawn]"

	local home = sethome.get( player:get_player_name() )

	if home then
		formspec = formspec
			.."label[2.5,-0.2;Home set to:]"
			.."label[2.5,0.4;".. minetest.pos_to_string(vector.round(home)) .. "]"
	end

	return formspec
end

-- add inventory_plus page when player joins
minetest.register_on_joinplayer(function(player)
	inventory_plus.register_button(player,"home_gui","Home Pos")
end)

-- what to do when we press da buttons
minetest.register_on_player_receive_fields(function(player, formname, fields)
	local privs =  minetest.get_player_privs(player:get_player_name()).home
	if privs and fields.home_gui_set then
		sethome.set( player:get_player_name(), player:get_pos() )
	end
	if privs and fields.home_gui_go then
		sethome.go( player:get_player_name() )
	end
	if privs and fields.home_gui_spawn then
		player:setpos(statspawn)
	end
	if fields.home_gui or fields.home_gui_set or fields.home_gui_go then
		inventory_plus.set_inventory_formspec(player, home_gui.get_formspec(player))
	end
end)

-- spawn command
minetest.register_chatcommand("spawn", {
	description = "Go to Spawn",
	privs = {home = true},
	func = function(name)
		local player = minetest.get_player_by_name(name)
		player:setpos(statspawn)
	end,
})
