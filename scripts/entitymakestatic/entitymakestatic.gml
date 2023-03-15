function EntityMakeStatic(){
	state = EntityStateStatic;
	previous_state = state;
	EntityGoIdle();
	movement_direction = 0;
}

function BossMakeStatic(){
	state = BossStateStatic;
	previous_state = state;
	sprite_index = sprite_idle;
	image_index = 0;
	image_speed = 1;
	movement_direction = 0;
	if(audio_is_paused(step_sound))
	{
		audio_resume_sound(step_sound)	
	}
}

function BossMakeInviolable(){
	BossMakeStatic();
	damage_vulnerable = false;
	push_vulnerable = false;
	stun_vulnerable = false;
}

function BossInviolableMakeFree(){
	EntityMakeFree();
	damage_vulnerable = true;
	push_vulnerable = true;
	stun_vulnerable = true;
}	