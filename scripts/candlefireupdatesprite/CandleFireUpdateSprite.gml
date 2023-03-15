///@arg sprite
function CandleFireUpdateSprite(_sprite){
	candle_sprite = _sprite;
	candles_animation_progress = 0;
	candles_animation_speed = sprite_get_speed(candle_sprite);
	if(sprite_get_speed_type(candle_sprite) == spritespeed_framespersecond)
	{
		candles_animation_speed /= FRAME_RATE;
	}
	candles_image_number = sprite_get_number(candle_sprite);

	for(var i = 1;i<candles_number;i++)
	{
		candles_jitterings[i] = random(candles_image_number);
	}
}