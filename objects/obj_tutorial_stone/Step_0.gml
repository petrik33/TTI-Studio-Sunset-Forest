event_inherited();

if(FLOOR_Y - y <= from_floor_to_jump)
{
	CheckForPlayerFallNear();	
}

if(place_meeting(x,y,obj_tutorial_shrine))
{
	TutorialShrineActivate();
	instance_destroy();
}

if(state == EntityStatePushed)
{
	SetProperTraectory();
}

if(bbox_bottom < FLOOR_Y)
{
	Vy += _gravity;
	EntityCollision();
}
else
{
	y += Vy;
	Vy += _gravity;
	if(y + Vy >= ystart)
	{
		y = ystart;
		Vy = 0;
		push_vulnerable = false;
	}
}