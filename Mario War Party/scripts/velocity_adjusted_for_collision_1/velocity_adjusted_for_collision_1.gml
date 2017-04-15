// vel = argument0

var vel = argument0
var aabb = instance_get_world_aabb(self)

var y_axis = velocity_adjusted_for_collision_comp(aabb,
																									vel[1],
																									global.col_tile_x,
																									global.col_tile_y,
																									global.col_tile_width,
																									global.col_tile_height,
																									true)
if (y_axis[0] != 0) {
	// TODO: This should be handled by caller
	mov_velocity[1] = 0.0
}
if (y_axis[0] == 1) {
	jumping = false
}
vel[1] = y_axis[1]

// If we aren't moving horizontally, return early
if (vel[0] == 0) {
	return vel
}

// Adjust X-Axis
var next_top = aabb[AABB_T] + y_axis[1]
var next_bottom = aabb[AABB_B] + y_axis[1]
aabb[AABB_T] = aabb[AABB_L]
aabb[AABB_B] = aabb[AABB_R]
aabb[AABB_L] = next_top
aabb[AABB_R] = next_bottom

var x_axis = velocity_adjusted_for_collision_comp(aabb,
																									vel[0],
																									global.col_tile_y,
																									global.col_tile_x,
																									global.col_tile_height,
																									global.col_tile_width,
																									false)

if (x_axis[0] != 0) {
	// TODO: This should be handled by caller
	mov_velocity[0] = 0.0
}
vel[0] = x_axis[1]

return vel