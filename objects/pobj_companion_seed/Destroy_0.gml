//Destroy Indicator
with(current_indicator)
{
	instance_destroy();
	EffectCreateReversed(x,y,sprite_surging,image_xscale);	
}

//audio_play_sound_at(sn_comp_seed_hatch,x,y,0,falloff_ref_dist,falloff_max_dist,falloff_factor,false,1);
sound_xy(sn_comp_seed_hatch);
audio_emitter_free(my_emitter);