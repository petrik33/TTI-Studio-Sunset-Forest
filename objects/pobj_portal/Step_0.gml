if(!global.game_is_paused)
{
	state();
}

#region//Waving

var _wave_y = animcurve_channel_evaluate(waving_channel,animation_progress mod 1);
y = ystart - _wave_y;
animation_progress += animation_speed;
if(animation_progress > 1) animation_progress %= 1;

#endregion

