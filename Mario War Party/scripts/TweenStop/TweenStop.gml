/// TweenStop(tween)
/*
    @tween = tween id
    
    RETURN:
        na
        
    INFO:
        Stops the specified tween and any associated delay.
        Fired tween is automatically destroyed.
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }

if (_t[TWEEN.STATE] >= 0 || _t[TWEEN.STATE] <= TWEEN_STATE.PAUSED)
{
    if (_t[TWEEN.DELAY] > 0)
    {
        _t[@ TWEEN.DELAY] = -1;
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
    }
    else
    {
        if (_t[TWEEN.DELAY] != -10) { _t[@ TWEEN.DELAY] = -1; }
        _t[@ TWEEN.STATE] = TWEEN_STATE.STOPPED;
    }
        
    TweenDestroy(_t);
}