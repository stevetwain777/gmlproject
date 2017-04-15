/// Tween scaling of image scale

TweenFire(id, image_scale__, EaseInOutQuad, TWEEN_MODE_PATROL, true, 0.0, 1.0, 1.0, 2.0);



/// Manually create triangle sprite

var _surf = surface_create(100, 99);
surface_set_target(_surf);
    draw_set_colour(c_black); draw_triangle(50, 0, 100, 100, 0, 100, false);
    draw_set_colour(c_white); draw_triangle(50, 3, 97, 97, 3, 97, false);
surface_reset_target();
sprite_index = sprite_create_from_surface(_surf, 0, 0, 100, 100, false, false, 50, 50);
surface_free(_surf);

