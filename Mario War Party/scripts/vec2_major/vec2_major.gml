// Reduce a vector to a unit vector of its major component
var v = argument0

if (abs(v[0]) > abs(v[1])) {
	return vec2(sign(v[0]), 0.0)
}
else {
	return vec2(0.0, sign(v[1]))
}