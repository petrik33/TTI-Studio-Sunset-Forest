///@func FadeInRoomNext(time*)
///@arg time (default = noone)
function FadeInRoomNext(_time){
	with(instance_create_layer(0,0,"Managers",obj_fade_rm_transition))
	{
		target_room = room_next(room);
		if(_time!=noone)
		{
			fade_speed = 1 / (_time * FRAME_RATE);
		}
	}
}

///@func FadeInRoom(room,time*)
///@arg room
///@arg time
function FadeInRoom(_room,_time){
	with(instance_create_layer(0,0,"Managers",obj_fade_rm_transition))
	{
		target_room = _room;
		if(_time!=noone && _time!=-1)
		{
			fade_speed = 1 / (_time * FRAME_RATE);
		}
	}
}