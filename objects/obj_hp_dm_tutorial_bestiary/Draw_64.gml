// Inherit the parent event
event_inherited();

if(lerp_progress == 1)
{
	draw_set_alpha(alpha_progress);
	
	#region HP
	
	for(var i = 0; i < HP_assets_num; i++)
	{
		var _draw_x = HP_assets_x + HP_asset_xoffset + (HP_assets_gap + HP_asset_width) * i;
		draw_sprite(spr_hp_fragment_alternative,i,_draw_x,HP_assets_y);
	}
	
	DrawSetText(c_white,fa_top,fa_center,text_font);
	
	draw_text_ext(HP_text_x,HP_text_y,HP_text,text_separation,column_width);
	
	#endregion
	
	#region Dark Matter
	
	draw_sprite_stretched(spr_dark_matter_bar,0,DM_bar_x,DM_bar_y,DM_bar_width,DM_bar_height);
	
	for(var i = 0; i < DM_assets_num; i++)
	{
		var _draw_x = DM_assets_x + DM_asset_xoffset + (DM_assets_gap + DM_asset_width) * i;
		draw_sprite(spr_dark_matter_particle,i,_draw_x,DM_assets_y);	
	}
	
	draw_text_ext(DM_text_x,DM_text_y,DM_text,text_separation,column_width);
	
	#endregion
	
	draw_set_alpha(1);
}