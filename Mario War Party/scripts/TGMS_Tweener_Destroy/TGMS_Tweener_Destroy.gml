/// TGMS_Tweener_Destroy()

//-------------------------------------------------
// Destroy Tweens and Delays for Persistent Rooms
//-------------------------------------------------
TGMS_ClearAllRooms();

//---------------------------------------------
// Destroy remaining tweens
//---------------------------------------------
var _tweens = tweens;
var _tIndex = ds_list_size(_tweens);
repeat(_tIndex)
{   
    var _t = _tweens[| --_tIndex];             // Get tween and decrement iterator
    ds_list_delete(_tweens, _tIndex);          // Remove tween from tweens list
    _t[@ TWEEN.STATE] = TWEEN_STATE.DESTROYED; // Set state as destroyed
    _t[@ TWEEN.ID] = undefined;                // Nullify self reference
    
    // Destroy tween events if events map exists
    if (_t[TWEEN.EVENTS] != -1)
    {
        var _events = _t[TWEEN.EVENTS]; // Cache events
        
        // Iterate through events
        repeat(ds_map_size(_events))
        {
            ds_list_destroy(_events[? ds_map_find_first(_events)]); // Destroy event list
            ds_map_delete(_events, ds_map_find_first(_events));     // Delete event key   
        }
        
        ds_map_destroy(_events); // Destroy events map
    }
}

// Remove self as shared tweener singleton
global.TGMS_SharedTweener = noone;

//---------------------------------------
// Destroy Data Structures
//---------------------------------------
ds_list_destroy(tweens);
ds_list_destroy(delayedTweens);
ds_map_destroy(simpleTweens);
ds_map_destroy(pRoomTweens);
ds_map_destroy(pRoomDelays);
ds_priority_destroy(eventCleaner);

//---------------------------------------
// Clear id reference maps
//---------------------------------------
ds_map_clear(global.TGMS_MAP_TWEEN);
ds_map_clear(global.TGMS_MAP_CALLBACK);

