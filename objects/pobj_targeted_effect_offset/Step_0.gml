event_inherited();
if(instance_exists(attack_target_instance))
{
	x = attack_target_instance.x + x_offset * attack_target_instance.image_xscale;
	y = attack_target_instance.y + y_offset;
}