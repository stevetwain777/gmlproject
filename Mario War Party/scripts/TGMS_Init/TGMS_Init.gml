/// TGMS_Init()
/*
    !DO NOT CALL THIS!
    Automatically called by the extension.
*/

//-----------------------------------------------
// Declare default global system-wide settings
//-----------------------------------------------
global.TGMS_SharedTweener = noone;    // Declare global variable for holding shared tweener instance

//---------------------------
// Create ID Maps
//---------------------------
global.TGMS_MAP_TWEEN = ds_map_create();
global.TGMS_MAP_CALLBACK = ds_map_create();

//--------------------------------
// Initiate ID Indexes
//--------------------------------
global.TGMS_INDEX_TWEEN = 1;
global.TGMS_INDEX_CALLBACK = 1;

//-------------------------------
// Declare Enum Constants
//-------------------------------
// CALLBACK DATA
enum TWEEN_CALLBACK{ID,ENABLED,TARGET,SCRIPT,ARG0,ARG1,ARG2,ARG3,ARG4,ARG5,ARG6,ARG7,ARG8,ARG9,ARG10,ARG11,ARG12,ARG13,ARG14,ARG15};

// TWEEN STATES
enum TWEEN_STATE{DESTROYED=-4,STOPPED=-10,PAUSED=-11,DELAYED=-12};

// TWEEN DATA
enum TWEEN
{
    TIME,
    START,
    CHANGE,
    DURATION,
    STATE,
    DELTA,
    EASE,
    PROPERTY,
    TARGET,
    GROUP,
    DIRECTION,
    EVENTS,
    DESTROY,
    SIMPLE_KEY,
    MODE,
    DATA,
    DELAY,
    DELAY_START,
    ID,
    DATA_SIZE
};

//---------------------------
// Create Default Tween
//---------------------------
global.TGMS_TweenDefault[TWEEN.ID] = 0;
global.TGMS_TweenDefault[TWEEN.TARGET] = noone;
global.TGMS_TweenDefault[TWEEN.EASE] = EaseLinear;
global.TGMS_TweenDefault[TWEEN.TIME] = 0;
global.TGMS_TweenDefault[TWEEN.START] = 0;
global.TGMS_TweenDefault[TWEEN.CHANGE] = 1;
global.TGMS_TweenDefault[TWEEN.DURATION] = 1;
global.TGMS_TweenDefault[TWEEN.PROPERTY] = null__;
global.TGMS_TweenDefault[TWEEN.STATE] = TWEEN_STATE.STOPPED;
global.TGMS_TweenDefault[TWEEN.DELTA] = false;
global.TGMS_TweenDefault[TWEEN.GROUP] = 0;
global.TGMS_TweenDefault[TWEEN.EVENTS] = -1;
global.TGMS_TweenDefault[TWEEN.SIMPLE_KEY] = -1;
global.TGMS_TweenDefault[TWEEN.DESTROY] = 0;
global.TGMS_TweenDefault[TWEEN.DIRECTION] = 1;
global.TGMS_TweenDefault[TWEEN.MODE] = TWEEN_MODE_ONCE;
global.TGMS_TweenDefault[TWEEN.DATA] = 0;
global.TGMS_TweenDefault[TWEEN.DELAY] = -10;
global.TGMS_TweenDefault[TWEEN.DELAY_START] = 0;

// Assign default tween as first in global id map
global.TGMS_MAP_TWEEN[? 1] = global.TGMS_TweenDefault;


