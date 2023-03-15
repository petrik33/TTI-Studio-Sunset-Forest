function MommaStateFree(){
	if(invoking && --invoke_timer <= 0)
	{
		MommaInvoke();
	}
}

function MommaInvoke(){
	sprite_index = spr_momma_invoking;
	image_index = 0;
	state = MommaStateInvoking;
	state_free = state;
	damage_vulnerable = false;
	emitter_sound(sn_momma_invoke,false);
}

function MommaStateInvoking(){
	if(AnimationEnd())
	{
		invoke_loops_left--;
		if(invoke_loops_left = 0)
		{
			with(instance_create_layer(x + image_xscale * momma_invoke_x_offset,y + momma_invoke_y_offset,"Effects",momma_spawns))
			{
				InstanceRotateCentrally(other.image_xscale);
				var _pushed_speed = other.pushing_speed;
				var _pushed_direction = 90 - (90 - other.pushing_direction) * image_xscale;
				
				Vx = lengthdir_x(_pushed_speed,_pushed_direction);
				Vy = lengthdir_y(_pushed_speed,_pushed_direction); 
			}
			sprite_death = spr_momma_retracting;
			sound_xy(sn_momma_seed_drop);
			DyingScript();
		}
	}
}