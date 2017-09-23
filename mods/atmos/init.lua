-- atmos, control of skies, weather (when doable.)

minetest.register_chatcommand("ratio", {
	
	description = "sets the ratio of day/night, testing only",
	param = "float; sets ratio of day/night",
	
	func = function(name, param)
	
		player = minetest.get_player_by_name(name)
		
		player:override_day_night_ratio(param)
	
	end,

})