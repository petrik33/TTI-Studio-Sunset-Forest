function PlayerPush(){
	movement_direction = 0;
	sprite_index = sprite_pushing;
	image_index = 0;
	image_speed = attack_speed;
	state = PlayerStatePush;
		
	AudioPlaySoundRandom(swing_sounds,MIN_PITCH_DEFT,MAX_PITCH_DEFT,MIN_GAIN_DEFT,MAX_GAIN_DEFT,false);
		
	exit;
}