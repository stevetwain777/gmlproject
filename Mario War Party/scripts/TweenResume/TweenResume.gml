/// TweenResume(tweens)
/*
    @tween = tween id
    
    RETURN:
        NA
        
    INFO:
        Resumes specified tween and any associated delay
*/

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) { return 0; }
    
if (_t[TWEEN.STATE] == TWEEN_STATE.PAUSED)
{
    if (_t[TWEEN.DELAY] > 0)
    {
        _t[@ TWEEN.STATE] = TWEEN_STATE.DELAYED;
    }
    else
    {
        _t[@ TWEEN.STATE] = _t[TWEEN.TARGET];
    }
}