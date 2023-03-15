image_alpha = 0;

var _anim_curve_asset = anc_game_saved_alpha;
anim_channel_in = animcurve_get_channel(_anim_curve_asset,0);
anim_channel_out = animcurve_get_channel(_anim_curve_asset,1);

anim_progress = 0;
anim_spd_in = 1 / (FRAME_RATE * 0.5);
anim_spd_out = 1 / (FRAME_RATE * 2);

rotations_num = 5;
rotation_spd = 360 * rotations_num / (FRAME_RATE * 1.25);

ease_in = true;
ease_out = false;

save_text = Text("Game Saved");
text_font = Font(fn_menu);

text_xoffset = -(sprite_width / 2) - GUI_BOUND;
text_yoffset = sprite_height / 2;