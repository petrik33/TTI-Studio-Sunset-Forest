if(!flash)
{
	draw_self();
}
else
{
	shader_set(flash_shader);
	shader_set_uniform_f_array(u_flashColor,flash_color);
	flash_progress += flash_spd;
	if(flash_progress >= 1)
	{
		flash_progress = 0;
		flash = false;
	}
	draw_self();
	shader_reset();
}

#region//Draw Tower Hp
hp_image_index+=hp_image_speed;
if(hp_image_index>hp_image_number) hp_image_index = hp_image_index mod hp_image_number;
for(var i=0;i<current_hp;i++)
{
	var _xx = x + hp_relative_posistions[i][0];
	var _yy = y - hp_center_y_offset + hp_relative_posistions[i][1];
	draw_sprite(sprite_hp,hp_image_index,_xx,_yy)	
}
#endregion

#region//Draw Candle Fires

if(candles_number > 0)
{

	//Animation
	candles_animation_progress+=candles_animation_speed;
	if(candles_animation_progress >= candles_image_number)
	{
		candles_animation_progress %= candles_image_number;
	}


	for(var i = 0;i<candles_number;i++)
	{
		var _image_index = candles_animation_progress + candles_jitterings[i];
		draw_sprite(candle_sprite,
			_image_index,
			x + candles_fires_x[i],
			y + candles_fires_y[i]
		)
	}
}

#endregion
