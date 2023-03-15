function PlayerSpecialFire(){
	
	var _surge_x = x + image_xscale * hero_special_fire_x_offset;
	
	SurgeSimple(
		_surge_x,
		FLOOR_Y,
		"Effects",
		spr_firewall_surge,
		obj_firewall,
		image_xscale
	)
	
	
	global.firewall_sound = sound_xy(sn_fire_special,_surge_x,FLOOR_Y);
	
	var _vfx_y = FLOOR_Y - 20;
	
	EffectCreate(_surge_x,_vfx_y ,spr_firewall_vfx,1,0);
	EffectCreate(_surge_x,_vfx_y ,spr_firewall_vfx,-1,0);
	
	with(pobj_hitable)
	{
		var _dist = x - _surge_x;
		if(abs(_dist) <= hero_special_fire_push_range)
		{
			EntityPush(self,other.pushing_speed,sign(_dist),other.pushing_direction);
			EntityDamage(self,sign(_dist),true);
		}
	}
	
}