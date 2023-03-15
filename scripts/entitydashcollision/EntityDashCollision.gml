function EntityDashCollision(){
	var _collided_with = instance_place(x+Vx,y,attack_struct.attack_target);
	if(_collided_with!=noone) 
	{
		while(!place_meeting(x+sign(Vx),y,_collided_with))
		{
			x+=sign(Vx);
		}
		Vx = 0;
	}
	else
	{
		x+=Vx;	
	}
	return _collided_with;
}