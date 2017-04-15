/// TweenSetEase(tween,ease)

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;

_t[@ TWEEN.EASE] = argument1;
if (_t[TWEEN.STATE] >= 0 && _t[TWEEN.DURATION]!= 0)
{
    if (_t[TWEEN.PROPERTY] != null__) script_execute(_t[TWEEN.PROPERTY], script_execute(_t[TWEEN.EASE], _t[TWEEN.TIME], _t[TWEEN.START], _t[TWEEN.CHANGE], _t[TWEEN.DURATION]), _t[TWEEN.DATA], _t[TWEEN.TARGET]);
}

