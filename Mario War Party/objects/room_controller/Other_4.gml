/// @description Initialize Collision Map Info

// Collision tile info
global.col_layer_id = layer_get_id("Collision")
global.col_tile_id = layer_tilemap_get_id(global.col_layer_id)
global.col_tile_width = tilemap_get_tile_width(global.col_tile_id)
global.col_tile_height = tilemap_get_tile_height(global.col_tile_id)
global.col_tile_count_x = tilemap_get_width(global.col_tile_id)
global.col_tile_count_y = tilemap_get_width(global.col_tile_id)
global.col_tile_x = tilemap_get_x(global.col_tile_id)
global.col_tile_y = tilemap_get_x(global.col_tile_id)