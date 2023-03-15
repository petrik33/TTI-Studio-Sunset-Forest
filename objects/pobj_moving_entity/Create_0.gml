Vx = 0;
Vy = 0;

movement_direction = 0;

my_emitter = emitter_create();

step_sound = noone;
if(step_sound_resource!=noone)
{
	step_sound = emitter_sound(step_sound_resource,true);
}

previous_image_speed = 1;