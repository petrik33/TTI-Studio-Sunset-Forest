function PlayerWorry(){
	
	with(global.oPlayer)
	{
		if(!instance_exists(worry_effect))
		{
			worry_effect = EffectCreateOnTargetOffset(worry_sprite,image_xscale,self,0,-(view_y_offset + worry_y_offset),false);
			DynamicLightOnTarget(worry_light_sprite,worry_effect);
		}
	}

}