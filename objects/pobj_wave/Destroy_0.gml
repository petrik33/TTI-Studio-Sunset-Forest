// Inherit the parent event
event_inherited();
if(sprite_death == noone)
{
	var _effect = EffectCreate(x,y,sprite_index,image_xscale,faded_death);	
	with(_effect)
	{
		image_index = other.image_index;
		image_speed = 0;
		image_angle = other.image_angle;
		fading_out = true;
	}
}
ds_list_destroy(hit_by_attack);
