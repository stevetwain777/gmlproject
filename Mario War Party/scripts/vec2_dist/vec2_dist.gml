var v0 = argument0
var v1 = argument1

var dx = v0[0] - v1[0]
var dy = v0[1] - v1[0]
var dist = dx*dx + dy*dy

if (dist != 0) {
	dist = sqrt(dist)
}
return dist