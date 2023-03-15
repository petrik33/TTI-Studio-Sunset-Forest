draw_self();
if(state = state_free)
{
	if(instance_exists(global.oPlayer))
	{
		DrawSetText(key_color,fa_middle,fa_center,key_font);
	
		draw_text(x,y,chr(global.oPlayer.alternative_controls[alternative_key.interaction]));
	
		draw_set_color(c_white);
		
	}
}