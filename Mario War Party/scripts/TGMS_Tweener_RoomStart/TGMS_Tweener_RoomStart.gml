/// TGMS_Tweener_RoomStart()

autoCleanIndex = 0; // Reset auto-cleaner index

// IF the entered room is persistent
if (room_persistent)
{   
    var _tweens = tweens;               // Cache tweens list
    var _delayedTweens = delayedTweens; // Cache delayed tweens
    var _key = room;                    // Cache room name for map key
    keepPersistent = true;              // Tell obj_SharedTweener to remain persistent
    
    // IF stored tween data exists for persistent room
    if (ds_map_exists(pRoomTweens, _key))
    {
        var _queuedTweens = pRoomTweens[? _key]; // Cache queue of room's tweens
        // Iterate through queue, adding stored tweens back to main tween list
        repeat(ds_queue_size(_queuedTweens)) { ds_list_add(_tweens, ds_queue_dequeue(_queuedTweens)); }
    }
    
    // IF stored tween delay data exists for persistent room
    if (ds_map_exists(pRoomDelays, _key))
    {
        var _queuedDelays = pRoomDelays[? _key]; // Cache queue of room's delayed tweens
        // Iterate through queue, adding stored tween delays back to main tween delay list
        repeat(ds_queue_size(_queuedDelays)) { ds_list_add(_delayedTweens, ds_queue_dequeue(_queuedDelays)); }
    }
}

