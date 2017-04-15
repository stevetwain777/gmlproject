/// Tween rotation of image angle

tween = TweenFire(id, image_angle__, EaseInOutBack, TWEEN_MODE_PATROL, true, 0.0, 2.0, 0, 360);


/// Manually create square sprite

var _surf = surface_create(100, 100);
surface_set_target(_surf);
    draw_set_colour(c_black); draw_rectangle(0, 0, 100, 100, false);
    draw_set_colour(c_white); draw_rectangle(2, 2, 97, 97, false);
surface_reset_target();
sprite_index = sprite_create_from_surface(_surf, 0, 0, 100, 100, false, false, 50, 50);
surface_free(_surf);

