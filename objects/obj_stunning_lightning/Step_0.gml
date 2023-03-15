if(!global.game_is_paused)
{
	var _exists = instance_exists(target);
	if(_exists)
	{
		x = target.x;
	}
	if(AnimationEnd())
	{
		if(_exists)
		{
			EntityDamage(target,0,true);
			var _stun_time = 1;
			if(target.object_index == obj_boss)
			{
				_stun_time /= 4;	
			}
			if(target.object_index == obj_ruga)
			{
				if(target.current_hp == 1) _stun_time = 0;
			}
			EntityStun(target,_stun_time,movement_dir_buffer);
			PlayerSpecialAddProgress(SKILLS.THUNDER);
		}
		ScreenFlash(10,c_white);
		EffectCreate(x,y,spr_thunder_strike_effect,image_xscale,false);
		instance_destroy();
	}
}
