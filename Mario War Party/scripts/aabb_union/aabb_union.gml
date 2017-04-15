var r0 = argument0
var r1 = argument1

return [r0[AABB_L] < r1[AABB_L] ? r0[AABB_L] : r1[AABB_L],
				r0[AABB_R] > r1[AABB_R] ? r0[AABB_R] : r1[AABB_R],
				r0[AABB_T] < r1[AABB_T] ? r0[AABB_T] : r1[AABB_T],
				r0[AABB_B] > r1[AABB_B] ? r0[AABB_B] : r1[AABB_B]]