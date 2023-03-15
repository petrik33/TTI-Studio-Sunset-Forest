event_inherited();

if(ruga_avoided_damage)
{
	ruga_shield_flash_progress += ruga_shield_alpha_spd;
	ruga_shield_alpha = sin(ruga_shield_flash_progress);
	if(ruga_shield_flash_progress >= pi)
	{
		ruga_avoided_damage = false;
		ruga_shield_alpha = 0;
		ruga_shield_flash_progress = 0;
	}
}	
if(ruga_shield_alpha != 0)
{
	draw_sprite_ext(spr_ruga_shield,0,x,y,image_xscale,image_yscale,image_angle,c_white,ruga_shield_alpha);
}