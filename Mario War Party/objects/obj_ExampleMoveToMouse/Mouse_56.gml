/// Tween position to mouse position

// Stop (destroy) any existing tweens
if (TweenExists(tween_x)) { TweenStop(tween_x); }
if (TweenExists(tween_y)) { TweenStop(tween_y); }

// Set values to be shared by both tweens
var _ease = EaseOutElastic, _mode = TWEEN_MODE_ONCE;
var _useSeconds = true, _delay = 0.0, _duration = 1.0;

// Fire tweens -- assign new ids to tween handles
tween_x = TweenFire(id, x__, _ease, _mode, _useSeconds, _delay, _duration, x, mouse_x);
tween_y = TweenFire(id, y__, _ease, _mode, _useSeconds, _delay, _duration, y, mouse_y);


