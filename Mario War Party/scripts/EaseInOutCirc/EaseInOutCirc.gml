/// EaseInOutCirc(time,start,change,duration)

var _arg0 = argument0 / (argument3 * 0.5);

if (_arg0 < 1){
    return argument2 * 0.5 * (1 - sqrt(1 - _arg0 * _arg0)) + argument1;
}

_arg0 -= 2;
return argument2 * 0.5 * (sqrt(1 - _arg0 * _arg0) + 1) + argument1;


