// Inherit the parent event
event_inherited();

anim_ended = false;
shooter_id = noone;

target_hit = false;

#region//Create Light
if(light_sprite!=noone)
{
	light_instance = AttachedLightCreate(light_sprite);
	alarm[0] = 1;//Fix Values If Changed
}
else
{
	light_instance = noone;
}
#endregion
