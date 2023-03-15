function PlayerStateOpeningSeed(){
	EntityMovement();
	if(AnimationEnd())
	{
		with(seed_to_open)
		{
			state = seed_state_already_opened;
			sprite_index = sprite_opening;
			image_index = 0;
		}
		EntityMakeFree();
	}
}