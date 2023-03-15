//function SkillInvoke() {
	
	
//	switch(invoke_counter)
//	{
//		case invoke_entity.bird_companion:
//			var invoke_y = bird_companion_flying_y;
//			var invoke_add_x = 0;
//			var invoke_cursor = spr_bird_cursor;
//			var invoke_object = obj_companion_bird;
//		break;
//		case invoke_entity.root_companion:
//			var invoke_y = FLOOR_Y;
//			var invoke_add_x = 66;
//			var invoke_cursor = spr_root_companion_cursor;
//			var invoke_object = obj_plant_companion;
//		break;
//	}
	
//	var invoke_x = x + image_xscale * invoke_add_x;
	
//	var cursor_to_right =  sprite_get_width(invoke_cursor) - sprite_get_xoffset(invoke_cursor);
//	var cursor_to_left = sprite_get_xoffset(invoke_cursor);
//	switch(image_xscale)
//	{
//		case 1:
//		invoke_x = max(invoke_x, spawn_point_left_x + cursor_to_left + 18);
//		invoke_x = min(invoke_x, spawn_point_right_x - cursor_to_right - 18);
//		break;
		
//		case -1:
//		invoke_x = max(invoke_x, spawn_point_left_x + cursor_to_right + 18);
//		invoke_x = min(invoke_x, spawn_point_right_x - cursor_to_left - 18);
//		break;
		
//	}

//	with(instance_create_layer(invoke_x,invoke_y,"Hero",invoke_object))
//	{
//		image_xscale = other.image_xscale;
//		if(object_get_parent(object_index) = pobj_companion)
//		{
//			master = other;
//			distance_to_master = x - other.x;
//			movement_direction = image_xscale;
//		}	
//	}

//	invoke_counter++;
//	if(invoke_counter = invoke_entity.last_filler) invoke_counter = 0;
//	//mask_index = previous_mask;


//}
