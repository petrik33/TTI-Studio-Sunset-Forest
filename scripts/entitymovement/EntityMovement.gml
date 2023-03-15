function EntityMovement() {
	
#region//Acceleration
	if(movement_direction!=0)
	{
		if(spd-abs(Vx)>acceleration_speed || movement_direction!=sign(Vx) )
		{
			Vx += acceleration_speed * movement_direction;
		}
		else
		{
			Vx = movement_direction * spd;
		}
	}
	else
	{
		if(abs(Vx) - 0 > decceleration_speed)
		{
			Vx -= decceleration_speed * sign(Vx);
		}
		else
		{
			Vx = 0;	
		}
	}
	
	#region//In the Air
	if(y < FLOOR_Y - 1)
	{
		Vy+=_gravity;
	}
	#endregion

#endregion

EntityCollision();

}
