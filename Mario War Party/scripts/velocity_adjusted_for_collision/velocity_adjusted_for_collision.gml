// vel = argument0

var inst = argument0
var vel = argument1
var aabb = instance_get_world_aabb(inst)

var x_axis
var y_axis

if (abs(vel[Yi]) > abs(vel[Xi])) {
	y_axis = velocity_adjusted_for_collision_comp(aabb,
																								vel[1],
																								global.col_tile_x,
																								global.col_tile_y,
																								global.col_tile_width,
																								global.col_tile_height,
																								true)

	// If we aren't moving horizontally, return early
	if (vel[0] != 0) {
		// Adjust X-Axis
		var next_top = aabb[AABB_T] + y_axis[1]
		var next_bottom = aabb[AABB_B] + y_axis[1]
		aabb[AABB_T] = aabb[AABB_L]
		aabb[AABB_B] = aabb[AABB_R]
		aabb[AABB_L] = next_top
		aabb[AABB_R] = next_bottom

		x_axis = velocity_adjusted_for_collision_comp(aabb,
																									vel[0],
																									global.col_tile_y,
																									global.col_tile_x,
																									global.col_tile_height,
																									global.col_tile_width,
																									false)
	}
	else {
		x_axis = [vel[Xi], 0, COLLISION_MAP_TILE_EMPTY]
	}
}
else {
	var top = aabb[AABB_T]
	var bottom = aabb[AABB_B]
	aabb[AABB_T] = aabb[AABB_L]
	aabb[AABB_B] = aabb[AABB_R]
	aabb[AABB_L] = top
	aabb[AABB_R] = bottom

	x_axis = velocity_adjusted_for_collision_comp(aabb,
																								vel[0],
																								global.col_tile_y,
																								global.col_tile_x,
																								global.col_tile_height,
																								global.col_tile_width,
																								false)
																								
	var next_left = aabb[AABB_T] + x_axis[1]
	var next_right = aabb[AABB_B] + x_axis[1]
	aabb[AABB_T] = aabb[AABB_L]
	aabb[AABB_B] = aabb[AABB_R]
	aabb[AABB_L] = next_left
	aabb[AABB_R] = next_right

	y_axis = velocity_adjusted_for_collision_comp(aabb,
																								vel[1],
																								global.col_tile_x,
																								global.col_tile_y,
																								global.col_tile_width,
																								global.col_tile_height,
																								true)
}

vel[0] = x_axis[0]
vel[1] = y_axis[0]

// Velocity, X Hit Dir, X Hit Type, Y Hit Dir, Y Hit Type
return [vel, x_axis[1], x_axis[2], y_axis[1], y_axis[2]]