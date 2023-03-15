function PlayerAttackInDash(){
	sprite_index = spr_hero_dash_attack;
	current_attack_HB = spr_hero_dash_attack_HB;
	state = PlayerStateDashAttack;
	image_speed = attack_speed;
	ds_list_clear(hit_by_attack);
		
	AudioPlaySoundRandom(swing_sounds,MIN_PITCH_DEFT,MAX_PITCH_DEFT,MIN_GAIN_DEFT,MAX_GAIN_DEFT,false);
}