/// @description Jump/Drop Pressed
if (mov_collision_info[? CI_GROUND_TYPE] == tile_type.oneway &&
	  down_down == true) {
		//mov_velocity[Yi] = 24.1
		mov_position[Yi] += 2.0
}
else {
	mov_velocity[1] = mov_jump_speed
}
jumping = true