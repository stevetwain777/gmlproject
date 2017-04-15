var v0 = argument0
var v

var len = vec2_len(v0)
if (len != 0) {
	v[0] = v0[0] / len
	v[1] = v0[1] / len
}
else {
	v[0] = 0.0
	v[1] = 0.0
}
return v