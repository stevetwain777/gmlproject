/// @description GamePad Connect/Disconnect

if (disable_gamepad) {
	return
}

switch(async_load[? "event_type"]) {
	case "gamepad discovered":
    var pad = async_load[? "pad_index"];
		show_debug_message("GamePad Found: " + string(pad) + " | " + gamepad_get_description(pad))
    gamepad_set_axis_deadzone(pad, 0.5);
    gamepad_set_button_threshold(pad, 0.1);
    if (has_comp(keyboard_input_comp)) {
			remove_comp(keyboard_input_comp)
		}
		add_comp(gamepad_input_comp)
		gamepad_index = pad
    break;
case "gamepad lost":
    var pad = async_load[? "pad_index"];
		show_debug_message("GamePad Lost: " + string(pad))
    if (has_comp(gamepad_input_comp)) {
			remove_comp(gamepad_input_comp)
		}
		gamepad_index = noone
    break;
}