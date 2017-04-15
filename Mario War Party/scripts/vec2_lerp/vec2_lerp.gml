var v0 = argument0
var v1 = argument1
var t = argument2

return vec2(lerp(v0[Xi], v1[Xi], t),
						lerp(v0[Yi], v1[Yi], t))