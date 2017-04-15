enum collision_category {
	none			= $0,
	player		= $1,
	wall			= $2,
}

mov_category = 0

ds_list_add(global.collision_instances, self)