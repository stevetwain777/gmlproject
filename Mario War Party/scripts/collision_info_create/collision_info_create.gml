#macro CI_INSTANCE							"inst"
#macro CI_START_AABB						"s_aabb"
#macro CI_MOVE_BOUNDS						"m_bnds"
#macro CI_GROUP									"group"   // Only valid during movement loop
#macro CI_COLLIDE_SIDES					"c_sides"
#macro CI_GROUND_TYPE						"c_ground"
#macro CI_LAST_GROUND_TYPE			"last_gnd"
#macro CI_FINAL_VELOCITY_STEP		"f_vel"

var owner = argument0

var info = ds_map_create()
info[? CI_INSTANCE] = owner

return info