event_inherited()

// Direction is based on last input
if (left_down && !right_down) {
	facing_dir = facing_direction.left
}
else if (right_down && !left_down) {
	facing_dir = facing_direction.right
}