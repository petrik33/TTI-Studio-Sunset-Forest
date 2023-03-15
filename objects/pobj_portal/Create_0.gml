#region//Variables

another_portal = noone;
portal_opened = sprite_index;

#endregion

#region//Waving
var anim_curve = animcurve_get(anc_portal_waving);
waving_channel = animcurve_get_channel(anim_curve,0);
animation_progress = 0;
animation_speed = 0.01;
#endregion

state = state_opened;

image_xscale = -side;

my_emitter = audio_emitter_create();
step_sound = emitter_sound(sn_portal_idle,true);