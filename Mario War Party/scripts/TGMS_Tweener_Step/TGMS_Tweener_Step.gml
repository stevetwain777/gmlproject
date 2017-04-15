/// TGMS_Tweener_Step()

//--------------------------
// Manage Delta Timing
//--------------------------

prevDeltaTime = deltaTime;      // Store previous usable delta time format
deltaTime = delta_time/1000000; // Update usable delta time format

// Let's prevent delta time from exhibiting sporadic behaviour, shall we?
// IF the delta time is greater than the set max duration
if (deltaTime > maxDelta)
{
    // IF delta time was already restored
    if (deltaRestored)
    { 
        deltaTime = maxDelta; // Set delta time to max delta value
    } 
    else
    { 
        deltaTime = prevDeltaTime; // Restore delta time to value from previous step
        deltaRestored = true;      // Flag delta time as being restored
    }
}
else
{
    deltaRestored = false; // Clear restored flag
}

// Assign for optimisation
deltaSelect[1] = deltaTime;
var _deltaSelect = deltaSelect;

// Initiate local variables for iteration
var _tIndex, _tweens = tweens, _delayedTweens = delayedTweens;

//----------------------------------------
// Process delays
//----------------------------------------
_tIndex = -1;
repeat(ds_list_size(_delayedTweens))
{
    var _t = _delayedTweens[| ++_tIndex]; // Get next tween from delayed tweens list

    // IF tween instance exists AND delay is NOT destroyed
    if (_t[TWEEN.STATE] == TWEEN_STATE.DELAYED && instance_number(_t[TWEEN.TARGET]))
    { 
        // Decrement delay timer
        _t[@ TWEEN.DELAY] -= _deltaSelect[_t[TWEEN.DELTA]];
        
        // IF the delay timer has expired
        if (_t[TWEEN.DELAY] <= 0)
        {
            ds_list_delete(_delayedTweens, _tIndex--);  // Remove tween from delay list
            _t[@ TWEEN.DELAY] = -10;                    // Indicate that delay has been removed from delay list
            _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];       // Set tween as active    
            // Update property with start value                 
            script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]);
        }
    }
    else // If delay is marked for removal or tween is destroyed
    if (_t[TWEEN.DELAY] == -1 || _t[TWEEN.STATE] == TWEEN_STATE.DESTROYED)
    {
        ds_list_delete(_delayedTweens, _tIndex--); // Remove tween from delay list
        _t[@ TWEEN.DELAY] = -10;                   // Indicate that delay has been removed from delay list
    }
}

//--------------------------------------------------
// Process Tweens
//--------------------------------------------------
_tIndex = -1; 
repeat(ds_list_size(_tweens))
{
    var _t = _tweens[| ++_tIndex]; // Get tween and increment index

    // Process tween if target/state exists/active
    if (instance_number(_t[TWEEN.STATE]))
    {                    
        // Get updated tween time
        var _time = _t[TWEEN.TIME] + _t[TWEEN.DIRECTION] * _deltaSelect[_t[TWEEN.DELTA]];
        
        // IF tween is within start/destination
        if (_time > 0 && _time < _t[TWEEN.DURATION])
        {
            _t[@ TWEEN.TIME] = _time; // Assign updated time
            script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _time, _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET]); 
        }
        else // Tween has reached start or destination
        {
            // Update tween based on its play mode -- Could put overflow wait time in here????
            switch(_t[TWEEN.MODE])
            {
            case TWEEN_MODE_ONCE:
                _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;            // Set tween's state as STOPPED
                _t[@ TWEEN.TIME] = _t[TWEEN.DURATION]*(_time > 0);  // Update tween's time
                // Update property
                script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START] + _t[TWEEN.CHANGE]*(_time > 0), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
            break;
            
            case TWEEN_MODE_PATROL:
                _t[@ TWEEN.TIME] = _t[TWEEN.DURATION] * 2 * (_time > 0) - _time; // Update tween's time
                // Update property
                script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse tween's direction
                TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
            break;
               
            case TWEEN_MODE_BOUNCE:
                if (_time > 0)
                {
                    _t[@ TWEEN.TIME] = 2*_t[TWEEN.DURATION] - _time; // Update tween's time
                    // Update property
                    script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                    _t[@ TWEEN.DIRECTION] = -_t[TWEEN.DIRECTION];           // Reverse direction 
                    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_CONTINUE); // Execute CONTINUE event
                }
                else
                {
                    _t[@ TWEEN.TIME] = 0; // Update tween's time
                    // Update property
                    script_execute(_t[TWEEN.PROPERTY], _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]);
                    _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;              // Set tween state as STOPPED
                    TGMS_ExecuteEvent(_t[TWEEN.EVENTS], TWEEN_EV_FINISH); // Execute FINISH event
                    if (_t[TWEEN.DESTROY]) { TweenDestroy(_t); }          // Destroy tween if temporary
                }
            break;
            
            default:
                show_error("Invalid Tween Mode! --> Reverting to TWEEN_MODE_ONCE", false);
                _t[@ TWEEN.MODE] = TWEEN_MODE_ONCE;
            }
        }
    }
}

//--------------------------------------------------
// Event Cleaner
//--------------------------------------------------
if (ds_priority_size(eventCleaner))
{
    var _event = ds_priority_delete_min(eventCleaner); // Get event to check for cleaning

    // Cycle through all callbacks, except the new one -- make sure not to check event status index event[0]
    var _cbIndex = ds_list_size(_event);
    repeat(_cbIndex-1)
    {
        var _cb = _event[| --_cbIndex];           // Get next callback and decrement iterator
        var _target = _cb[TWEEN_CALLBACK.TARGET]; // Cache callback's target instance
        
        // If the tween's target instance doesn't exist
        if (instance_exists(_target) == false)
        {
            instance_activate_object(_target); // Attempt to activate target instance
            
            // If the target instance now exists
            if (instance_exists(_target))
            {
                instance_deactivate_object(_target); // Put target instance back to deactivated state
            }
            else // Proceed to delete callback
            {
                ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[TWEEN_CALLBACK.ID]); // Invalidate global callback handle
                ds_list_delete(_event, _cbIndex);                                // Delete callback from event list
            }
        }
    }
}

//--------------------------------------------------
// Passive Tween Cleaner
//--------------------------------------------------
repeat(min(autoCleanIterations, autoCleanIndex, ds_list_size(_tweens)))
{   
    var _t = _tweens[| --autoCleanIndex]; // Cache tween
    
    // IF tween target does not exist
    if (instance_exists(_t[TWEEN.TARGET]) == false)
    {
        // IF tween is set for destruction
        if (_t[TWEEN.TARGET] == noone)
        {
            ds_list_delete(_tweens, autoCleanIndex); // Remove tween from tweens list
            
            // IF tween events are valid
            if (_t[TWEEN.EVENTS] != -1)
            {
                var _events = _t[TWEEN.EVENTS];        // Cache tween's events map
                var _key = ds_map_find_first(_events); // Get first key in data map
                
                // Cycle through all events
                repeat(ds_map_size(_events))
                {
                    ds_list_destroy(_events[? _key]);       // Destroy list data for specific event
                    _key = ds_map_find_next(_events, _key); // Get key to next event
                }
                
                ds_map_destroy(_events); // Destroy tween's events map
            }
        }
        else
        {
            instance_activate_object(_t[TWEEN.TARGET]); // Attempt to activate target instance
            
            // Put instance back to deactivated state if it now exists
            if (instance_exists(_t[TWEEN.TARGET]))
            {
                instance_deactivate_object(_t[TWEEN.TARGET]);
            }
            else // Handle tween destruction
            {
                ds_list_delete(_tweens, autoCleanIndex);            // Remove tween from tweens list
                ds_map_delete(global.TGMS_MAP_TWEEN, _t[TWEEN.ID]); // Invalidate tween handle
                ds_map_delete(simpleTweens, _t[TWEEN.SIMPLE_KEY]);  // Delete simple tween data
                _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED;          // Set tween state as destroyed
                
                // Destroy tween events if events map exists
                if (_t[TWEEN.EVENTS] != -1)
                {
                    var _events = _t[TWEEN.EVENTS];        // Cache events
                    var _key = ds_map_find_first(_events); // Find key to first event
                    
                    // Cycle through and destroy all events
                    repeat(ds_map_size(_events))
                    {
                        var _event = _events[? _key]; // Cache event
                        
                        // Invalidate callback handles
                        var _cbIndex = 0;
                        repeat(ds_list_size(_event)-1)
                        {
                            var _cb = _event[| ++_cbIndex];
                            ds_map_delete(global.TGMS_MAP_CALLBACK, _cb[TWEEN_CALLBACK.ID]);
                        }
                        
                        ds_list_destroy(_event);                // Destroy event list
                        _key = ds_map_find_next(_events, _key); // Find key for next event
                    }
                    
                    ds_map_destroy(_events); // Destroy events map
                }
            }
        }
    }
}

// Place auto clean index to size of tweens list if below or equal to 0
if (autoCleanIndex <= 0) { autoCleanIndex = ds_list_size(_tweens); }


