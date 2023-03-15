// Inherit the parent event
event_inherited();
if(lerp_progress == 1)
{
	draw_set_alpha(alpha_progress);
	
	DrawSetText(c_white,fa_middle,fa_center,text_font);
	
	draw_text_ext(text_x,text_y,bestiary_text,text_separation,text_width);
	
	draw_set_alpha(1);
}
