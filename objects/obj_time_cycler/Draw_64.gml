/// @description Draw Clock
if(clock_enabled)
{
	var clock_x = global.GUI_W * clock_guiX;
	var sun_visible_part = clock_sun_y-clock_circle_height/2;
	if(sun_visible_part<0)
	{
		draw_sprite_part(sprite_sun,
		0,
		0,
		0,
		clock_circle_width,
		min(abs(sun_visible_part),clock_circle_height),
		clock_x + clock_sun_x - clock_circle_xoffset,
		clock_y + clock_sun_y - clock_circle_yoffset,
		)
	}
	
	
	var moon_visible_part = clock_sun_y+clock_circle_height/2;
	
	if(moon_visible_part>0)
	{
		var _top_y = max(clock_circle_height - moon_visible_part,0);
		
		draw_sprite_part(sprite_moon,
		0,
		0,
		_top_y,
		clock_circle_width,
		min(moon_visible_part,clock_circle_height),
		clock_x + clock_sun_x - clock_circle_xoffset,
		clock_y + clock_sun_y - clock_circle_yoffset + _top_y,
		)
	}

	#region//Separating Line

	//Left Edge
	draw_sprite_ext(sprite_separater_edge,0,clock_x - clock_line_width/2,clock_y,-1,1,0,c_white,1);

	//Line
	draw_sprite_stretched(sprite_separater_line,0,clock_x - clock_line_width/2,clock_y,clock_line_width,clock_line_height)

	//Right Edge
	draw_sprite_ext(sprite_separater_edge,0,clock_x + clock_line_width/2,clock_y,1,1,0,c_white,1);


	#endregion
}








