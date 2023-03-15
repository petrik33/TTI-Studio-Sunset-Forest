function PlayerAttackInAir(){
	sprite_index = spr_hero_jump_attack
	current_attack_HB = spr_hero_jump_attackHB;
	image_index = 0;
	image_speed = attack_speed;
	state = PlayerStateAttackInAir;
	ds_list_clear(hit_by_attack);
		
	AudioPlaySoundRandom(swing_sounds,MIN_PITCH_DEFT,MAX_PITCH_DEFT,MIN_GAIN_DEFT,MAX_GAIN_DEFT,false);
}