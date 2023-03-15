function PlayerWakeUp(){
	with(global.oPlayer)
	{
		sprite_index = spr_hero_wake_up;
		image_index = 0;
		state = PlayerStateWakeUp;
		with(staff_inst) fly_to_the_hand = true;
	}
}