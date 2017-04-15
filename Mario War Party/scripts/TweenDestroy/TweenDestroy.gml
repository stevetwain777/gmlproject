/// TweenDestroy(tween)
/*
    @tween = tween id
    
    RETURNS:
        null tween id
        
    INFO:
        Manually destroys the specified tween.
        Note: Tweens are automatically destroyed when their target instance is destroyed.
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return undefined; }
if (_t[TWEEN.STATE] == TWEEN_STATE.DESTROYED) { return undefined; }

ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]);                // Invalidate tween handle
ds_map_delete(SharedTweener().simpleTweens, _t[TWEEN.SIMPLE_KEY]); // Delete simple tween data
_t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED;                         // Set state as destroyed
_t[@ TWEEN.ID] = undefined;                                        // Nullify self reference

// Invalidate tween target or destroy target instance depending on destroy mode
if (_t[TWEEN.DESTROY] != 2)
{ 
    _t[@ TWEEN.TARGET] = noone; // Invalidate target instance
}
else // Destroy target instance
{
    var _target = _t[TWEEN.TARGET]; // Get target to destroy
    
    if (instance_exists(_target))
    {
        with(_target) instance_destroy();
    }
    else
    {
        instance_activate_object(_target); // Attempt to activate target by chance it was deactivated
        with(_target) instance_destroy(); // Attempt to destroy target
    } 
}

// IF tween events map exists
if (_t[TWEEN.EVENTS] != -1)
{
    // Cache events and find first event key
    var _events = _t[TWEEN.EVENTS];
    var _key = ds_map_find_first(_events);
    
    // Iterate events
    repeat(ds_map_size(_events))
    {
        var _event = _events[? _key]; // Get event
        
        // Iterate through event callbacks
        var _cbIndex = 0;
        repeat(ds_list_size(_event)-1)
        {
            // Get callback and invalidate handle
            var _cb = _event[| ++_cbIndex];
            ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[TWEEN_CALLBACK.ID]);
        }
        
        _key = ds_map_find_next(_events, _key); // Find key for next event
    }
}

return undefined;
