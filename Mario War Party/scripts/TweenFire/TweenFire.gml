/// TweenFire(target,prop,ease,mode,delta,delay,dur,start,dest)
/*
    @target   = instance to associate with tween
    @prop     = property setter script
    @ease     = ease script
    @mode     = tween mode (0=ONCE, 1=BOUNCE, 2=PATROL)
    @delta    = whether or not to use delta(seconds) timing -- false will use step timing
    @delay    = amount of time to delay tween before playing (relative to delta)
    @dur      = duration of time to play tween
    @start    = start value of eased property
    @dest     = destination value of eased property
    
    RETURN:
        tween ID
    
    INFO:
        Creates and plays a tween which is automatically destroyed when
        finished, stopped, or target instance is destroyed.
        
        The "mode" argument can take any of the following TWEEN MODE CONSTANTS:
        
            0 = TWEEN_MODE_ONCE       ... plays once from start to destination
            1 = TWEEN_MODE_BOUNCE     ... plays to destination then continues back to start
            2 = TWEEN_MODE_PATROL     ... continues back and forth between start and destination
            
            [TweenGMS Pro]
            3 = TWEEN_MODE_LOOP       ... continuously loops back to start after reaching destination
            4 = TWEEN_MODE_REPEAT     ... continues endlessly from destination
        
    Example:
        // Bounce 'x' back and forth between x and mouse_x positions
        tween = TweenFire(id, x__, EaseInSine, TWEEN_MODE_PATROL, true, 0.0, 1.50, x, mouse_x);
*/

if (argument_count == 9)
{
    var _t = global.TGMS_TweenDefault;
    var _property = argument[1];
    
    var _tIndex = ++global.TGMS_INDEX_TWEEN;    // Get new tween id
    _t[TWEEN.ID] = _tIndex                      // Assign new tween id
    _t[TWEEN.TARGET] = argument[0].id;          // Set target to instance
    _t[TWEEN.EASE] = argument[2];               // Set tween's ease algorithm
    _t[TWEEN.MODE] = argument[3];               // Set tween play mode
    _t[TWEEN.DELTA] = argument[4];              // Set delta
    _t[TWEEN.DURATION] = argument[6];           // Set tween's duration
    _t[TWEEN.START] = argument[7];              // Set start value
    _t[TWEEN.CHANGE] = argument[8]-argument[7]; // Calculate change value (dest-start)
    _t[TWEEN.DESTROY] = 1;                      // Destroy tween when finished
    _t[TWEEN.PROPERTY] = _property;             // Set tween's property setter script
    _t[TWEEN.DATA] = _t[TWEEN.TARGET];          // Set tween's data as target id
        
    if (argument[5] <= 0) // If no delay set
    {   
        _t[TWEEN.STATE] = _t[TWEEN.TARGET]; // Set tween state as playing
        script_execute(_property, _t[TWEEN.START], _t[TWEEN.DATA], _t[TWEEN.TARGET]); // Update property to start value
    }
    else
    {
        _t[TWEEN.STATE] = TWEEN_STATE.DELAYED; // Set state as delayed
        _t[TWEEN.DELAY] = argument[5]; // Assign delay list reference to tween
        _t[TWEEN.DELAY_START] = argument[5]; // Set starting delay time
        ds_list_add(SharedTweener().delayedTweens, _t); // Add tween to global delayed list   
    }
    
    ds_list_add(SharedTweener().tweens, _t); // Add tween to global tweens list
    global.TGMS_MAP_TWEEN[? _tIndex] = _t; // Associate tween with global id
    return _tIndex; // Return tween id
}
else // Check for old version
if (argument_count == 7)
{
    return TweenFire(argument[0], argument[1], argument[3], TWEEN_MODE_ONCE, argument[2], 0, argument[6], argument[4], argument[5]);
}
