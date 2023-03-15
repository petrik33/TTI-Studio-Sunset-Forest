Vx = 0;
Vy = -2;//To Throw Up
_gravity = 0.1;
fallen = (FLOOR_Y - y < 1)
animation_progress = 0;
var anim_curve = animcurve_get(anc_hp_waving);
anim_channel = animcurve_get_channel(anim_curve,0);
time_passed = 0;
light_instance = instance_create_layer(x,y,"Effects",pobj_static_light);
with(light_instance)
{
	alarm[1] = 1;
	sprite_index = spr_perkdrops_light;
	image_xscale = other.image_xscale
}