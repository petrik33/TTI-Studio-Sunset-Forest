event_inherited();
if(instance_exists(light_instance)) instance_destroy(light_instance);
death_sound_play();
if(sprite_death!=noone)
{
	with(instance_create_layer(x,y,layer,pobj_effect))
	{
		sprite_index = other.sprite_death;
		image_xscale = other.image_xscale;
		image_angle = other.image_angle;
		fade_out = other.faded_death;
	}
}
//if(sprite_death!=noone)
//{
//	with(EffectCreate(x,y,sprite_death,image_xscale,false))
//	{
//		image_angle = other.image_angle;	
//	}
//}
