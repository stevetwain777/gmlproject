// x = argument0

var xPos = argument0

if (xPos <= global.col_tile_x) {
	return 0
}
if (xPos >= global.col_tile_x + (global.col_tile_count_x * global.col_tile_width)) {
	return global.col_tile_count_x - 1
}
return tilemap_get_cell_x_at_pixel(global.col_tile_id, xPos, 10.0)