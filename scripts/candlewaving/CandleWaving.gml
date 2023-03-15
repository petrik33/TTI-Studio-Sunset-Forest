function CandleWavingStateFree(){
	var _wave_y = animcurve_channel_evaluate(waving_channel,animation_progress) * waving_amplitude;
	y = ystart - _wave_y;
	animation_progress += animation_speed;
	if(animation_progress > 1) animation_progress %= 1;
}

function CandleWavingBlowDown(){
	waving_amplitude = FLOOR_Y - y;
	animation_progress = 0;
	animation_spd = candle_waving_blow_up_down_spd;
	waving_channel = animcurve_get_channel(anc_candle_blown_off,0);
	candle_waving_state = CandleWavingStateBlowDown;
}

function CandleWavingStateBlowDown(){
	var _wave_y = animcurve_channel_evaluate(waving_channel,animation_progress) * waving_amplitude;
	y = FLOOR_Y - _wave_y;
	animation_progress += animation_speed;
	if(animation_progress >= 1)
	{
		y = FLOOR_Y;
		animation_progress = 0;
		waving_channel = noone;
		waving_amplitude = 0;
		candle_waving_state = CandleWavingStateStatic;
	}
}

function CandleWavingReactivate(){
	waving_amplitude = FLOOR_Y - ystart;
	animation_progress = 0;
	animation_spd = candle_waving_blow_up_down_spd;
	waving_channel = animcurve_get_channel(anc_candle_reactivate,0);
	candle_waving_state = CandleWavingStateReactivate;
}

function CandleWavingStateReactivate(){
	var _wave_y = animcurve_channel_evaluate(waving_channel,animation_progress) * waving_amplitude;
	y = FLOOR_Y - _wave_y;
	animation_progress += animation_spd;
	if(animation_progress >= 1)
	{
		y = ystart;
		animation_progress = 0;
		animation_spd = candle_waving_free_anim_spd;
		waving_channel = animcurve_get_channel(anc_candle_waving,0);
		waving_amplitude = waving_free_amplitude;
		candle_waving_state = CandleWavingStateFree;
	}
}

function CandleWavingStateStatic(){
	//	
}
