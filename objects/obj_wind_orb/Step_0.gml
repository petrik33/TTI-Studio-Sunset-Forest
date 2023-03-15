event_inherited();
if(!exploding)
{
	x += Vx;
	y += Vy;
	Vy +=_gravity;
	if(Vy>=0)
	{
		WindOrbExplode();
	}
}
else
{
	if(!exploded && AnimationEnd(wind_orb_explosion_frame))
	{
		with(enemy_parent)
		{
			var _y_center = (bbox_bottom + bbox_top)/2;
			var _dist = point_distance(x,_y_center,other.x,other.y);
			if(_dist <= wind_orb_explosion_range)
			{
				EntityPush(self,other.pushing_speed,sign(x - other.x),other.pushing_direction);
				EntityDamage(self,sign(x - other.x),true);
			}
		}
		EffectCreate(x,y,spr_windorb_explosion,image_xscale,false);
		exploded = true;
	}
	if(AnimationEnd())
	{
		instance_destroy();
	}
}
