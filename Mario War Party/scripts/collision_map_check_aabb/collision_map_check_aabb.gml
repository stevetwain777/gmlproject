// returns - [horiz_type, side, vert_type, side]
#macro COLLISION_MAP_CHECK_TYPE	0
#macro COLLISION_MAP_CHECK_SIDE	1

var aabb = argument0
var cur_vel = argument1

var start_cell = vec2(collision_map_get_cell_x_at_pixel(aabb[AABB_L]),
										  collision_map_get_cell_y_at_pixel(aabb[AABB_T]))
var end_cell = vec2(collision_map_get_cell_x_at_pixel(aabb[AABB_R]),
										collision_map_get_cell_y_at_pixel(aabb[AABB_B]))

var result = [tile_type.empty, side.none]
// First loop horizontally.
for (var i = start_cell[Xi]; i <= end_cell[Xi]; i++) {
	var c_tile = collision_map_get_tile_type(i, start_cell[Yi])
	var c_side = side.top
		
	if (c_tile == tile_type.empty) {
		// If the top tile is not solid, check if bottom tile is.
		c_tile = collision_map_get_tile_type(i, end_cell[Yi])
		c_side = side.bottom
	}
		
	// If we've collided on either top or bottom.
	if (c_tile != tile_type.empty) {
		result[COLLISION_MAP_CHECK_TYPE] = c_tile
			
		// If the current cell is either the start or end,
		// we may also be colliding on our side. We need to determine
		// which side is colliding the most, and use that.
		if (i == start_cell[Xi] || i == end_cell[Xi]) {
		// TODO: Clean up this branching (repeated else)
			if (vec2_is_x_major(cur_vel)) {
				result[COLLISION_MAP_CHECK_SIDE] = if_positive_else(cur_vel[Xi], side.right, side.left)
			}
			else {
				result[COLLISION_MAP_CHECK_SIDE] = c_side
			}
		}
		else {
			result[COLLISION_MAP_CHECK_SIDE] = c_side
		}
		return result
		
		// NEXT TODO
		// I think I need to break down the movement into X first Y first
		// otherwise its too hard to determine which direction should take
		// precedence. Using velocity alone doesn't work, because Y may be huge
		// when moving slightly to the right hitting a wall.
		//
		// Intersection rect can't be used because you could be hitting bottom left
		// corner of a block (with top right) while moving very fast to the right
		// this will result in a intersection with a large width, causing a vertical
		// adjustment, when it should be horizontal.
		// 
		// Instead we can just advance one dimension at a time (per step), favoring
		// the direction we're moving fastest.
		
		/*
			var c_tile_aabb = collision_map_get_cell_aabb(i, (c_side == side.top) ? start_cell[Yi] : end_cell[Yi])
			var c_intersect_aabb = aabb_intersect(aabb, c_tile_aabb)
			if (is_undefined(c_intersect_aabb)) {
				show_error_message("A NULL aabb intersection was found during tile collision detection")
				return result
			}
			
			var h = aabb_height(c_intersect_aabb)
			var w = aabb_width(c_intersect_aabb)
			if (h > w) {
				result[COLLISION_MAP_CHECK_SIDE] = (i == start_cell[Xi] ? side.left : side.right)
			}
			else {
				result[COLLISION_MAP_CHECK_SIDE] = c_side
			}			
			return result
		}
		else {
			result[COLLISION_MAP_CHECK_SIDE] = c_side
			return result
		}
		*/
	}
}

// Then loop vertically.
for (var j = start_cell[Yi]; j <= end_cell[Yi]; j++) {	
	var c_tile = collision_map_get_tile_type(start_cell[Xi], j)
	var c_side = side.left
		
	if (c_tile == tile_type.empty) {
		// If the left tile is not solid, check if right tile is.
		c_tile = collision_map_get_tile_type(end_cell[Xi], j)
		c_side = side.right
	}
		
	// If we've collided on either left or right.
	if (c_tile != tile_type.empty) {
		// We don't need to check against other sides in this case, because it would have been handled above.
		result[COLLISION_MAP_CHECK_TYPE] = c_tile
		result[COLLISION_MAP_CHECK_SIDE] = c_side
		return result
	}
}

return result