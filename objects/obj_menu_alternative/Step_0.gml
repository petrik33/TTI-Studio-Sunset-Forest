event_inherited();

#region//Logo Animation
y = ystart + animcurve_channel_evaluate(logo_anim_channel,logo_anim_progress mod 1);
logo_anim_progress+=logo_anim_speed;
#endregion