if(fading_out)
{
	image_alpha -= fade_out_spd;
	if(image_alpha <= 0)
	{
		instance_destroy();
	}	
}
else
{
	//image_alpha = lerp(image_alpha,1,0.05);
	if(instance_exists(attack_target_inst))
	{
		x = attack_target_inst.x;
		y = attack_target_inst.y;
		image_angle = attack_target_inst.image_angle;
		//y = max(min_y, y);
		//if(bbox_top < FLOOR_Y)
		//{
		//	var _dif = y - bbox_top;
		//	y = FLOOR_Y + _dif;
		//}
	}
	else
	{
		image_speed = 0;
		fading_out = true;
	}
}