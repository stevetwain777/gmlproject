/// TGMS_ClearAllRooms()
/*
    RETURN:
        na
        
    INFO:
        Clears stored tween data from all persistent rooms  
*/

var _pRoomTweens = SharedTweener().pRoomTweens;

repeat(ds_map_size(_pRoomTweens))
{
    TGMS_ClearRoom(ds_map_find_first(_pRoomTweens));
}

