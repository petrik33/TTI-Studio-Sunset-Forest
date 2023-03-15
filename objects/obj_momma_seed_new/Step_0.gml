event_inherited();
if(!global.game_is_paused)
{
	Vy += _gravity;
	x += Vx;
	y += Vy;
	image_angle = point_direction(0,0,Vx,Vy);
	if(y >= FLOOR_Y)
	{
		with(EntitySurge(spr_momma_surging,obj_momma,x,FLOOR_Y,"Instances",EnemyFindMovementDirection(),sn_momma_surge))
		{
			invoking = !other.is_cs_seed;
		}
		instance_destroy();
	}
}