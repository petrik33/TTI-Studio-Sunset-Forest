event_inherited();

if(lerp_progress == 1)
{
	
	draw_set_alpha(alpha_progress);

	draw_sprite(sprite_top_right,0,corner_asset_x,corner_asset_y);//corner

	draw_sprite(sprite_circle,0,circle_asset_x,circle_asset_y);//circle

	draw_sprite(sprite_enemy_portrait,0,portrait_asset_x,portrait_asset_y);//portrait

	draw_sprite(sprite_enemy_idle,enemy_idle_spr_img_prog,idle_asset_x,idle_asset_y);//idle

	DrawSetText(c_white,fa_top,fa_left,title_font);//Title
	draw_text(title_x,title_y,title_string);

	for(var i = 0; i < enemy_hp; i++)
	{
		draw_sprite(spr_enemy_hp_frag,enemy_hp_image,hp_assets_x + i * hp_assets_gap,hp_assets_y);//HP
	}

	draw_sprite(sprite_titler,0,title_asset_x,title_asset_y);//Titler

	draw_set_font(text_font);
	var _text_height = 0;
	for(var i = 0; i < ENEMY_BESTIARY_TEXT.ARRAY_LENGTH; i++)
	{
		var _text_width = text_width;
		if(i = 2) _text_width = last_text_width;
		draw_text_ext(text_x,text_y + _text_height + i * GUI_BOUND,page_text[i],text_separation,_text_width);
		_text_height += string_height_ext(page_text[i],text_separation,text_width);
	}
	
	draw_set_alpha(1);
}






