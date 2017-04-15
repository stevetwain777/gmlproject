var aabb = argument0
var vec = argument1

if (vec[Xi] > 0) {
	aabb[AABB_R] += vec[Xi]
}
else {
	aabb[AABB_L] += vec[Xi]
}

if (vec[Yi] > 0) {
	aabb[AABB_B] += vec[Yi]
}
else {
	aabb[AABB_T] += vec[Yi]
}

return aabb