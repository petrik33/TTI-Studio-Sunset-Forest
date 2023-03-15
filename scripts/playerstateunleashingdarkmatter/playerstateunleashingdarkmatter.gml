function PlayerShootDarkMatterProjectile(){
	with(instance_create_layer(x+dark_matter_unleash_x_offset*image_xscale,y+dark_matter_unleash_y_offset,"Effects",obj_dark_matter_projectile))
	{
		image_xscale = other.image_xscale;
		light_instance.image_xscale = image_xscale;
	}
	//EffectCreateOnTarget(spr_hero_DM_explosion,image_xscale,self,false);
	with(pobj_enemy)
	{
		if(other.image_xscale != sign(x - other.x) || y <= voa_flying_y_max)
		{
			drop_matter = false;
			DyingScript();//Kill Everybody behind the back
		}
	}
}