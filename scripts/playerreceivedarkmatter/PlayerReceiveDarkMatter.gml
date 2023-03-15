function PlayerReceiveDarkMatter(){
	if(dark_matter_bar_target_w == 0)
	{
		PlayerRevealDarkMatterBar();
	}
	dark_matter_target++;
	PlayerSoundMake(sn_dark_matter_collect8_2);
	if(dark_matter_target >= dark_matter_max)
	{
		cutscene_run(obj_CS_dark_matter_unleash);
		PlayerSoundMake(sn_unleash_dark_matter9_1);
		EffectCreateOnTarget(spr_hero_DM_explosion,image_xscale,self,false);
		dark_matter_target = 0;
		with(obj_dark_matter_particle)
		{
			instance_destroy();	
		}
	}
}