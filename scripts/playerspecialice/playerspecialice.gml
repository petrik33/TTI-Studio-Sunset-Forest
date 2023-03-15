//function PlayerSpecialIce(){
//	skills[SKILLS.ICE_TRAP][SKILL.AVAILABLE] = false;
//	with(EntitySurge(
//		spr_icicle_surging,
//		obj_icicle,
//		(bbox_left + bbox_right) / 2 + image_xscale * icicle_x_offset,
//		y + icicle_y_offset,
//		"Effects",
//		image_xscale,
//		noone
//	))
//	{
//		owner = global.oPlayer;
//	}
//}
function PlayerSpecialIce(){
	state = PlayerStateIceSpecialRaise;
	sprite_index = spr_hero_special_ice_state;
	image_index = 0;
	var _left_range = x - hero_ice_special_range;
	var _right_range = x + hero_ice_special_range;
	
	ds_list_clear(ice_special_caught_list);
	SkillRangeIndicatorsDestroy();
	
	with(pobj_hitable)
	{
		var _in_range = false;
		if(bbox_right >= _left_range && bbox_right <= _right_range)
		{
			_in_range = true;
		}
		if(bbox_left <= _right_range && bbox_left >= _left_range)
		{
			_in_range = true;
		}
		if(_in_range && stun_vulnerable)
		{
			ds_list_add(other.ice_special_caught_list,self);
			EntityMakeStatic();
		}
	}
}

//function EntityStateCaught(){
//	EntityMovement();
//}


function PlayerStateIceSpecialRaise(){
	
	var _enemies_number = ds_list_size(ice_special_caught_list);
	
	if(!AnimationEnd(hero_ice_special_up_frame))
	{
		for(var i = 0; i < _enemies_number; i++)
		{
			with(ice_special_caught_list[| i])
			{
				if(object_index == obj_dummy_alternative && !dummyWalking)
				{
					var _side = sign(x - other.x);
					angle_speed = _side * 0.2;
					continue;	
				}
				if(!flying)
				{
					Vy -= (_gravity + other.ice_special_raise_acceleration);
				}
				else
				{
					var _dist = other.x - x;
					var _rangeK = clamp((abs(_dist) - 30)/100,0,1) * sign(_dist);
					Vx += (decceleration_speed + acceleration_speed) * _rangeK;
				}
			}
		}
		
	}
	
	if(AnimationEnd(hero_ice_special_down_frame))
	{
		for(var i = 0; i < _enemies_number; i++)
		{
			var _enemy = ice_special_caught_list[| i];
			if(!_enemy.flying)
			{
				_enemy.state = _enemy.state_free;
				EntityPush(_enemy,9,1,-90);
				EffectCreateOnTarget(spr_hero_ice_special_vfx,_enemy.image_xscale,_enemy,false);
				_enemy.state = EntityStatePushedByHeroSpecial;
			}
			else
			{
				_enemy.state = _enemy.state_free;
				var _side = sign(_enemy.x - x);
				EntityPush(_enemy,7,_side,0);
				EffectCreateOnTarget(spr_hero_ice_special_vfx_horizontal,-_enemy.image_xscale,_enemy,false);
				EntityStrikeWithHeroIceSpecial(_enemy);
			}
		}
		//Make Player Almost Free
		state = EntityStateWindDown;
		ds_list_clear(ice_special_caught_list);
	}
		
}

///@arg target
function EntityStrikeWithHeroIceSpecial(_target){
	
	EntityDamage(_target,0,true);
	
	EntitySlowDown(_target,1.75,8,spr_freezing);
	
	EffectCreateOnTarget(spr_hero_ice_special_hit,_target.image_xscale,_target,false);
		
}














