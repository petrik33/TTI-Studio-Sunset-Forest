if(!global.game_is_paused)
{
	Vy+=_gravity;
	image_angle = point_direction(0,0,Vx*image_xscale,Vy*image_xscale);
	event_inherited();
}


