// aabb - argument0
// vel  - argument1
// tileX - argument2
// tileY - argument3
// tileW - argument4
// tileH - argument5
// is_y  - argument6

#macro COLLISION_MAP_TILE_EMPTY 0
#macro COLLISION_MAP_TILE_STATIC 1
#macro COLLISION_MAP_TILE_ONE_WAY 2
#macro COLLISION_BUFFER 0

var aabb = argument0
var vel = argument1
var fn_col_tile_x = argument2
var fn_col_tile_y = argument3
var fn_col_tile_width = argument4
var fn_col_tile_height = argument5
var is_y = argument6

var hit_dir = 0
var hit_type = 0
var vel_sign = sign(vel)

var width_in_tiles = ceil((aabb[AABB_R] - aabb[AABB_L]) / fn_col_tile_width)

// The plane we're currently checking against for collisions.
var col_start_y = (vel_sign > 0) ? aabb[AABB_B] : aabb[AABB_T]

// Get the cell of the tile starting at the left, and bottom/top of sprite (depending on direction)
var cur_col_tile_min_cell_x = is_y ? collision_map_get_cell_x_at_pixel(aabb[AABB_L]) : collision_map_get_cell_y_at_pixel(aabb[AABB_L])

var cur_col_tile_cell_y = is_y ? collision_map_get_cell_y_at_pixel(col_start_y) : collision_map_get_cell_x_at_pixel(col_start_y)

var max_col_tile_cell_y = is_y ? collision_map_get_cell_y_at_pixel(col_start_y + vel) : collision_map_get_cell_x_at_pixel(col_start_y + vel)

do {
	var stop = false
	
	// cur_col_tile_cell_y gets advanced each time we go through this loop.
	for (var i = 0; i < width_in_tiles; i++) {
		var cur_col_tile_cell_x = cur_col_tile_min_cell_x + i

		var cur_tile_type = is_y ? tilemap_get(global.col_tile_id, cur_col_tile_cell_x, cur_col_tile_cell_y) : tilemap_get(global.col_tile_id, cur_col_tile_cell_y, cur_col_tile_cell_x)
		if (cur_tile_type == COLLISION_MAP_TILE_STATIC ||
				(cur_tile_type == COLLISION_MAP_TILE_ONE_WAY && is_y && vel_sign > 0 && yprevious )) {
			hit_type = cur_tile_type
			// We've hit a static tile. This means we should reduce our velocity to the top/bottom
			// of the tile.
		
			// If we're moving down, we want the top tile position
			if (vel_sign > 0) {
				var tmp_col_tile_y = global.col_tile_y
				var tmp_col_tile_height = fn_col_tile_height
				var cur_tile_y = fn_col_tile_y + (cur_col_tile_cell_y * fn_col_tile_height)
				vel = (cur_tile_y - aabb[AABB_B]) - COLLISION_BUFFER
				hit_dir = 1
			}
			// If we're moving up, we want the bottom tile position
			else {
				var cur_tile_y = fn_col_tile_y + ((cur_col_tile_cell_y + 1) * fn_col_tile_height)
				vel = (cur_tile_y - aabb[AABB_T]) + COLLISION_BUFFER
				hit_dir = -1
			}
			stop = true
		}
	}
	
	cur_col_tile_cell_y += vel_sign
} until(stop || vel_sign * (max_col_tile_cell_y - cur_col_tile_cell_y) < 0)

return [vel, hit_dir, hit_type]