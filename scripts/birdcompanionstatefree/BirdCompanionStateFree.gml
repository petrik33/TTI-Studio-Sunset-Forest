function BirdCompanionStateFree() {
	
	y = ystart + wave_y_range * sin(wave_anim_prog);
	wave_anim_prog += wave_anim_spd;
	if(wave_anim_prog >= double_pi) wave_anim_prog %= (double_pi);
	
	attack_struct.attack_default_AI(attack_struct);

}
