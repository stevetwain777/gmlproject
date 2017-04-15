if (jumping) {
	anim_state = player_animation_state.jumping
}
else {
	if ((left_down && right_down) || (!left_down && !right_down)) {
		anim_state = player_animation_state.idle
	}
	else if (left_down) {
		if (mov_velocity[0] <= 0) {
			anim_state = player_animation_state.running
		}
		else {
			anim_state = player_animation_state.skidding
		}
	}
	else if (right_down) {
		if (mov_velocity[0] >= 0) {
			anim_state = player_animation_state.running
		}
		else {
			anim_state = player_animation_state.skidding
		}
	}
}