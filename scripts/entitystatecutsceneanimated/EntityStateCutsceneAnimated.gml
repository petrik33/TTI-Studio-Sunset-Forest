function EntityStateCutsceneAnimatedEndModeBackToIdle(){
	EntityMovement();
	if(image_speed == 1)
	{
		if(AnimationEnd())
		{
			EntityMakeStatic();	
		}
	}
	else
	{
		if(AnimationEndReverse())
		{
			EntityMakeStatic();	
		}
	}
}

function EntityStateCutsceneAnimatedEndModeStatic(){
	EntityMovement();
	if(AnimationEnd())
	{
		state = EntityStateStatic;
		image_speed = 0;
	}	
}