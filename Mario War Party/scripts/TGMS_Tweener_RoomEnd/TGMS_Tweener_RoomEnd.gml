/// TGMS_Tweener_RoomEnd()

var _tweens = tweens;
var _simpleTweens = simpleTweens;
var _delayedTweens = delayedTweens;
var _tempPersistent = false;

//------------------------------------------
// Handle Persistent Room
//------------------------------------------
if (room_persistent)
{
    var _key = room;       // Set map key as room id
    keepPersistent = true; // Tell shared tweener to remain persistent -- tell it who's boss!
    
    // Create persistent queue for room if it doesn't exist
    if (ds_map_exists(pRoomTweens, _key) == false) { ds_map_replace(pRoomTweens, _key, ds_queue_create()); }
    
    var _pRoomQueue = pRoomTweens[? _key]; // Cache room's tween queue
        
    // Add tweens to persistent room data 
    var _index = ds_list_size(_tweens);
    repeat(_index)
    {  
        var _t = _tweens[| --_index];   // Get tween and decrement iterator
        var _target = _t[TWEEN.TARGET]; // Cache tween's target
        
        if (instance_exists(_target))
        {
            if (_target.persistent == false)
            {
                ds_queue_enqueue(_pRoomQueue, _t); // Add tween to persistent room queue
                ds_list_delete(_tweens, _index);   // Remove from main tween list
            }
        }
        else
        {
            instance_activate_object(_target); // Attempt to activate target
            
            // IF the tween's target now exists
            if (instance_exists(_target))
            {
                // IF the target instance isn't persistent
                if (_target.persistent == false)
                {
                    ds_queue_enqueue(_pRoomQueue, _t); // Add tween to persistent room queue
                    ds_list_delete(_tweens, _index);   // Remove from main tween list
                }
                
                instance_deactivate_object(_target); // Put target back to deactivated state
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent attempt to destroy target instance
                TweenDestroy(_t);        // Destroy tween
            }
        }
    }
    
    //----------------------
    //  Handle delays
    //----------------------
    // Create persistent delays queue for room if it doesn't exist
    if (ds_map_exists(pRoomDelays, _key) == false) { ds_map_replace(pRoomDelays, _key, ds_queue_create()); }
    
    var _pRoomDelays = pRoomDelays[? _key]; // Cache room's delayed tweens queue
    
    // Iterate through all delayed tweens backwards
    var _index = ds_list_size(delayedTweens);
    repeat(_index)
    {
        var _t = delayedTweens[| --_index]; // Get tween and decrement iterator
        var _target = _t[TWEEN.TARGET];     // Cache tween's target
        
        // IF target exists
        if (instance_exists(_target))
        {
            // IF target is not persistent
            if (_target.persistent == false)
            {
                ds_list_delete(delayedTweens, _index); // Remove delay from main delay list
                ds_queue_enqueue(_pRoomDelays, _t);    // Add delay to persistent room queue
            }
        }
        else
        {
            instance_activate_object(_target); // Attempt to activate target
            
            // IF target now exists
            if (instance_exists(_target))
            {
                // IF target is not persistent
                if (_target.persistent == false)
                {
                    ds_list_delete(delayedTweens, _index); // Remove delay from main delay list
                    ds_queue_enqueue(_pRoomDelays, _t);    // Add delay to persistent room queue
                }
                
                instance_deactivate_object(_target); // Put target back to deactivated state  
            }
        }
    }             
}
else
{ 
    //------------------------------------------------
    // Handle Non-Persistent Room
    //------------------------------------------------ 
    var _index = ds_list_size(_tweens);
    repeat(_index)
    {  
        var _t = _tweens[| --_index];   // Get tween and increment iterator
        var _target = _t[TWEEN.TARGET]; // Cahce tween's target instance
        
        // IF target exists and is persistent, signal tweening system to be persistent
        if (instance_exists(_target))
        {
            // IF target is persistent
            if (_target.persistent)
            {
                _tempPersistent = true; // Signal system to remain persistent
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                TweenDestroy(_t);        // Destroy tween
            }
        }
        else
        {
            instance_activate_object(_target); // Attempt to activate instance
            
            // IF target now exists
            if (instance_exists(_target))
            {
                // IF target is persistent
                if (_target.persistent)
                {
                    _tempPersistent = true; // Signal system to remain persistent
                }
                else
                {
                    _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                    TweenDestroy(_t);        // Destroy tween
                }
                
                instance_deactivate_object(_target); // Put target back to deactive state
            }
            else
            {
                _t[@ TWEEN.DESTROY] = 1; // Do this to prevent any attempt to destroy target
                TweenDestroy(_t);        // Destroy tween
            }
        }
    }
}

//-----------------------------------------------------
// Destroy Shared Tweener if not set as persistent
//-----------------------------------------------------
if (keepPersistent || _tempPersistent)  { persistent = true; }
else                                    { instance_destroy(); }