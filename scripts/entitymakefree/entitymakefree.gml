function EntityMakeFree(){
	previous_state = state;
	state = state_free;
	EntityGoIdle();
	if(object_is_ancestor(object_index,pobj_enemy))
	{
		movement_direction = EnemyFindMovementDirection();	
	}
}

function EntityGoIdle(){
	sprite_index = sprite_idle;
	image_index = 0;
	image_speed = 1;
	if(audio_is_paused(step_sound))
	{
		audio_resume_sound(step_sound);
	}
}

///@desc returns the entity to previous state with idle sprite
function EntityEndState(){
	state = previous_state;
	EntityGoIdle();
}