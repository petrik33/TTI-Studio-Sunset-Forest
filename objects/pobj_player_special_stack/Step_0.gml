if(instance_exists(target))
{
	rotation_progress += spec_stacks_rot_spd;
	if(rotation_progress >= double_pi) rotation_progress -= double_pi;

	depth = depth_start + sign(sin(rotation_progress));
	
	var _cos_value = cos(rotation_progress);
	x = (target.bbox_left + target.bbox_right) / 2 + _cos_value * rotation_R;
	y = target.y + hero_special_stacks_y_offset;
	
	if(special_stack)
	{
		image_angle += angle_rotating_speed;
	}
}
else
{
	instance_destroy();	
}