// y = argument0

var yPos = argument0

if (yPos < global.col_tile_y) {
	return 0
}
if (yPos > global.col_tile_y + (global.col_tile_count_y * global.col_tile_height)) {
	return global.col_tile_count_y - 1
}
return tilemap_get_cell_y_at_pixel(global.col_tile_id, 10.0, yPos)