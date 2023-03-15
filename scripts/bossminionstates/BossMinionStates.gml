///@func BossMinionStateFree
function BossMinionStateFree(){

if(instance_exists(global.oPlayer))
{
	movement_direction = sign(global.oPlayer.x - x);
	var _dist = point_distance(x,y,global.oPlayer.x,global.oPlayer.y);
	if(_dist <= explosion_distance)
	{
		sprite_index = sprite_attack;
		image_index = 0;
		
		emitter_sound(sn_minion_charge,false);
		
		PlayerWorry();
		
		state = EntityStateExploding;
		
	}
}

EntityMovement();

if(Vx != 0)
{
	InstanceRotateCentrally(sign(Vx),);
}
	
}

///@func EntityStateExploding
function EntityStateExploding(){
	if(AnimationEnd())
	{
		with(pobj_hero)
		{
			if(id!=other)
			{
				var _side = sign(x - other.x);
				var distance = point_distance(x,y,other.x,other.y);
				if(distance<=other.explosion_range)
				{
					if(distance>100) var push_spd_rate = (distance / other.explosion_range);
					else var push_spd_rate = 1;
					var push_spd = other.pushing_speed * push_spd_rate;
					EntityPush(self,push_spd,_side,other.pushing_direction)
					EntityDamage(self,_side);	
				}
			}
		}
		DyingScript();
	}
	
	
}
