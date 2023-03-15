if(tutorial_show_tip && --tutorial_tip_timer<=0)
{
	DrawSetText(c_white,fa_middle,fa_center,tutorial_tip_font);
	var _tip_text = tutorial_tips[tutorial_step];
	tutorial_tip_alpha = lerp(tutorial_tip_alpha,1,0.02);
	//tutorial_tip_alpha_animprogress += tutorial_tip_alpha_animspd;
	//tutorial_tip_alpha_animprogress %= (double_pi);
	draw_set_alpha(tutorial_tip_alpha);
	draw_text_ext(global.GUI_W / 2,global.GUI_H - tip_y,_tip_text,text_separation,global.GUI_W * 0.8);
	draw_set_alpha(1);
}
