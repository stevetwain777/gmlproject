/// TweenSetProperty(tween,property)

var _t = TGMS_FetchTween(argument0);
if (is_undefined(_t)) return 0;

_t[@ TWEEN.PROPERTY] = argument1;
_t[@ TWEEN.DATA] = _t[TWEEN.TARGET];


