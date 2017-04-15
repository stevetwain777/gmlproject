var r0 = argument0
var r1 = argument1

var aabb = [max(r0[AABB_L], r1[AABB_L]),
						min(r0[AABB_R], r1[AABB_R]),
						max(r0[AABB_T], r1[AABB_T]),
						min(r0[AABB_B], r1[AABB_B])]
						
if (aabb[AABB_R] < aabb[AABB_L] || aabb[AABB_B] < aabb[AABB_T]) {
	return undefined
}
else {
	return aabb
}