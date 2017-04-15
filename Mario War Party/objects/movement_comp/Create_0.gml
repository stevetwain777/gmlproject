#macro mov_max_speed 250.0
#macro mov_acceleration 1500.0
#macro mov_ice_acceleration_modifier 0.35
#macro mov_gravity 900.0
#macro mov_friction 4000.0
#macro mov_ice_friction_modifier 0.07
#macro mov_velocity_threshold 0.1
#macro mov_max_fall_speed 4800.0

mov_velocity = vec2_zero()
mov_collision_info = collision_info_create(self)
mov_collision_info[? CI_LAST_GROUND_TYPE] = tile_type.empty
mov_collision_category = 0
mov_position = vec2(x, y)

ds_list_add(global.movement_instances, self)