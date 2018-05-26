-- minetracker, a small mod for solar plains that enables JSON-like line based playback of upto 12 instruments

local song_storage = minetest.get_modpath("minetracker").."/modules/"

local function decode_song(filename, pname)

	local trackdata = {}
	local val = 1

	for line in io.lines(song_storage..filename..".mtr") do

		if #trackdata < 4 then 
			trackdata[#trackdata + 1] = line
		else
			trackdata[#trackdata + 1] = minetest.deserialize(line) 
		end

	end

	for k, v in pairs(trackdata) do

		if k > 4 then

			for k2, v2 in pairs(v) do
				
				if k2 == "gap" then
					-- skip the audio engine
				else
					
					local tbl = {
						to_player = pname,
						gain = trackdata[k][k2].vol,
						fade = trackdata[k][k2].fade,
						pitch = trackdata[k][k2].pitch
					}

					minetest.after(((60 / trackdata[4]) / 4) * (k - 4), minetest.sound_play, trackdata[k][k2]["sample"], tbl)

				end

			end

		end

	end

	return "Now Playing: " .. trackdata[1] .. " by " .. trackdata[2] .. ", " .. trackdata[3] .. ". (" .. filename ..".mtr" .. ")"

end

minetest.chat_send_all(minetest.serialize({foo='bar', bar='foo'}))

minetest.register_chatcommand("mtracker", {
	
	description = "plays a mtracker song only to you",
	param = "type the name to play a song in the .mtr format",
	func = function(name, param)
		
		local player = minetest.get_player_by_name(name)

		local f = io.open(minetest.get_modpath("minetracker").."/modules/" .. param .. ".mtr", "r")
		
		if f == nil then
			return false, "MineTracker song not found, (" .. param .. ".mtr)." 
		else
			io.close(f)
		end


		return true, decode_song(param, name)
	end,

})