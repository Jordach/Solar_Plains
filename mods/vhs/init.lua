-- VHS, or, Visual Hud Styles:
-- License, MIT

--[[

	VHS is designed for a single mod to house and contain everything from UX, UI,
	and how sounds are to be implemented. With a single mod providing sounds,
	UI appearances, it simplifies everything.

	Function calls:

	vhs.switch_appearance(player_ref, "name")
	Switches the current HUD, Hotbar, Inventory and Formspec views to the selected mode.

	vhs.get_appearance(player_ref)
	Gets the current appearance as used by vhs.switch_appearance().

	vhs.get_formspec_bg(player_ref)
	vhs.get_inventory_bg(player_ref)
	vhs.get_notification_sound(player_ref)
	vhs.get_click_sound(player_ref)
	vhs.get_toast_tune(player_ref)
	Gets the current filename for the currently used texture or sounds.

	vhs.get_inv_slot_color(player_ref)
	Gets the current colours used to set the inventory slots.
	Returns as a table: {

	
]]--

vhs = {}