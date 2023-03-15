///@func AnimationSetLength
///@arg sprite
///@arg seconds
function AnimationSetLength(_sprite,_seconds){
	var frames_number = sprite_get_number(_sprite);
	var spr_spd = frames_number / (_seconds * FRAME_RATE);
	sprite_set_speed(_sprite,spr_spd,spritespeed_framespergameframe);
}