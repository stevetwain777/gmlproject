/// @description Observe GamePad State

if (!gamepad_is_connected(gamepad_index)) {
	return
}

if (gamepad_button_check_pressed(gamepad_index, gp_face4)) {
	event_perform_object(player_movement_comp, ev_other, ev_user15)
}
if (gamepad_button_check_pressed(gamepad_index, gp_face1)) {
	game_end()
}

var horiz_axis = gamepad_axis_value(gamepad_index, gp_axislh)
if (horiz_axis < -0.1) {
	left_down = true
	right_down = false
}
else if (horiz_axis > 0.1) {
	right_down = true
	left_down = false
}
else {
	left_down = false
	right_down = false
}

var vert_axis = gamepad_axis_value(gamepad_index, gp_axislv)
if (vert_axis > 0.1) {
	down_down = true
}
else {
	down_down = false
}