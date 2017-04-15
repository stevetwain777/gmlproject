/// EaseInOutExpo(time,start,change,duration)

var _arg0 = argument0 / (argument3 * 0.5);

if (_arg0 < 1) {
    return argument2 * 0.5 * power(2, 10 * --_arg0) + argument1;
}

return argument2 * 0.5 * (-power(2, -10 * --_arg0) + 2) + argument1;


