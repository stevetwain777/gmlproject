var aabb = argument0

var width = aabb[AABB_R] - aabb[AABB_L]
var height = aabb[AABB_B] - aabb[AABB_T]

return vec2(aabb[AABB_L] + (width / 2.0), aabb[AABB_T] + (height / 2.0))