var inst = argument0

var sprite = inst.sprite_index
if (sprite != -1) {
	var left = sprite_get_bbox_left(sprite)
	var right = sprite_get_bbox_right(sprite)
	var top = sprite_get_bbox_top(sprite)
	var bottom = sprite_get_bbox_bottom(sprite)

	var xOff = sprite_get_xoffset(sprite)
	var yOff = sprite_get_yoffset(sprite)

	return [(inst.mov_position[Xi] - xOff) + left,
					(inst.mov_position[Xi] - xOff) + right,
					(inst.mov_position[Yi] - yOff) + top,
					(inst.mov_position[Yi] - yOff) + bottom]
}
else {
	return [inst.bbox_left,
					inst.bbox_right,
					inst.bbox_top,
					inst.bbox_right]
}