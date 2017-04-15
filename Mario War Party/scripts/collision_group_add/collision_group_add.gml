var group_list = argument0
var inst_0  = argument1
var group_0 = argument2
var inst_1  = argument3
var group_1 = argument4

// If both noone, group needs to be created.
if (group_0 == noone && group_1 == noone) {
	var in_group = ds_list_create()
	ds_list_add(in_group, inst_0)
	ds_list_add(in_group, inst_0)
	ds_list_add(group_list, in_group)
}
// If just group_0 is noone, add it to group_1
else if (group_0 == noone) {
	ds_list_add(group_1, inst_0)
	inst_0.mov_collision_info[? CI_GROUP] = group_1
}
// If just group_1 is noone, add it to group_0
else if (group_1 == noone) {
	ds_list_add(group_0, inst_1)
	inst_1.mov_collision_info[? CI_GROUP] = group_0
}
// If both have a group, it needs to be merged.
else {
	var out_group_cnt = ds_list_size(group_0)
	for (var i = 0; i < out_group_cnt; i++) {
		var out_inst = group_0[| i]
		out_inst.mov_collision_info[? CI_GROUP] = group_1
		ds_list_add(group_1, out_inst)
	}
	var out_group_idx = ds_list_find_index(group_list, group_0)
	ds_list_delete(group_list, out_group_idx)
	ds_list_destroy(group_0)
}