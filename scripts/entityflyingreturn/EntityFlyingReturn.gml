function EntityFlyingReturn(){
	Vy += acceleration_speed * sign(flying_y - y);
	Vy = clamp(Vy,-spd,spd);
	if(flying_y - y<=Vy)
	{
		y = flying_y;
		Vy = 0;
		EntityMakeFree();
		exit;
	}
	EntityMovement();
	if(Vx!=0)
	{
		InstanceRotateCentrally(sign(Vx));
	}
}