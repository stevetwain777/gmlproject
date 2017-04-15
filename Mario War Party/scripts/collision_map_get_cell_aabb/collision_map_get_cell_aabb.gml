var cell_x = argument0
var cell_y = argument1

var aabb
aabb[AABB_L] = global.col_tile_x + (cell_x * global.col_tile_width)
aabb[AABB_R] = aabb[AABB_L] + global.col_tile_width

aabb[AABB_T] = global.col_tile_y + (cell_y * global.col_tile_height)
aabb[AABB_B] = aabb[AABB_T] + global.col_tile_height

return aabb