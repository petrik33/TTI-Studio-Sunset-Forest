function PlayerAttackProceed(){
	var _previous_mask = sprite_index;
	mask_index = current_attack_HB;
	var hit_list = ds_list_create();
	var hits_number = instance_place_list(x,y,pobj_hitable,hit_list,true);
	for(var i=0;i<hits_number;i++)
	{
		var _inst = hit_list[| i]
		if(ds_list_find_index(hit_by_attack,_inst)=-1)
		{
			//Hit Enemy
			//audio_play_sound_on(my_emitter,sn_enemy_hit2,0,1);
			EffectCreateOnTarget(hit_effect,_inst.image_xscale,_inst,false);
			EntityDamage(_inst,image_xscale);
			ds_list_add(hit_by_attack,_inst);
			if(variable_instance_exists(_inst,"portrait") && _inst.portrait!=noone) last_hitted = _inst;
		}
	}	
	ds_list_destroy(hit_list);
	mask_index = _previous_mask;
}