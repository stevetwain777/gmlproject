/// TweenSetTarget(tween,instance)

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;

var _target = argument1.id;
    
if (_t[TWEEN.TARGET] != noone)
{
    _t[@ TWEEN.TARGET] = _target;
    
    if (_t[TWEEN.STATE] >= 0) { _t[@ TWEEN.STATE] = _target; }
    
    _t[@ TWEEN.DATA] = _target;
}

