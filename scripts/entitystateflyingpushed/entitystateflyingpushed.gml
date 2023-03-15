function EntityStateFlyingPushed(){
	//var oppositeDirection = point_direction(0,0,-Vx,-Vy);
	//var stoppingVx = lengthdir_x(decceleration_speed,oppositeDirection);
	//var stoppingVy = lengthdir_y(decceleration_speed,oppositeDirection);
	//Vx+=stoppingVx;
	//Vy+=stoppingVy;
	if(abs(Vx) <= decceleration_speed)
	{
		Vx = 0;
		EntityPushedChangeStateBack();
	}
	else
	{
		Vx -= decceleration_speed * sign(Vx);	
	}
	EntityCollision();
}