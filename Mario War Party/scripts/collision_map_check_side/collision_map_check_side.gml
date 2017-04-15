var aabb = argument0
var c_side = argument1
							
var start_cell
var end_cell
var side_cell
if ((c_side & side.horizontal) != 0) {
	start_cell = collision_map_get_cell_x_at_pixel(aabb[AABB_L])
	end_cell = collision_map_get_cell_x_at_pixel(aabb[AABB_R])
	if (c_side == side.top) {
		side_cell = collision_map_get_cell_y_at_pixel(aabb[AABB_T])
	}
	else {
		side_cell = collision_map_get_cell_y_at_pixel(aabb[AABB_B])
	}
}
else {
	start_cell = collision_map_get_cell_y_at_pixel(aabb[AABB_T])
	end_cell = collision_map_get_cell_y_at_pixel(aabb[AABB_B])
	if (c_side == side.left) {
		side_cell = collision_map_get_cell_x_at_pixel(aabb[AABB_L])
	}
	else {
		side_cell = collision_map_get_cell_x_at_pixel(aabb[AABB_R])
	}
}

for (var i = start_cell; i <= end_cell; i++) {
	var c_tile
	if ((c_side & side.horizontal) != 0) {
		c_tile = collision_map_get_tile_type(i, side_cell)
	}
	else {
		c_tile = collision_map_get_tile_type(side_cell, i)
	}
	
	if (c_tile != tile_type.empty) {
		if (c_tile == tile_type.oneway) {
			if (c_side != side.bottom) {
				continue
			}
			
			var tile_aabb = collision_map_get_cell_aabb(i, side_cell)
			if (abs(tile_aabb[AABB_T] - aabb[AABB_B]) < 1.5) {
				return c_tile
			}
		}
		else {
			return c_tile
		}
	}
}

return tile_type.empty