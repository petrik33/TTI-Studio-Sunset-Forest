///@arg target
///@arg duration
///@arg movement_direction_buffer
function EntityStun(_target,_duration,_move_dir_buffer){
	if(_duration <= 0)
	{
		return;
	}
	if(_target.stun_vulnerable)
	{
		with(instance_create_layer(x + 10 * image_xscale,bbox_top,"Effects",obj_stun))
		{
			duration = FRAME_RATE * _duration;
			target = _target;
			movement_dir_buffer = _move_dir_buffer;
		}
		with(_target)
		{
			state = EntityStunned;
			Vx = 0;
			image_speed = 0;
			image_index = 0;
			sprite_index = sprite_pushed;
		}
	}
}