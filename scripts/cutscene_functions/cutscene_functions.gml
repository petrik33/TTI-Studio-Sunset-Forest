///@arg object
///@arg start_x
///@arg distance

function scene_wait_for_movement(_object,_starting_position,_distance){
	if( abs(_object.x - _starting_position) >= _distance )
	{
		cutscene_end_scene();	
	}
}

#region Object Animate

enum OBJECT_ANIM_END_MODE{
	BACK_TO_OLD,
	BACK_TO_OLD_STATIC,
	BACK_TO_IDLE,
	STATIC,
	KEEP_CYCLING,
	SINGLE_FRAME_SCENE
}

///@arg inst
///@arg sprite
///@arg time
///@arg xscale
///@arg reverse
///@arg end_mode
function scene_object_animate(_inst,_sprite,_time = noone,_xscale = noone,_reversed = false,_end_mode = OBJECT_ANIM_END_MODE.BACK_TO_IDLE){
	if(scene_first_frame)
	{
		scene_temporary_values[| 0] = _inst.sprite_index;
		EntityCutsceneAnimate(_inst,_sprite,_reversed,_time,_xscale);
		scene_first_frame = false;
		if(_end_mode = OBJECT_ANIM_END_MODE.SINGLE_FRAME_SCENE)
		{
			cutscene_end_scene();	
		}
	}
	else
	{
		var _end_scene = false;
		with(_inst)
		{
			if(AnimationEnd())
			{
				state = EntityStateStatic;
				switch(_end_mode)
				{
				case OBJECT_ANIM_END_MODE.BACK_TO_IDLE:
					//Nothing
				break;
				
				case OBJECT_ANIM_END_MODE.BACK_TO_OLD:
					sprite_index = scene_temporary_values[| 0];
				break;
				
				case OBJECT_ANIM_END_MODE.BACK_TO_OLD_STATIC:
					sprite_index = scene_temporary_values[| 0];
					if(image_speed == -1)
					{
						image_index = 0;	
					}
					else
					{
						image_index = image_number - 1;	
					}
					image_speed = 0;
				break;
				
				case OBJECT_ANIM_END_MODE.STATIC:
					if(image_speed == -1)
					{
						image_index = 0;	
					}
					else
					{
						image_index = image_number - 1;	
					}
					image_speed = 0;
				break;
				
				case OBJECT_ANIM_END_MODE.KEEP_CYCLING:
					sprite_index = _sprite;
				break;
				
				}
				
				_end_scene = true;
			}
		}
		if(_end_scene) cutscene_end_scene();
	}
}

#endregion

function scene_boss_final_death(){
	with(global.oBoss)
	{
		BossIdleFinalDeath();	
	}
	cutscene_end_scene();	
}

function scene_boss_transition_to_final_tornado(){
	if(scene_first_frame)
	{
		with(global.oBoss)
		{
			BossTransitionToFinalTornado();
		}
		scene_first_frame = false;
	}
	else
	{
		if(global.oBoss.state == EntityStateStatic)
		{
			cutscene_end_scene();	
		}
	}
}

function scene_player_throw_wind_orb(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			var _xstart = x + wind_orb_x_offset * image_xscale;
			var _xend = global.oBoss.x - ff_boss_catch_worb_distance * image_xscale;
			var _distance = abs(_xend - _xstart);
			var _height = ff_boss_catch_worb_height + wind_orb_y_offset;
			WindOrbCountSpdHeight(_height,_distance);
			PlayerAccumulateSpecial(SKILLS.WIND);
			PlayerCastSkill(SKILLS.WIND,false);
		}
	}
	else
	{
		if(global.oPlayer.state == 	EntityStateStatic)
		{
			cutscene_end_scene();	
		}
	}
}

function scene_ff_boss_catch_wind_orb(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		scene_temporary_values[| 0] = 0; // frames counter
	}
	var _orb = instance_find(obj_wind_orb,0);
	if(_orb == noone)
	{
		cutscene_end_scene();
	}
		
	var _xtarget = global.oBoss.x - ff_boss_catch_worb_distance * global.oBoss.image_xscale;
	var _xcurrent = _orb.x;
			
	var _animtime = AnimationGetFrameLength(spr_boss_final_attack1,ff_boss_catch_worb_frame);
		
	var _orbVx = abs(_orb.Vx);
		
	var _distneeded = _animtime * _orbVx;
	var _distleft = abs(_xtarget - _xcurrent);
	
	var _delay = AnimationGetFrameLength(spr_wind_orb,wind_orb_explosion_frame-1) * 0.75;
		
	if(_distleft - _distneeded <= _orbVx)
	{
		if(++scene_temporary_values[| 0] >= _delay)
		{
			EntityCutsceneAnimate(global.oBoss,spr_boss_final_attack1);
			cutscene_end_scene();
		}
	}
}

function scene_ff_boss_destroy_worb(){
	with(global.oBoss)
	{	
		if(AnimationEnd(ff_boss_catch_worb_frame))
		{
			instance_destroy(obj_wind_orb);
			with(other)
			{
				cutscene_end_scene();	
			}
		}
	}
}

function scene_boss_awaken_final_stage(){
	if(scene_first_frame)
	{
		with(global.oBoss)
		{
			EntityMakeStatic();
			sprite_index = spr_boss_final_transition_start;
			image_index = 0;
		}
		scene_first_frame = false;
	}
	else
	{
		with(global.oBoss)
		{
			if(AnimationEnd())
			{
				if(sprite_index == spr_boss_final_transition_start)
				{
					sprite_index = spr_boss_final_transition_middle;
					image_index = 0;
					x += boss_final_transition_xoffset * image_xscale;
					y += boss_final_transition_yoffset;
				}
				else
				{
					if(sprite_index == spr_boss_final_transition_middle)
					{
						sprite_index = spr_boss_final_transition_end;
						image_index = 0;
					}
					else
					{
						if(sprite_index == spr_boss_final_transition_end)
						{
							BossTransitionToFinalStateFinish();
							with(other)
							{
								cutscene_end_scene();
							}
						}
					}
				}
			}
		}
	}
}

function scene_final(){
	global.game_final = true;
	cutscene_end_scene();
}

///@arg object
///@arg death_sprite
function scene_kill_object(_inst,_sprite){
	with(_inst) DyingScript();	
	cutscene_end_scene();
}

///@arg time
function scene_final_dawn(_time){
	forest_ambient_start(MILI_TO_SECONDS * _time);
	BossFightStageTransition(boss_idle_form_enum+1);
	with(global.time_cycler)
	{
		transition_speed = 1 / (_time * FRAME_RATE);
	}
	cutscene_end_scene();
}

///@arg inst
///@arg max
///@arg amount*
function scene_heal_instance(_inst,_max,_amount)
{
	if(!_max)
	{
		with(_inst)
		{
			current_hp = min(max_hp,current_hp + _amount);
		}
	}
	else
	{
		with(_inst) current_hp = max_hp;	
	}
	
	cutscene_end_scene();
}

function scene_boss_shader_transition(_enum){
	BossFightStageTransition(_enum);
	cutscene_end_scene();
}

///@arg scene_length
function scene_boss_fight_wall_barriers_move(_scene_len){
	_scene_len *= FRAME_RATE;
	var _scene_progress = scene_timer/_scene_len;
	with(pobj_wall_barrier)
	{
		var side = -image_xscale;
		barrier_working = false;
		var _x_start = shrine_x + crystal_lifestreams_fall_range * side;
		var _x_end = shrine_x + final_fight_edges_range * side;
		
		x = lerp(_x_start,_x_end,_scene_progress);
		image_alpha = _scene_progress;
	}
	if(_scene_progress == 1)
	{
		global.leftEdge = shrine_x - final_fight_edges_range;
		global.rightEdge = shrine_x + final_fight_edges_range;
		with(pobj_wall_barrier)
		{
			WallBarrierExtinguish();
		}
		cutscene_end_scene();	
	}
}

///@arg x
///@arg y
///@arg layer
///@arg object
///@arg sprite
///@arg image_xscale
///@arg sound
function scene_object_surge(_x,_y,_layer,_object,_sprite,_img_xscale,_sound){
	
	EntitySurge(_sprite,_object,_x,_y,_layer,_img_xscale,_sound);
	cutscene_end_scene();
	
}

///@arg portal
function scene_portal_surge_voa(_portal){
	
	with(_portal)
	{
		PortalVoaSpawn();
	}
	
	cutscene_end_scene();
		
}

///@arg portal
function scene_portal_spawn_momma(_portal){
	
	with(_portal)
	{
		with(PortalMommaSpawn())
		{
			is_cs_seed = true;	
		}
	}
	
	cutscene_end_scene();
		
}

function scene_player_deactivate_specials(){
	PlayerDeactivateAllSpecials();
	cutscene_end_scene();
}

function scene_player_heal_candles_new(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			sprite_index = spr_hero_heal_props;
			image_index = 0;
		}
		scene_temporary_values[| 0] = false;
		return;
	}
	with(global.oPlayer)
	{
		if(AnimationEnd(hero_heal_props_frame))
		{
			if(!other.scene_temporary_values[| 0])
			{
				with(obj_candle_tower)
				{
					if(blown_off)
					{
						CandleBlowUp()
					}
				}
				with(pobj_tower)
				{
					var _color = make_color_rgb(255,0,60);
					TowerFlash(FRAME_RATE * 0.4,_color);
					current_hp = max_hp;
					find_hp_relatives();
				}
				other.scene_temporary_values[| 0] = true;
			}
			if(AnimationEnd())
			{
				PlayerMakeStatic();
				with(other)
				{
					cutscene_end_scene();	
				}
			}
		}
	}
	
}

function scene_player_heal_candles(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			image_xscale = 1;
			sprite_index = 	spr_hero_send_DM_start;
			image_index = 0;
		}
	}
	else
	{
		with(global.oPlayer)
		{
			if(AnimationEnd())
			{
				switch(sprite_index)
				{
					case spr_hero_send_DM_start:
					
					sprite_index = spr_hero_send_DM_loop;
					image_index = 0;
					
					break;
					
					case spr_hero_send_DM_loop:
					
					PlayerSendDMToCandle();
					
					if(dark_matter_target <= (tutorial_wave_total_DM/2) && image_xscale != -1)
					{
						sprite_index = spr_hero_send_DM_end;
						image_index = 0;
					}
					
					if(dark_matter_target <= 0)
					{
						sprite_index = spr_hero_send_DM_end;
						image_index = 0;
					}
					
					break;
					
					case spr_hero_send_DM_end:
					
					if(dark_matter_target > 0)
					{
						InstanceRotateCentrally(-1);
						sprite_index = spr_hero_send_DM_start;
						image_index = 0;
					}
					else
					{
					
						PlayerMakeStatic();
						with(obj_shrine)
						{
							current_hp = max_hp;
							find_hp_relatives();
						}
					
						with(global.current_cutscene)
						{
							cutscene_end_scene();	
						}
					}
					
					break;
				}
			}
		}
	}
}
	
function scene_block_portals(){
	PortalsBlock();
	cutscene_end_scene();	
}

function scene_unblock_portals(){
	PortalsUnblock();
	cutscene_end_scene();		
}

///@arg cut_scene
function start_cutscene(_CS_object){
	instance_create_layer(0,0,"Managers",_CS_object);
}

function scene_game_continue(){
	ContinueGame();
	cutscene_end_scene();
}

function scene_wait_for_side_input(){
	//Some Other Object Would call cutscene_end_scene()
}

/////@arg inst
/////@arg xscale
//function scene_change_object_img_xscale(_inst,_img_xscale){
//	InstanceRotateCentrally(_img_xscale,_inst);
//	cutscene_end_scene();
//}

function scene_wait_for_DM_projectile(){
	if(!instance_exists(pobj_dark_matter_projectile))
	{
		//ContinueGame();
		cutscene_end_scene();	
	}	
}

function scene_player_shoot_dark_matter_projectile(){
	var _scene_end = false;
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			sprite_index = spr_hero_unleash_dark_matter;
			image_index = 0;
		}
	}
	else
	{
		with(global.oPlayer)
		{
			if(AnimationEnd(hero_dark_matter_unleash_frame))
			{
				PlayerShootDarkMatterProjectile();
				state = EntityStateCutsceneAnimatedEndModeBackToIdle;
				_scene_end = true;
				ContinueGame();
			}
		}
	}
	if(_scene_end) cutscene_end_scene();
}

function scene_player_after_shot(){
	var _scene_end = false;
	with(global.oPlayer){
		if(AnimationEnd())
		{
			_scene_end = true;
			PlayerMakeStatic();
		}
	}
	if(_scene_end) cutscene_end_scene();
}

///@arg target
function scene_change_camera_target(_target){
	CameraStateChange(CameraStateFollow);
	CameraChangeTarget(_target);
	cutscene_end_scene();
}

function scene_dark_matter_start(){
	if(scene_first_frame)
	{
		PlayerMakeStatic();
		scene_first_frame = false;
	}
	if(global.oPlayer.y >= FLOOR_Y - 1 && global.oPlayer.Vx == 0)
	{
		StopGame();
		var _minimal_range_to_portal = 333;
		var _to_center = shrine_x - global.oPlayer.x;
		if(room_width/2 - abs(_to_center) < _minimal_range_to_portal)
		{
			global.oPlayer.image_xscale = sign(_to_center);
		}
		with(global.oPlayer)
		{
			PlayerUnstop();
		}
		PortalsUnblock();
		cutscene_end_scene();
	}
}

function scene_dark_matter_heal_player(){
	PlayerMaxHPIncrease();
	PlayerHeal(1,hp_frag_DM_id);
	cutscene_end_scene();
}

///@arg time
///@arg color
function scene_screen_flash(_time,_color){
	ScreenFlash(_time,_color);
	cutscene_end_scene();
}

///@arg sound
///@arg pitch
///@arg gain
function scene_play_audio(_sound,_pitch_arr = [MIN_PITCH_DEFT,MAX_PITCH_DEFT],_gain_arr = [MIN_GAIN_DEFT,MAX_GAIN_DEFT]) {
	PlayerSoundMake(_sound,_pitch_arr,_gain_arr);
	cutscene_end_scene();
}

function scene_screen_flash_to_wait(_time,_color,_wait){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		ScreenFlash(_time,_color,_wait);
	}	
	if(scene_timer >= _time / 2){
		cutscene_end_scene();	
	}
}

function current_scene_proceed(){
	with(global.current_cutscene)
	{
		cutscene_end_scene();	
	}
}

///@arg condition
///@arg number
function scene_tutorial(_condition,_number){
	if(scene_first_frame)
	{
		tutorial_show_tip = true;
		tutorial_step++;
		tutorial_tip_timer = FRAME_RATE * 0.25;
		tutorial_tip_alpha = 0;
		scene_first_frame = false;
		scene_temporary_values[| 0] = 0;
	}
	else
	{
		_condition();
		if( _condition() )
		{
			if(++scene_temporary_values[| 0] >= _number)
			{
				cutscene_end_scene();
				tutorial_show_tip = false;
				ds_list_delete(scene_temporary_values,0);
			}
		}
	}
	
}

function scene_tutorial_stone(){
	if(scene_first_frame)
	{
		tutorial_show_tip = true;
		tutorial_step++;
		tutorial_tip_timer = FRAME_RATE * 5;
		tutorial_tip_alpha = 0;
		scene_first_frame = false;
	}
}

///@arg CS_object
function cutscene_run(_CS_object)
{
	if(instance_exists(global.current_cutscene))
	{
		return false;	
	}
	return (instance_create_layer(0,0,"Managers",_CS_object));
}

function scene_hide_clock(){
	clock_hide();
	cutscene_end_scene();
}

///@arg x
function scene_drop_Companion_Soul(_x){
	global.companion_alive = true;
	CompanionSoulDrop(irandom(1),_x,companion_soul_drop_y);
	cutscene_end_scene();
}

///@arg x
///@arg y
///@arg sprite
///@arg xscale
///@arg target*

function scene_create_effect(_x,_y,_sprite,_xscale,_fade_out){
	EffectCreate(_x,_y,_sprite,_xscale,false);
	cutscene_end_scene();
}

function scene_player_wake_up(){
	PlayerWakeUp();
	cutscene_end_scene();
}

///@arg object
///@arg sprite
///@arg index_update
function scene_change_object_sprite(_obj,_spr,_update_index)
{
	_obj.sprite_index = _spr;
	if(_update_index) _obj.image_index = 0;
	cutscene_end_scene();
}

///@arg instance
///@arg x
///@arg speed
function scene_move_object(_inst,_target_x,_speed){
	var _end_scene = false;
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(_inst)
		{
			sprite_index = sprite_run;
			InstanceRotateCentrally(sign(_target_x - x),);
		}
	}
	else
	{
		with(_inst)
		{
			if(abs(x - _target_x) > _speed)
			{
				x += sign(_target_x - x) * _speed;
			}
			else
			{
				x = _target_x;
				sprite_index = sprite_idle;
				var _end_scene = true;
			}
		}
	}
	if(_end_scene) cutscene_end_scene();
}

///@arg instance
///@arg xscale
function scene_object_change_xscale(_inst,_xscale){
	InstanceRotateCentrally(_xscale,_inst);
	cutscene_end_scene();
}

///@arg seconds
function scene_wait_no_skip(_time){
	if(scene_timer >= _time*FRAME_RATE)
	{
		cutscene_end_scene();	
	}	
}

///@arg state
function scene_change_camera_state(_state){
	CameraStateChange(_state);
	cutscene_end_scene();
}

///@arg key_to_input
function scene_wait_for_key_input(_key_to_input){
	if(keyboard_check_pressed(_key_to_input))
	{
		cutscene_end_scene();	
	}
}

///@arg object
///@arg state
function scene_change_object_state(_object,_state)
{
	with(_object)
	{
		state = _state;
		if(_state = EntityStateStatic)
		{
			movement_direction = 0;
		}	
	}
	cutscene_end_scene();
}

///@arg crows
///@arg time
function scene_stop_forest_ambient(_crows,_time){
	forest_ambient_stop(_crows,_time);
	cutscene_end_scene();
}

///@arg magnitude
///@arg length
function scene_camera_shake(_magnitude,_length)
{
	CameraShake(_magnitude,_length);
	cutscene_end_scene();
}

function scene_camera_stop_vibration(){
	CameraStopVibration();
	cutscene_end_scene();
}

function scene_candles_fire_extinguish(){
	with(obj_candle_tower)
	{
		EffectCreateReversed(
			x + candles_fires_x[0],
			y + candles_fires_y[0],
			spr_candle_fire_lightup,
			image_xscale
		)
		
		with(light_instance)
		{
			alarm[0] = 1;
			dying = true;
		}
		
		candles_number = 0;
	}
	cutscene_end_scene();
}

function scene_pushed_player_make_static(){
	if(scene_first_frame)
	{
		if(global.oPlayer.state == EntityStatePushed)
		{
			scene_first_frame = false;	
		}
	}
	else
	{
		if(global.oPlayer.state != EntityStatePushed)
		{
			PlayerMakeStatic();
			cutscene_end_scene();
		}
	}
}

function scene_freeup_companion_soul(){
	with(pobj_companion) DyingScript();	
	with(pobj_companion_seed)
	{
		instance_destroy();
		EffectCreateReversed(x,y,sprite_surging,image_xscale);
		CompanionSoulDrop(companion_enum,x,y);	
	}
	with(obj_companion_soul)
	{
		CompanionSoulPrepareForDeath();
	}
	cutscene_end_scene();
}

function scene_boss_wait_for_companion_soul(){
	var _scene_end = false;
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(obj_companion_soul)
		{
			CompanionSoulFlyToBoss();
		}
	}
	else
	{
		if(obj_companion_soul.state == CompanionSoulCameToBoss)
		{
			cutscene_end_scene();
			_scene_end = true;	
		}
	}
}

function scene_boss_destroy_companion_soul(){
	if(scene_first_frame)
	{
		EntityCutsceneAnimate(global.oBoss,spr_boss_kill_companion,,,);
		with(global.oBoss)
		{
			emitter_sound(sn_boss_companion_slash8_1,false);	
		}
		scene_temporary_values[| 0] = AnimationGetFrameLength(spr_boss_kill_companion,8);
		scene_first_frame = false;
	}
	else
	{
		if(scene_timer == scene_temporary_values[| 0])
		{
			with(obj_companion_soul)
			{
				sound_xy(sound_death);
				with(EffectCreate(x,y,sprites_death[current_companion],1,false))
				{
					image_angle = other.image_angle;	
				}
				instance_destroy();
			}
			global.companion_alive = false;
			cutscene_end_scene();
		}
		
	}
}

function scene_make_player_static(){
	PlayerMakeStatic();
	cutscene_end_scene();	
}

function scene_make_player_free(){
	PlayerMakeFree();
	cutscene_end_scene();	
}

function scene_tutorial_skills(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		ds_list_delete(scene_temporary_values,0);
		scene_temporary_values[| 0] = [0,0,0,0];
		tutorial_show_tip = true;
		tutorial_step++;
		tutorial_tip_timer = FRAME_RATE * 4;
	}
	else
	{
		if(global.oPlayer.skill_casted)
		{
			var _id = global.oPlayer.current_skill[SKILL.ID];
			scene_temporary_values[| 0][_id] = true;
			var _skills_casted = scene_temporary_values[| 0];
			var _all_casted = true;
			for(var i = 0; i < SKILLS.NUMBER; i++)
			{
				if(_skills_casted[i] = false) _all_casted = false;
			}
			if(_all_casted)
			{
				cutscene_end_scene();
				ds_list_delete(scene_temporary_values,0);
				tutorial_show_tip = false;
			}
		}
	}
}

function scene_next_take_live_args(){
	
	var new_scene = scene_info[scene+1];
	
	for(var i = 0;i<array_length(new_scene);i++)
	{
		if(is_method(new_scene[i]))
		{
			new_scene[@ i] = new_scene[i]();	
		}
	}
	
	cutscene_end_scene();
		
}

///@arg text
///@arg [font,sprite]
function scene_textbox(_text,_textbox_array){
	if(scene_first_frame)
	{
		scene_temporary_values[| 0] = string_length(_text);
		TextBoxCreate(_text,_textbox_array);
		scene_first_frame = false;
	}
	else
	{
		var _text_written = (global.current_text_box.text_progress >= scene_temporary_values[| 0]);
		if(skip_button && _text_written)
		{
			ds_list_delete(scene_temporary_values,0);
			cutscene_end_scene();	
		}
	}
}

///@arg part
///@arg lines number of lines in monolog part
function scene_queen_monolog(_part,_lines){
	var _stage_str = "final: queen ";
	var _between_phrases_time = FRAME_RATE * 2;
	if(scene_first_frame)
	{
		scene_first_frame = false;
		var _text = Text(_stage_str + string(_part) + ".1");
		TextBoxCreate(_text,[fn_queen,spr_textbox_queen,sn_queen_voice]);
		scene_temporary_values[| 0] = 1;//Monolog Stage
		scene_temporary_values[| 1] = string_length(_text); //Phrase Length
		scene_temporary_values[| 2] = _between_phrases_time;//Timer For Reading Phrases
		if(_part == 1)
		{
			CameraStartVibration(0.2);
		}
		return;
	}
	var _text_written = (global.current_text_box.text_progress >= scene_temporary_values[| 1]);
	if(_text_written && (skip_button || --scene_temporary_values[| 2] <= 0))
	{
		scene_temporary_values[| 0]++;
		var _stage = scene_temporary_values[| 0];
		if(_stage > _lines)
		{
			//Monolog End
			cutscene_end_scene();
			return;
		}
		//Switch To Next Phrase
		scene_temporary_values[| 2] = _between_phrases_time;
		CameraVibrationIncrease(0.25);
		var _text = Text(_stage_str + string(_part) + "." + string(_stage));
		scene_temporary_values[| 1] = string_length(_text); //Phrase Length
		TextBoxCreate(_text);
	}
	
}

function scene_start_increasing_shake(){
	CameraShake()	
}

function scene_crystal_make_object(){
		global.crystal = ShrineCrystalChangeToObject();
		cutscene_end_scene();	
}


function scene_boss_earthquake(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		global.boss_earthquake = true;
		with(global.oBoss)
		{
			BossTransitionToTornado();
			movement_direction = sign(boss_tornado_x_target - x);
		}
		with(obj_candle_tower)
		{
			death_sound = noone;
		}
		with(obj_shrine) death_sound = noone;
		//instance_destroy(obj_candle_tower);
		//cutscene_end_scene();
		CameraShake(10,30);
	}
	else
	{
		if(global.oBoss.state == EntityStateStatic)
		{
			cutscene_end_scene();
		}
	}
}

///@arg time {seconds} time of the tiredness transition in seconds
///@arg target_speed
function scene_player_tired(_time,_target_speed){
	_time *= FRAME_RATE;
	with(global.oPlayer){
		image_speed	= lerp(1,_target_speed,other.scene_timer/_time);
	}
	if(scene_timer >= _time || skip_button)
	{
		cutscene_end_scene();
	}
}

function scene_player_final_fall(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			sprite_index = spr_hero_falling;
			image_index = 0;
			image_speed = 1;
		}
	}
	else
	{
		with(global.oPlayer)
		{
			if(AnimationEnd())
			{
				sprite_index = spr_hero_tired;
				image_index = 0;
				with(other)
				{
					cutscene_end_scene();	
				}
			}
		}	
	}
}

function scene_hero_forgive(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.oPlayer)
		{
			sprite_index = spr_hero_surrender;
			image_index = 0;
			image_speed = 1;
		}
		return;
	}
	with(global.oPlayer)
	{
		if(AnimationEnd())
		{
			sprite_index = spr_hero_surrender_idle;
			image_index = 0;
			with(other)
			{
				cutscene_end_scene();	
			}
		}
	}
}

///@arg spd
function scene_final_crystal_move_horizontally_to_player(_spd){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.crystal)
		{
			submerging = true;
			stopped = false;
		}
	}
	with(global.crystal)
	{
		var _target_x = global.oPlayer.x + global.oPlayer.image_xscale * ff_crystal_to_player_xoffset;
		var _vec = _target_x - x;
		if(abs(_vec) <= _spd)
		{
			x = _target_x;
			image_xscale = -global.oPlayer.image_xscale;
			with(other)
			{
				cutscene_end_scene();
			}	
		}
		else
		{
			x += _spd * sign(_vec);	
		}
	}
}

///@arg spd
function scene_final_crystal_move_horizontally_to_boss(_spd){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(global.crystal)
		{
			submerging = true;
			dirt_alpha = 1;
			stopped = false;
		}
	}
	with(global.crystal)
	{
		var _target_x = global.oBoss.x - global.oBoss.image_xscale * ff_crystal_to_boss_xoffset;
		var _vec = _target_x - x;
		if(abs(_vec) <= _spd)
		{
			x = _target_x;
			image_xscale = global.oBoss.image_xscale;
			stopped = true;
			with(other)
			{
				cutscene_end_scene();
			}	
		}
		else
		{
			x += _spd * sign(_vec);	
		}
	}
}

///@arg time
function scene_final_crystal_raise_to_player(_time){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		scene_temporary_values[| 0] = false; //Dirt Ain't Thrown Yet
		with(global.oPlayer)
		{
			state = EntityStateNone;	
		}
	}
	var _scene_progress = scene_timer / _time;
	var _crystal_ytarget = FLOOR_Y+ff_crystal_to_player_yoffset;
	with(global.crystal)
	{
		y = lerp(CS_boss_crystal_underground_y,_crystal_ytarget,_scene_progress);
		if( bbox_top <= FLOOR_Y && !other.scene_temporary_values[| 0])
		{
			submerging = false;
			stopped = true;
			SubmergeDirtThrow(x);
			other.scene_temporary_values[| 0] = true;
		}
	}
	if(_scene_progress>=1)
	{
		global.crystal.y = _crystal_ytarget;
		cutscene_end_scene();	
	}
}

///@arg time
function scene_final_crystal_raise_to_explode(_time){
	var _scene_progress = scene_timer / _time;
	var _player_ytarget = ff_crystal_ytarget-ff_crystal_to_player_yoffset;
	with(global.crystal)
	{
		y = lerp(FLOOR_Y + ff_crystal_to_player_yoffset,ff_crystal_ytarget,_scene_progress);
	}
	with(global.oPlayer)
	{
		y = lerp(FLOOR_Y,_player_ytarget,_scene_progress);	
	}
	if(_scene_progress>=1)
	{
		global.crystal.y = ff_crystal_ytarget;
		global.oPlayer.y = _player_ytarget;
		cutscene_end_scene();	
	}
}

///@arg time
function scene_final_crystal_raise(_time){
	var _scene_progress = scene_timer / _time;
	if(scene_first_frame)
	{
		scene_first_frame = false;
		scene_temporary_values[| 0] = false; //Dirt Ain't Thrown Yet
		with(global.crystal)
		{
			submerging = true;
			stopped = false;
			dirt_alpha = 1;
		}
	}
	with(global.crystal)
	{
		y = lerp(CS_boss_crystal_underground_y,ff_crystal_ytarget,_scene_progress);
		if( bbox_top <= FLOOR_Y && !other.scene_temporary_values[| 0])
		{
			//submerging = false;
			//submerge_direction = -1;
			SubmergeDirtThrow(x);
			other.scene_temporary_values[| 0] = true;
		}
	}
	if(_scene_progress>=1)
	{
		global.crystal.y = ff_crystal_ytarget;
		cutscene_end_scene();	
	}	
}

function scene_player_standup(){
	if(scene_first_frame)
	{
		with(global.oPlayer)
		{
			if(AnimationEnd())
			{
				sprite_index = spr_hero_falling;
				image_index = image_number - 1;
				image_speed = -1;
				with(other)
				{
					scene_first_frame = false;	
				}
			}
		}
		return;
	}
	with(global.oPlayer)
	{
		if(AnimationEndReverse())
		{
			sprite_index = spr_hero_heal_props;
			image_index = 0;
			image_speed = 1;
			with(other)
			{
				cutscene_end_scene();	
			}
		}
	}
}

function scene_player_remove_specials(){
	PlayerResetAllSpecials();
	cutscene_end_scene();
}

///@arg zoom {int}
function scene_camera_zoom(zoom = 1){
	CameraZoom(zoom);
	cutscene_end_scene();
}

function scene_camera_clamp(flag = true){
	with(global.oCamera)
	{
		CameraClamp(flag);
	}
	cutscene_end_scene();
}

function scene_boss_revive(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		var _boss_side = sign(shrine_x - global.oPlayer.x);
		//if(_boss_side == 0) _boss_side = 1;
		var _boss_x = global.oCamera.x + (global.initial_viewW * 0.5 - boss_final_transition_xoffset) * _boss_side;
		with(global.oBoss)
		{
			x = _boss_x;
			image_xscale = _boss_side;
			image_speed = -1;
			image_index = image_number - 1;
		}
	}
	else
	{
		with(global.oBoss)
		{
			if(AnimationEndReverse())
			{
				EntityMakeStatic();
				with(other) cutscene_end_scene();
			}
		}
	}
}

function scene_boss_earthquake_end(){
	global.boss_earthquake = false;
	cutscene_end_scene();
}

///@arg x
///@arg range
///@arg direction
///@arg speed
function scene_push_entities_from_point(_x,_range,_direction,_speed)
{
	with(pobj_alive_entity)
	{
		var _distance = _x - x;
		if(abs(_distance)<=_range)
		{
			if(_distance = 0) _distance-=1;
			EntityPush(self,_speed,sign(_distance),_direction);
		}
	}
	cutscene_end_scene();
}

///@arg inst
///@arg sprites
function scene_animation_sequence(_inst,_sprites){
	if(scene_first_frame)
	{
		scene_temporary_values[| 0] = 0;
		scene_temporary_values[| 1] = _inst.sprite_index;
		var _id = scene_temporary_values[| 0];
		with(_inst)
		{
			sprite_index = _sprites[_id];
			image_index = 0;
		}
		scene_first_frame = false;
	}
	else
	{
		var _finish_scene = false;
		with(_inst)
		{
			if(AnimationEnd())
			{
				other.scene_temporary_values[| 0]++;
				var _id = other.scene_temporary_values[| 0];
				if(_id < array_length(_sprites))
				{
					//Set Next Sprite
					sprite_index = _sprites[_id];
					image_index = 0;
				}
				else
				{
					//End Sequence
					sprite_index = other.scene_temporary_values[| 1];//Return Old Sprite
					_finish_scene = true;
				}
			}
		}
		if(_finish_scene = true)
		{
			cutscene_end_scene();
			ds_list_delete(scene_temporary_values,0);
			ds_list_delete(scene_temporary_values,1);
		}	
	}
}

///@arg instance
///@arg sprite_index
///@arg time
function scene_animate_object(_inst,_sprite,_time=noone)
{
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(_inst)
		{
			other.scene_temporary_values[| 0] = sprite_index;
			sprite_index = _sprite;
			image_index = 0;
			if(_time!=noone)
			{
				image_speed = AnimationGetFrameLength(sprite_index) / (_time * FRAME_RATE);
			}
			
		}
	}
	else
	{
		if(_time!=noone)
		{
			var _animation_time = _time * FRAME_RATE;
		}
		else
		{
			var _animation_time = AnimationGetFrameLength(_sprite)
		}
		
		if(scene_timer = _animation_time)
		{
			with(_inst)
			{
				sprite_index = other.scene_temporary_values[| 0];
				image_speed = 1;
				image_index = 0;
			}
			cutscene_end_scene();
		}	
	}
}

///@arg instance
///@arg sprite
///@arg time*
function scene_singleframe_animate_object(_inst,_sprite,_time)
{
	with(_inst)
	{
		sprite_index = _sprite;
		image_index = 0
		image_speed = 1;
		if(_time!=noone)
		{
			image_speed = AnimationGetFrameLength(sprite_index) / (_time * FRAME_RATE);
		}
		state = EntityStateCutsceneAnimatedEndModeBackToIdle;	
	}
	cutscene_end_scene();
}

///@arg instance
///@arg sprite_index
///@arg time?
function scene_animate_object_reversed(_inst,_sprite,_time)
{
	if(scene_first_frame)
	{
		scene_first_frame = false;
		with(_inst)
		{
			other.scene_temporary_values[| 0] = sprite_index;
			sprite_index = _sprite;
			image_index = image_number - 1;
			image_speed = -1;
			if(_time!=noone)
			{
				image_speed = AnimationGetFrameLength(sprite_index) / (_time * FRAME_RATE);
			}
		}
	}
	else
	{
		if(_time!=noone)
		{
			var _animation_time = _time * FRAME_RATE;
		}
		else
		{
			var _animation_time = AnimationGetFrameLength(_sprite)
		}
		
		if(scene_timer = _animation_time)
		{
			with(_inst)
			{
				sprite_index = other.scene_temporary_values[| 0];
				image_speed = 1;
				image_index = 0;
			}
			cutscene_end_scene();
		}	
	}
}

function scene_crystal_detach(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		EntityCutsceneAnimate(global.oPlayer,spr_hero_raise_crystal,,(CS_boss_crystal_up_time + 5) / FRAME_RATE);
		ShrineCrystalDetach();
		CameraStateChange(CameraStateFollowDouble);
		CameraChangeSecondaryTarget(global.crystal);
	}
	else
	{
		with(global.crystal)
		{
			y = lerp(ystart,CS_boss_crystal_up_y,other.scene_timer / CS_boss_crystal_up_time);	
		}
	}
	if(scene_timer >= CS_boss_crystal_up_time)
	{
		with(global.oPlayer)
		{
			sprite_index = spr_hero_sever_lifestream_start;
			image_index = 0;
			image_speed = 0;
			state = EntityStateStatic;
		}
		cutscene_end_scene();
	}
}

function scene_crystal_sever_lifestream(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		//EntityCutsceneAnimate(global.crystal,spr_crystal_explode);
		CrystalDropPortalsLifestream();
		with(pobj_wall_barrier)
		{
			sprite_index = spr_wall_barrier_crystal_full;	
		}
	}
	else
	{
		//if(--scene_temporary_values[| 0] == 0)
		//{
		//	cutscene_end_scene();
		//}
		if(!instance_exists(obj_crystal_lifestream))
		{
			cutscene_end_scene();	
		}
	}
}

function scene_crystal_hide_underground(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		EntityCutsceneAnimate(global.oPlayer,spr_hero_submerge_crystal,,(CS_boss_crystal_down_time + 2) / FRAME_RATE,);
	}
	with(global.crystal)
	{
		y = lerp(CS_boss_crystal_up_y,CS_boss_crystal_underground_y,other.scene_timer / CS_boss_crystal_down_time);	
	}
	
	if(scene_timer >= CS_boss_crystal_down_time)
	{
		PlayerMakeStatic();
		with(global.crystal)
		{
			stopped = true;
		}
		cutscene_end_scene();
	}
}

function scene_player_accumulate_specials(){
	if(scene_first_frame)
	{
		scene_first_frame = false;
		scene_temporary_values[| 0] = SKILLS.ICE_TRAP;
		
		with (global.oPlayer)
		{
		    sprite_index = spr_hero_accumulating_specials;
			image_index = 0;
		}
	}
	else
	{
		var _scene_end = false;
		
		var _stacks_number = [0,0,0,0];
		with(pobj_player_special_stack)
		{
			if(special_stack) _stacks_number[skill_id] += 4;
			else _stacks_number[skill_id]++;
		}
		
		var _total_stacks = 0;
		for(var i = 0; i < SKILLS.NUMBER; i++)
		{
			_total_stacks += _stacks_number[i];	
		}
		
		with(global.oPlayer)
		{
			var _anim_progress = image_index / (image_number - 1);
			var _anim_part = 1 / 16;
			
			var _stacks_needed = round(_anim_progress / _anim_part);
			if(_total_stacks < _stacks_needed)
			{
				var _skill_with_least_stacks = SKILLS.ICE_TRAP;
				var  _least_stacks = _stacks_number[_skill_with_least_stacks];
				for(var j = 1; j < SKILLS.NUMBER; j++)
				{
					var _this_stack_number = _stacks_number[j];
					if(_this_stack_number < _least_stacks)
					{
						_least_stacks = _this_stack_number;
						_skill_with_least_stacks = j;
					}
				}
				PlayerSpecialAddProgress(_skill_with_least_stacks);
				if(_stacks_needed == (spec_stacks_needed * SKILLS.NUMBER))
				{
					_scene_end = true;
					PlayerMakeStatic();
				}
			}
		}
		if(_scene_end)
		{
			cutscene_end_scene();
			ds_list_delete(scene_temporary_values,0);	
		}
	}
}

///@arg object
function scene_delete_object(_object)
{
	instance_destroy(_object);
	cutscene_end_scene();
}

/////@arg func1
/////@arg func2
/////@arg ...
//function scene_get_live_data()
//{
//	for(var i = 0; i < argument_count; i++)
//	{
//		scene_temporary_values[| i] = argument[i]();
//	}
//	cutscene_end_scene();
//}

///@arg condition
///@arg timer_length
function scene_condition_check(_condition,_timer_length)
{
	condition_timer+=_condition();
	if(condition_timer>=_timer_length)
	{
		condition_timer = 0;
		cutscene_end_scene();	
	}
}

function scene_delete_text_box()
{
	if(instance_exists(global.current_text_box)) instance_destroy(global.current_text_box);
	cutscene_end_scene();
}

///@arg condition_1
///@arg condition_2
///@arg timer_length1
///@arg timer_length2
function scene_double_condition_check(_condition_1,_condition_2,_timer_length1,_timer_length2)
{
	condition_timer+=_condition_1();
	condition_timer2+=_condition_2();
	if(condition_timer>=_timer_length1 && condition_timer2>=_timer_length2)
	{
		condition_timer = 0;
		condition_timer2 = 0;
		cutscene_end_scene();	
	}
}

function scene_confirm_textbox()
{
	if(skip_button)
	{
		if(global.current_text_box.text_progress >= string_length(global.current_text_box.text))
		{
			cutscene_end_scene();
		}
	}
}

///@arg sound_id
function scene_stop_sound(_sound_id)
{
	audio_stop_sound(_sound_id);
	cutscene_end_scene();	
}

function scene_stop_silent_sound(_sound_id)
{
	if(skip_button)
	{
		audio_sound_gain(_sound_id,0,0);	
	}
	
	if(audio_sound_get_gain(_sound_id) = 0)
	{
		audio_stop_sound(_sound_id);
		cutscene_end_scene();
	}
		
}

