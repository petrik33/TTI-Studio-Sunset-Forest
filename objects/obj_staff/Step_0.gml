if(!instance_exists(global.oPlayer))
{
	instance_destroy();
	exit;
}

if(!fly_to_the_hand) //|| depth>depth_start || waving_progress<pi/3 )
{
	var _add_x = cos(waving_progress) * waving_x_amplitude;
	x = xstart + _add_x;
	y = global.oPlayer.y;
	depth = depth_start + sign(sin(waving_progress));

	waving_progress+=waving_spd;
	if(waving_progress>2*pi) waving_progress = waving_progress mod (2*pi);
}
else
{
	if(global.oPlayer.state != PlayerStateWakeUp)
	{
		instance_destroy();
		exit;
	}
	
	if(abs(x-fly_x_target)<=fly_spd)
	{
		x = fly_x_target;
		in_the_hand = true;
		//fly_to_the_hand = false;
	}
	else
	{
		x += sign(fly_x_target-x) * fly_spd;	
	}
}



