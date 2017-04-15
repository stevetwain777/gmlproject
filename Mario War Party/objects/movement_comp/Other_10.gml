/// @description Update Velocity
// Update the velocity based on input, friction, and acceleration

var accel_factor = mov_acceleration
var friction_factor = mov_friction

var c_tile = mov_collision_info[? CI_GROUND_TYPE]
var c_last_ground = mov_collision_info[? CI_LAST_GROUND_TYPE]
if (c_last_ground == tile_type.ice || c_tile == tile_type.ice) {
	friction_factor *= mov_ice_friction_modifier
	accel_factor *= mov_ice_acceleration_modifier
}
else if (c_tile == tile_type.empty) {
	friction_factor *= 0.25
	accel_factor *= 0.7
}

var accel = vec2_zero()
var is_friction = false
if ((left_down && right_down) || (!left_down && !right_down)) {
	if (mov_velocity[0] > 0) {
		accel[0] = -friction_factor
		is_friction = true
	}
	else if (mov_velocity[0] < 0) {
		accel[0] = friction_factor
		is_friction = true
	}
	else {
		accel[0] = 0.0
	}
}
else if (left_down) {
	accel[0] = -accel_factor
}
else if (right_down) {
	accel[0] = accel_factor
}

// Gravity is always Y acceleration
accel[1] = mov_gravity

var orig_velocity = mov_velocity
var dt = delta

// a * t
accel = vec2_mult(accel, dt)
// v0 + (a * t)
mov_velocity = vec2_add(mov_velocity, accel)

// If we're practically not moving, make us not moving (float point error does this).
if (abs(mov_velocity[0]) < mov_velocity_threshold) {
	mov_velocity[0] = 0
}

mov_velocity[0] = clamp(mov_velocity[0], -mov_max_speed, mov_max_speed)
mov_velocity[1] = clamp(mov_velocity[1], -mov_max_fall_speed, mov_max_fall_speed)

if (is_friction && ((orig_velocity[0] < 0 && mov_velocity[0] > 0) || (orig_velocity[0] > 0 && mov_velocity[0] < 0))) {
	mov_velocity[0] = 0
}