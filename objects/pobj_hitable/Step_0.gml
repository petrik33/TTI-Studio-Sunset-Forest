// Inherit the parent event
event_inherited();

if(!global.game_is_paused)
{
	if(enemy_flashing)
	{
		if(enemy_flash_time_left-- <= 0)
		{
			enemy_flashing = false;
			outline_color = outline_idle_color;
		}
		else
		{
			var progress = enemy_flash_time_left / enemy_flash_time_length;
			var outline_r = lerp(color_get_red(outline_damaged_color),color_get_red(outline_idle_color),progress);
			var outline_g = lerp(color_get_green(outline_damaged_color),color_get_green(outline_idle_color),progress);
			var outline_b = lerp(color_get_blue(outline_damaged_color),color_get_blue(outline_idle_color),progress);
			outline_color = make_color_rgb(outline_r,outline_g,outline_b);
		}
	}
}
