/// Declare null tween handles

tween_x = TweenNull();
tween_y = TweenNull();

/// Manually Create Circle Sprite

var _surf = surface_create(100, 100);
surface_set_target(_surf);
    draw_set_colour(c_black); draw_circle(50, 50, 50, false);
    draw_set_colour(c_white); draw_circle(50, 50, 47, false);
surface_reset_target();
sprite_index = sprite_create_from_surface(_surf, 0, 0, 100, 100, false, false, 50, 50);
surface_free(_surf);

