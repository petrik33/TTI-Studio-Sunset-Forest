function PlayerStateWakeUp(){
	if(AnimationEnd())
	{
		//EntityCollision();
		image_index = image_number-1;
		image_speed = 0;
		sleeping = false;
		if(!instance_exists(staff_inst) || staff_inst.in_the_hand = true)
		{
			instance_destroy(staff_inst);
			sprite_index = paused_sprite;
			image_index = paused_image_index;
			image_speed = 1;
			state = state_before_sleep;
		}
	}
}