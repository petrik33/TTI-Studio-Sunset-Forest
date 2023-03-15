//if(!global.game_is_paused)
//{
//	//var _sin_sign = sign(sin(rotation_cos_progress));
//	#region//Motion
//	if(instance_exists(owner))
//	{
//		var _cos_value = cos(rotation_cos_progress)
//		x = (owner.bbox_left + owner.bbox_right) / 2 + _cos_value * x_offset_to_owner;
//		y = owner.y + y_offset_to_owner;
//		depth = depth_start + previous_sin_sign;
//		rotation_cos_progress += rotation_cos_spd;
//		if(rotation_cos_progress > double_pi)
//		{
//			rotation_cos_progress %= (double_pi);
//		}
//	}
//	else
//	{
//		layer = layer_get_id("Effects");
//		DyingScript();
//		exit;
//	}
//	#endregion
//	state();	
//}