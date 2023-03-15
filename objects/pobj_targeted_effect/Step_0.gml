event_inherited();
if(instance_exists(attack_target_instance))
{
	x = (attack_target_instance.bbox_left + attack_target_instance.bbox_right)/2;
	y = (attack_target_instance.bbox_bottom + attack_target_instance.bbox_top)/2;
}
