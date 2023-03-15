///@arg target
///@arg value
///@arg action
///@arg delta
///@arg duration
///@arg sprite
///@arg xoffset
///@arg yoffset
///@arg sound
///@arg ui
function EntityBuff(_target,_value_name,_change_action,_delta,_duration,_sprite,_x_offset = 0,_y_offset = 0,_sound = noone,_ui = noone){
	var _current_value = variable_instance_get(_target,_value_name);
	var _new_value = _current_value;
	switch(_change_action)
	{
		case EFFECT_ACTION.PLUS:
		_new_value = _current_value + _delta;
		break;
		
		case EFFECT_ACTION.MINUS:
		_new_value = _current_value - _delta;
		break;
		
		case EFFECT_ACTION.DIVIDE:
		_new_value = _current_value / _delta;
		break;
		
		case EFFECT_ACTION.MULTIPLY:
		_new_value = _current_value * _delta;
		break;
		
		case EFFECT_ACTION.SET_FALSE:
		_new_value = false;
		break;
		
		case EFFECT_ACTION.SET_TRUE:
		_new_value = true;
		break;
		
		default:
		break;
	}
	variable_instance_set(_target,_value_name,_new_value);
	
	with(instance_create_layer(_target.x,_target.y,"Effects",pobj_buff))
	{
		target = _target;
		effect_change_action = _change_action
		total_duration = _duration * FRAME_RATE;
		value_delta = _new_value - _current_value;
		value_name = _value_name;
		if(_sprite != noone)
		{
			sprite_index = _sprite;
		}
		
		if(target == global.oPlayer && _ui != noone)
		{
			ui_id = PlayerAddBuffUI(_ui);
		}
		
		x_offset = _x_offset;
		y_offset = _y_offset;
		if(_sound != noone)
		{
			step_sound = emitter_sound(_sound,true);
		}
	}
}

#region//Particular Cases

///@arg target
function EntityMakeWet(_target){
	var _target_sprite = _target.sprite_index;
	var _x_offset = SpriteBBoxOffset(_target_sprite,0);
	var _y_offset = SpriteBBoxYOffsetCenter(_target_sprite,false);
	
	var _duration = 7;
	
	EntityBuff(
		_target,
		"entity_is_wet",
		EFFECT_ACTION.SET_TRUE,
		true,
		_duration,
		spr_wet_indicator,
		_x_offset,
		_y_offset,
		noone,
		spr_wet_ui_indicator
	)
	
	EntitySlowDown(_target,1.5,_duration);
}

///@arg inst
///@arg side
///@arg magical
function BohraDamageAndSlow(_inst,_side,_magical = false) {
	EntityDamage(_inst,_side,_magical);
	EntitySlowDown(_inst,1.5,5,spr_bohra_slow_vfx,spr_bohra_slow_ui_indicator);
}

///@arg target
///@arg side
function EntityFreeze(_target,_side){
	EntityDamage(_target,_side);
	with(_target)
	{
		if(entity_is_wet)
		{
			sprite_index = sprite_frozen;
			image_index = 0;
			
			var _freeze_time = 2;
			
			state = EntityStateFrozen;
			entity_frozen_timer = FRAME_RATE * _freeze_time;
			
			entity_is_wet = false;
			Vx = 0;
			damage_vulnerable = true;
			
			with(pobj_buff)
			{
				if(target.id == other.id && value_name = "entity_is_wet")
				{
					BuffRemove();	
				}
			}
			
			frost_ui_id = PlayerAddBuffUI(spr_frost_ui_indicator);
			var _callback = function () {
				with(global.oPlayer)
				{
					buffs_list[frost_ui_id] = -1;	
				}
			}
			frost_ui_time_source = time_source_create(time_source_game,_freeze_time,time_source_units_seconds,_callback);
			time_source_start(frost_ui_time_source);
		}
	}
}

///@arg target
///@arg delta
///@arg length
///@arg sprite
///@arg ui
function EntitySlowDown(_target,_delta,_length,_sprite = noone,_ui = noone){
	
	var _target_sprite = _target.sprite_index;
	var _x_offset = SpriteBBoxOffset(_target_sprite,0);
	var _y_offset = 0;
	if(_sprite == spr_freezing)
	{
		_y_offset = SpriteBBoxYOffsetCenter(_target_sprite,false);
	}
	
	EntityBuff(
		_target,
		"spd",
		EFFECT_ACTION.DIVIDE,
		_delta,
		_length,
		_sprite,
		_x_offset,
		_y_offset,
		sn_default_step,
		_ui
	);
		
}

#endregion