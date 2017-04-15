var r0 = argument0
var r1 = argument1

if (r0[AABB_R] < r1[AABB_L]) {
	return false
}
if (r0[AABB_L] > r1[AABB_R]) {
	return false
}
if (r0[AABB_B] < r1[AABB_T]) {
	return false
}
if (r0[AABB_T] > r1[AABB_B]) {
	return false
}
return true