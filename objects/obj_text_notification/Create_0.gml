text_lifetime = FRAME_RATE * 2;
var _anc_resource = animcurve_get(anc_notification_text_alpha);
anim_channel = animcurve_get_channel(_anc_resource,0);
timer = 0;

text = "";
text_color = c_white;
text_font = Font(fn_menu);

v_align = fa_middle;
h_align = fa_center;