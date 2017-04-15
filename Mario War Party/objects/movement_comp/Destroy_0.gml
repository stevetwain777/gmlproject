var idx = ds_list_find_index(global.movement_instances, self)
ds_list_delete(global.movement_instances, idx)

collision_info_destroy(mov_collision_info)