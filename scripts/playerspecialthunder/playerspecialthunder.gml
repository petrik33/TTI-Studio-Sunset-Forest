function PlayerSpecialThunder(){
	sprite_index = spr_hero_special_thunderform;
	image_index = 0;
	state = PlayerStateThunderForm;
	PlayerSpecialStacksHide();
	Vx = image_xscale * (spd + player_thunderform_spd_increase);
	with(obj_defense_barrier)
	{
		ShieldRemove();
	}
	//damage_vulnerable = false;
	//push_vulnerable = false;
	player_thunderform_timer = 0;
	ds_list_clear(hit_by_attack);
	with(pobj_wall_barrier)
	{
		if(InstanceBehindBarrier(other))
		{
			EntityPlaceOnEdge(other,-image_xscale);	
		}
	}
}