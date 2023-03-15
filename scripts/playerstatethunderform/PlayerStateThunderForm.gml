function PlayerStateThunderForm(){
	if(++player_thunderform_timer>=player_thunderform_time)
	{
		PlayerLeaveThunderForm();
	}
	else
	{
		x += Vx;
		var _damaged_list = ds_list_create();
		var _damaged_number = instance_place_list(x,y,pobj_hitable,_damaged_list,false);
		for(var i = 0; i <_damaged_number; i++)
		{
			var _damaged_inst = _damaged_list[| i];
			if(ds_list_find_index(hit_by_attack,_damaged_inst)=-1)
			{
				//EntityDamage(_damaged_inst,sign(Vx),true);
				//EffectCreateOnTarget(spr_hero_thunderform_hit_effect,image_xscale,_damaged_inst,false);
				PlayerThunderHit(_damaged_inst,2);
				ds_list_add(hit_by_attack,_damaged_inst);
			}
		
		}
		ds_list_destroy(_damaged_list);
	}
}

function PlayerLeaveThunderForm(){
	sprite_index = spr_hero_special_thunder_transition;
	image_index = image_number - 1;
	image_speed = -1;
	state = PlayerSpecialThunderTransOut;
	while(place_meeting(x,y,pobj_collideable))
	{
		x+=sign(Vx);	
	}
	Vx = 0;
}