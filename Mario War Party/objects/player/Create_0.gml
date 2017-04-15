event_inherited()

player_sprite = player_classic_spr
add_comp(player_anim_comp)

anim_state = player_animation_state.idle
facing_dir = facing_direction.left

add_comp(player_movement_comp)
add_comp(keyboard_input_comp)
add_comp(movement_anim_binding_comp)

mov_category = collision_category.player
mov_collision_category = (collision_category.player | collision_category.wall)