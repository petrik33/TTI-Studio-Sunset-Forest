if(submerging)
{
	if(!stopped)
	{
		var _entered_part = clamp((bbox_bottom - FLOOR_Y) / sprite_height,0,1);
		var _top = (1 - _entered_part) * dirt_height;
		var _bottom = dirt_height;
		//if(submerge_direction == 1)
		//{
		//	var _top = (1 - _entered_part) * dirt_height;
		//	var _bottom = dirt_height;
		//}
		//else
		//{
		//	var _top = dirt_height * _entered_part;
		//	var _bottom = dirt_height;
		//}
		draw_sprite_part(sprite_dirt,dirt_img_id,0,_top,dirt_width,_bottom,x - dirt_xoffset,y - dirt_yoffset * _entered_part);
	}
	else
	{
		dirt_alpha -= dirt_alpha_spd;
		if(dirt_alpha <= 0)
		{
			dirt_alpha = 0;
			submerging = false;
		}
		draw_set_alpha(dirt_alpha);
		draw_sprite(sprite_dirt,dirt_img_id,x,y);
		draw_set_alpha(1);
	}
}

draw_self();