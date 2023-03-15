image_alpha = 0;
image_speed = 0;
image_index = 2;

var _alpha_appear_time = FRAME_RATE * 1.5; 
alpha_appear_spd = 1 / _alpha_appear_time;
appearing = true;

var _alpha_anim_time = FRAME_RATE * 2;
alpha_anim_progress = 0;
alpha_anim_spd = 1 / _alpha_anim_time;
alpha_animcurve = animcurve_get_channel(anc_bestiary_button_alpha,0);
alpha_min = 0.2;
alpha_anim_range = 1 - alpha_min;

//bestiary_enemy = 0;