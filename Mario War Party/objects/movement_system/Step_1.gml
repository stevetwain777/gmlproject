var dt = delta
if (dt > 0.1) {
	return
}

// STEP 1
// For each movement component, create its collision info
var mov_cnt = ds_list_size(global.movement_instances)
for (var i = 0; i < mov_cnt; i++) {
	var c_inst = global.movement_instances[| i]
	with (c_inst) {
		// Have the movement component update its velocity
		// FIXME: This implicitly uses dt for updating velocity. This needs to change if we're using
		//        corrective network movement.
		event_perform_object(get_comp(movement_comp), ev_other, ev_user0)
	
		// Setup collision info
		var aabb = instance_get_world_aabb(self)
		mov_collision_info[? CI_START_AABB] = aabb
		var vt = vec2_mult(mov_velocity, dt)
		var end_aabb = aabb_offset_vec2(aabb, vt)
		mov_collision_info[? CI_MOVE_BOUNDS] = aabb_union(aabb, end_aabb)
		mov_collision_info[? CI_GROUP] = noone
		mov_collision_info[? CI_COLLIDE_SIDES] = side.none
		mov_collision_info[? CI_GROUND_TYPE] = tile_type.empty
		mov_collision_info[? CI_FINAL_VELOCITY_STEP] = vt
	}
}

var col_groups = ds_list_create()

// STEP 2
// Find intersections and establish collision groups
for (var i = 0; i < mov_cnt; i++) {
	var c_inst = global.movement_instances[| i]
	var c_col_info = c_inst.mov_collision_info
	
	for (var j = 0; j < mov_cnt; j++) {
		// Skip if same instance
		if (i == j) {
			continue
		}
		
		var o_inst = global.movement_instances[| j]
		
		// Check whether these two instances 
		if (c_inst.mov_collision_category & o_inst.mov_category == 0) {
			continue
		}
		
		var o_col_info = o_inst.mov_collision_info
		
		// Check whether we're already the same group. If so, skip.
		var c_group = c_col_info[? CI_GROUP]
		var o_group = o_col_info[? CI_GROUP]
		if (c_group == o_group && c_group != noone) {
			continue
		}
		
		// Get other's collision info
		var o_col_info = o_inst.mov_collision_info
		
		var c_bounds = c_col_info[? CI_MOVE_BOUNDS]
		var o_bounds = o_col_info[? CI_MOVE_BOUNDS]
		if (aabb_intersects(c_bounds, o_bounds)) {
			collision_group_add(col_groups, c_inst, c_group, o_inst, o_group)
		}
	}
}

// STEP 2.5
// Assign a default collision group for those without one.
// TODO: Optimization here. We only have to worry about tile collisions.
for (var i = 0; i < mov_cnt; i++) {
	var c_inst = global.movement_instances[| i]
	if (c_inst.mov_collision_info[? CI_GROUP] == noone) {
		var single_group = ds_list_create()
		ds_list_add(single_group, c_inst)
		ds_list_add(col_groups, single_group)
		c_inst.mov_collision_info[? CI_GROUP] = single_group
	}
}

// STEP3
// Loop through each collision group
//    1. Find the largest velocity (in major axis)
//    2. Find dt for moving 1px for that velocity
//    3. Begin stepping forward
var col_groups_cnt = ds_list_size(col_groups)
for (var i = 0; i < col_groups_cnt; i++) {
	var c_group = col_groups[| i]
	perform_collision_group_movement_step(c_group, dt)
}


for (var i = 0; i < mov_cnt; i++) {
	var c_inst = global.movement_instances[| i]
	with (c_inst) {
		var final_vel_step = mov_collision_info[? CI_FINAL_VELOCITY_STEP]
		mov_position = vec2_add(mov_position, final_vel_step)
		x = floor(mov_position[Xi])
		y = floor(mov_position[Yi])
		
		var c_side = mov_collision_info[? CI_COLLIDE_SIDES]
		if ((c_side & side.horizontal) != 0) {
			mov_velocity[Yi] = 0.0
		}
		if ((c_side & side.vertical) != 0) {
			mov_velocity[Xi] = 0.0
		}
		
		// Handle end of movement calculations. (e.g. stop jumping).
		event_perform_object(get_comp(movement_comp), ev_other, ev_user1)
	}
}


// Clean-up
for (var i = 0; i < col_groups_cnt; i++) {
	ds_list_destroy(col_groups[| i])
}
ds_list_destroy(col_groups)