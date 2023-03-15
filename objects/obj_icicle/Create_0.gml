owner = global.oPlayer;
depth_start = owner.depth;
lives_left = 3;

enemy_parent = pobj_hitable;

x_offset_to_owner = icicle_x_offset * owner.image_xscale;
y_offset_to_owner = icicle_y_offset;

rotation_cos_progress = 0;
rotation_cos_spd = (double_pi) / (FRAME_RATE * 2.5);
previous_sin_sign = 0;

sprite_idle = spr_icicle_idle;
sprite_death = spr_icicle_destruction;
faded_death = false;

my_emitter = emitter_create();
step_sound = -1;
step_sound_resource = sn_default_step;
if(step_sound_resource!=noone)
{
	step_sound = emitter_sound(step_sound_resource,true);	
}

#region//State Free

function IcicleStateFree(){
	
	#region//Damaging
	
	var _sin_sign = sign(sin(rotation_cos_progress));
	if(_sin_sign != previous_sin_sign && _sin_sign!=0)
	{
		var _inst_list = ds_list_create();
		
		var _inst_num = instance_place_list(x,y,pobj_hitable,_inst_list,false);
		if(_inst_num!=0)
		{
			for(var i = 0; i < ds_list_size(_inst_list); i++)
			{
				var _inst = _inst_list[| i];
				EntityDamage(_inst,sign(cos(rotation_cos_progress)));
				EffectCreateOnTarget(spr_icicle_hit,sign(x - owner.x),_inst,false);
			}
			lives_left--;
			if(lives_left <= 0)
			{
				layer = layer_get_id("Effects");
				DyingScript();
			}
		}
		
		ds_list_destroy(_inst_list);
	}
	
	#endregion
	
	previous_sin_sign = _sin_sign;
}

#endregion

state = noone;
state_free = IcicleStateFree;
