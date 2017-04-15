var group = argument0
var dt = argument1

var max_velocity = 0
var group_velocities

// STEP 1
// Find the largest velocity (only major)
var inst_cnt = ds_list_size(group)
for (var i = inst_cnt - 1; i >= 0; i--) {
	var c_inst = group[| i]
	group_velocities[i] = vec2_mult(c_inst.mov_velocity, dt)
	var major_len = vec2_major_len(group_velocities[i])
	if (major_len > max_velocity) {
		max_velocity = major_len
	}
}

// If none of the objects are moving. Return early
if (max_velocity == 0) {
	return
}

var step_cnt = ceil(max_velocity)
var step_dt = 1.0 / step_cnt
var vec_zero = vec2_zero()
for (var i = 1; i <= step_cnt; i++) {
	var c_dt = i * step_dt
	var prev_dt = (i-1) * step_dt
	for (var j = 0; j < inst_cnt; j++) {
		var c_inst = group[| j]
		var prev_vel = vec2_lerp(vec_zero, group_velocities[j], prev_dt)
		var c_vel = vec2_lerp(vec_zero, group_velocities[j], c_dt)
		if (c_vel[Xi] == 0.0 && c_vel[Yi] == 0.0) {
			continue
		}
		var c_start_aabb = c_inst.mov_collision_info[? CI_START_AABB]
		
		//if (vec2_is_y_major(c_vel)) {
		var y_offset = vec2(prev_vel[Xi], c_vel[Yi])
		var c_aabb = aabb_offset_vec2(c_start_aabb, y_offset)
		var c_side = if_positive_else(c_vel[Yi], side.bottom, side.top)
		var c_tile = collision_map_check_side(c_aabb, c_side)
		if (c_tile != tile_type.empty) {
			c_inst.mov_collision_info[? CI_COLLIDE_SIDES] |= c_side
			if (c_side == side.bottom) {
				c_inst.mov_collision_info[? CI_GROUND_TYPE] = c_tile
				c_inst.mov_collision_info[? CI_LAST_GROUND_TYPE] = c_tile
			}
				
			var final_y_vel = lerp(0.0, vec2_get_y(group_velocities[j]), prev_dt)
			var cur_final_vel = c_inst.mov_collision_info[? CI_FINAL_VELOCITY_STEP]
			c_inst.mov_collision_info[? CI_START_AABB] = aabb_offset_vec2(c_start_aabb, vec2_y(final_y_vel))
			c_inst.mov_collision_info[? CI_FINAL_VELOCITY_STEP] = vec2(cur_final_vel[Xi], final_y_vel)
			group_velocities[j] = vec2_with_y(group_velocities[j], 0.0)
		}
		
		if (c_vel[Xi] != 0) {
			// TODO: Using previous velocity is probably wrong.
			var x_offset = vec2(c_vel[Xi], prev_vel[Yi])
			c_aabb = aabb_offset_vec2(c_start_aabb, x_offset)
			c_side = if_positive_else(c_vel[Xi], side.right, side.left)
			c_tile = collision_map_check_side(c_aabb, c_side)
			if (c_tile != tile_type.empty) {
				c_inst.mov_collision_info[? CI_COLLIDE_SIDES] |= c_side
			
				var final_x_vel = lerp(0.0, vec2_get_x(group_velocities[j]), prev_dt)
				var cur_final_vel = c_inst.mov_collision_info[? CI_FINAL_VELOCITY_STEP]
				c_inst.mov_collision_info[? CI_START_AABB] = aabb_offset_vec2(c_start_aabb, vec2_x(final_x_vel))
				c_inst.mov_collision_info[? CI_FINAL_VELOCITY_STEP] = vec2(final_x_vel, cur_final_vel[Yi])
				group_velocities[j] = vec2_with_x(group_velocities[j], 0.0)
			}
		}
	}
}