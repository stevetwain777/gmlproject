/// TweenAddCallback(tween,event,target,script[,arg0,arg1,...])
/*
    @tween   = tween id
    @event   = tween event constant -- TWEEN_EV_****
    @target  = instance environment to use when calling script
    @script  = script to be executed
    @arg0... = (optional) arguments to pass to script
    
    RETURN:
        callback id
        
    INFO:
        Sets a script to be called on specified tween event.
        Multiple callbacks can be added to the same event.
        Up to 12 arguments can be passed to the callback script.
        
        "event" can take any of the following TWEEN_EV_**** constants:
        TWEEN_EV_FINISH
        TWEEN_EV_CONTINUE  
        
        Additional events available in TweenGMS Pro:
        TWEEN_EV_PLAY
        TWEEN_EV_PAUSE
        TWEEN_EV_RESUME
        TWEEN_EV_STOP
        TWEEN_EV_REVERSE
        
        TWEEN_EV_FINISH_DELAY
        TWEEN_EV_PAUSE_DELAY
        TWEEN_EV_RESUME_DELAY
        TWEEN_EV_STOP_DELAY
*/

var _t = TGMS_FetchTween(argument[0]);
if (is_undefined(_t)) { return undefined; }

var _events = _t[TWEEN.EVENTS];
var _cb;

// Create and assign events map if it doesn't exist
if (_events == -1)
{
    _events = ds_map_create();
    _t[@ TWEEN.EVENTS] = _events;
}

var _index = argument_count;
repeat(_index-4)
{
    --_index;
    _cb[_index] = argument[_index];
}

// Store new callback index handle inside callback
_cb[TWEEN_CALLBACK.ID] = ++global.TGMS_INDEX_CALLBACK;
// Set default state as active
_cb[TWEEN_CALLBACK.ENABLED] = true;
// Assign target to callback
_cb[TWEEN_CALLBACK.TARGET] = argument[2];
// Assign script to callback
_cb[TWEEN_CALLBACK.SCRIPT] = argument[3]; 
// Assign callback handle to callback map
global.TGMS_MAP_CALLBACK[? global.TGMS_INDEX_CALLBACK] = _cb;

// IF event type exists...
if (ds_map_exists(_events, argument[1]))
{
    // Cache event
    var _event = _events[? argument[1]];
    // Add event to events map
    ds_list_add(_event, _cb);
    
    // Do some event callback cleanup if size starts to get larger than expected
    if (ds_list_size(_event) mod 10 == 0)
    {   
        ds_priority_add(SharedTweener().eventCleaner, _event, _event);
    }
}
else
{
    // Create event list
    var _event = ds_list_create();
    // Add STATE and CALLBACK to event
    ds_list_add(_event, true, _cb);
    // Add event to events map
    _events[? argument[1]] = _event;
}

// Return callback handle
return global.TGMS_INDEX_CALLBACK;