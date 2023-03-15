function EntityShieldFlash(){
	//if(entity_shielded)
	//{
	//	entity_shield_alpha_anim_progress = 0;
	//	entity_shield_alpha = 1;
	//	entity_shield_alpha_anim_spd = 1 / entity_shield_flash_anim_time;
	//	entity_shield_anim_channel = animcurve_get_channel(entity_shield_alpha_anc,"flash");
	//}
	if(entity_shielded)
	{
		entity_shield_flash = true;
		entity_shield_flash_time_progress = 0;
	}
}

///@arg time
function EntityShieldDisappear(_time){
	if(entity_shielded)
	{
		var _shield_hide = EffectCreateOnTargetOffset(entity_shield_sprite,image_xscale,self,entity_shield_xoffset,entity_shield_yoffset,true);
		with(_shield_hide)
		{
			fade_away_spd = 1 / _time;	
		}
		entity_shield_alpha = 0
		entity_shield_alpha_anim_spd = 0;
		entity_shield_alpha_anim_progress = 0;
		entity_shield_anim_channel = noone;
	}
}

function EntityShieldReveal(){
	if(entity_shielded)
	{
		entity_shield_alpha_anim_progress = 0;
		entity_shield_alpha = 0;
		entity_shield_alpha_anim_spd = 1 / entity_shield_reveal_anim_time;
		entity_shield_anim_channel = animcurve_get_channel(entity_shield_alpha_anc,"reveal");
	}
}