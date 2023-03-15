function PlayerAttack(){
	if(hero_attack_counter >= array_length(hero_attack_sprites)) hero_attack_counter = 0;
	
	sprite_index = hero_attack_sprites[hero_attack_counter];
	current_attack_HB = hero_attack_HBs[hero_attack_counter];
	
	image_index = 0;
	image_speed = attack_speed;
	
	hero_bwn_attack_timer = 0;
	
	ds_list_clear(hit_by_attack);
	
	state = PlayerStateAttack;
		
	PlayerSoundMake(swing_sounds);
}