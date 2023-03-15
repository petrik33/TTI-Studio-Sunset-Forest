if(!global.game_is_paused)
{
	Vy+=_gravity;
	y += Vy;
	x += Vx;

	if(y >= FLOOR_Y)
	{
		instance_destroy();
		EntitySurge(spr_douhta_surging,obj_douhta,x,FLOOR_Y,"Instances",image_xscale,noone)
	}
}
