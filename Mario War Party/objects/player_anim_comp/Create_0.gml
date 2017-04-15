enum player_animation_state {
	idle,
	running,
	jumping,
	skidding,
	dead,
	squashed,
}

anim_state = player_animation_state.idle
last_anim_state = anim_state
sprite_index = player_sprite

if (!has_comp(direction_comp)) {
	add_comp(direction_comp)
}