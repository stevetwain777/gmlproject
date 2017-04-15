// Update frames according to animation
if (anim_state == player_animation_state.running) {
	image_speed = 1.2
	if (last_anim_state == player_animation_state.jumping) {
		image_index = 0
	}
	else if (last_anim_state != player_animation_state.running) {
		image_index = 1
	}
	else if (image_index > 2) {
		image_index = 0
	}
}
else {
	image_speed = 0
	
	if (anim_state == player_animation_state.idle) {
		image_index = 0
	}
	if (anim_state == player_animation_state.jumping) {
		image_index = 2
	}
	else if (anim_state == player_animation_state.skidding) {
		image_index = 3
	}
	else if (anim_state == player_animation_state.dead) {
		image_index = 4
	}
	else if (anim_state == player_animation_state.squashed) {
		image_index = 5
	}
}

last_anim_state = anim_state