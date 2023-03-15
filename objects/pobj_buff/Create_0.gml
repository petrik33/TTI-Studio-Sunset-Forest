total_duration = 0;
active_time = 0;
effect_change_action = -1;
target = noone;
value_delta = 0;
value_name = "noone";
x_offset = 0;
y_offset = 0;
step_sound = noone;
my_emitter = emitter_create();
ui_id = -1;

function BuffDestroy(){
	if(ui_id != -1)
	{
		if(instance_exists(global.oPlayer))
		{
			global.oPlayer.buffs_list[ui_id] = -1;	
		}
	}
	instance_destroy();	
}

function BuffRemove(){
	#region//Reverse The Action
	var _current_value = variable_instance_get(target,value_name);
	var _new_value = _current_value;
	switch(effect_change_action)
	{	
		case EFFECT_ACTION.SET_FALSE:
		_new_value = true;
		break;
		
		case EFFECT_ACTION.SET_TRUE:
		_new_value = false;
		break;
		
		default:
		_new_value = _current_value - value_delta;
		break;
	}
	variable_instance_set(target,value_name,_new_value);
	#endregion
	BuffDestroy();
}

