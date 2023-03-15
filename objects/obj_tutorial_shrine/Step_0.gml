if(tutorial_shrine_activate)
{
	if(AnimationEnd())
	{
		sprite_index = spr_tutorial_shrine_on;
		image_index = 0;
		tutorial_shrine_activate = false;
		tutorial_end();
	}
}