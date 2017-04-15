// vel = argument0
/*
var vel = argument0
var aabb = instance_get_world_aabb(self)
var vel_sign = vec2_sign(vel)

// Adjust the collision box by the distance we will be traveling this frame.
var col_box
var col_box_halfwidth = aabb_width(col_box) / 2.0
var col_box_halfheight = aabb_height(col_box) / 2.0
if (vel_sign[Xi] > 0) {
	col_box[AABB_R] += (vel[0] + col_box_halfwidth)
}
else if (vel_sign[Xi] < 0) {
	col_box[AABB_L] += (vel[0] - col_box_halfwidth)
}

if (vel_sign[Yi] > 0) {
	col_box[AABB_B] += (vel[1] + col_box_halfheight)
}
else if (vel_sign[Yi] < 0) {
	col_box[AABB_T] += (vel[1] - col_box_halfheight)
}

// Find the start and end tiles associated with this bounding box.
var start_tile_cell_x = collision_map_get_cell_x_at_pixel(col_box[AABB_L])
var end_tile_cell_x = collision_map_get_cell_x_at_pixel(col_box[AABB_R])

var start_tile_cell_y = collision_map_get_cell_y_at_pixel(col_box[AABB_T])
var end_tile_cell_y = collision_map_get_cell_x_at_pixel(col_box[AABB_B])

var col_tiles
var col_tiles_count = 0

// Loop through these tiles and add solid tiles to a list.
for (var y = start_tile_cell_y; y <= end_tile_cell_y; y++) {
	for (var x = start_tile_cell_y; x <= end_tile_cell_x; x++ ){
		var tile_type = tilemap_get(global.col_tile_id, x, y)
		if (tile_type == COLLISION_MAP_TILE_STATIC) {
			col_tiles[col_tiles_count] = vec2(x,y)
			col_tiles_count += 1
		}
	}
}

for (var i = 0; i < col_tiles_count; i++) {
	var cur_tile_coord = col_tiles[i]
	var cur_tile_aabb = collision_map_get_cell_aabb(cur_tile_coord[Xi], cur_tile_coord[Yi])
	
	// Find where we cross the tile's x plane with our forward edge.
	var forward_x_plane = if_positive_else(vel_sign[Xi], aabb[AABB_R], aabb[AABB_L])
	var backward_tile_x_plane = if_positive_else(vel_sign[Xi], cur_tile_aabb[AABB_L] + 1.0, cur_tile_aabb[AABB_R])
	
	
}
*/
