function AttackExecuteMelee(){
	ds_list_clear(attack_hit_list);
	if(!attack_automatic && !attack_delayed_player_worried) AttackPlayerWorry();
	attack_worry_delay = 0;
	attack_delayed_player_worried = false;
	
	var _side = attack_owner.image_xscale;
	if(!attack_automatic)
	{
		if(instance_exists(attack_target_inst))
		{
			_side = sign(attack_target_inst.x - attack_owner.x);
		}
	}
	with(attack_owner)
	{
		image_xscale = _side;	
	}
	
	if(!attack_sprite_is_vfx)
	{
		with(attack_owner)
		{
			image_index = 0;
			sprite_index = other.attack_sprite;
		}
	}
	else
	{
		attack_vfx = EffectCreateOnTarget(attack_sprite,attack_owner.image_xscale,attack_owner,false);
		attack_vfx.pause_effect = true;
	}
	with(attack_owner)
	{
		state = EntityMeleeAttack;
		emitter_sound(attack_struct.attack_sound,false);
		if(audio_is_playing(step_sound))
		{
			audio_pause_sound(step_sound);	
		}
	}
}

function AttackExecuteMeleeTargeted(){
	ds_list_clear(attack_hit_list);
	attack_worry_delay = 0;
	if(!attack_automatic)
	{
		if(!attack_delayed_player_worried)
		{
			AttackPlayerWorry();
		}
		else
		{
			attack_delayed_player_worried = false;	
		}
	}
	
	if(instance_exists(attack_target_inst))
	{
		with(attack_target_inst)
		{
			var _y_target = y + SpriteBBoxYOffsetCenter(sprite_index,true);
			var _x_target = x + SpriteBBoxOffset(sprite_index,0) * image_xscale;
		}
		var _owner_face = attack_owner.image_xscale;
		
		var _offset_circle_x = targeted_melee_offset_circle[0];
		var _offset_circle_y = targeted_melee_offset_circle[1];
		var _attack_dir = point_direction(attack_owner.x + _offset_circle_x * _owner_face,attack_owner.y + _offset_circle_y,_x_target,_y_target);
		
		//var _radian_dir = degtorad(_attack_dir);
		
		var _offset_R = targeted_melee_offset_circle[2];
		var _attack_xoffset = _offset_circle_x + lengthdir_x(_offset_R,_attack_dir) * _owner_face;
		var _attack_yoffset = _offset_circle_y + lengthdir_y(_offset_R,_attack_dir);
		
		attack_vfx = EffectCreateOnTargetOffset(attack_sprite,_owner_face,attack_owner,_attack_xoffset,_attack_yoffset,false);
		attack_vfx.pause_effect = true;
	
		with(attack_vfx)
		{
			//image_xscale = sign(cos(_radian_dir));
			if(image_xscale == -1)
			{
				image_angle = _attack_dir - 180;
			}
			else
			{
				image_angle = _attack_dir;	
			}
			if(other.attack_hit_box != sprite_index && other.attack_hit_box != noone)
			{
				mask_index = other.attack_hit_box;
			}
		}
		with(attack_owner)
		{
			state = EntityMeleeTargetedAttack;
			emitter_sound(attack_struct.attack_sound,false);
			if(audio_is_playing(step_sound))
			{
				audio_pause_sound(step_sound);	
			}
		}
	}
	else
	{
		with(attack_owner)
		{
			EntityMakeFree();
		}
	}
		
}