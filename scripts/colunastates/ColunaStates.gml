function ColunaStateFree(){
	if(!raged)
	{
		EntityMovement();
	}
	else
	{
		#region//Coluna Circled Movement
		
		var _Vy_acceleration = sqr(coluna_raged_wave_anim_spd) * (flying_y - y - coluna_raged_wave_range/2);
		Vy +=_Vy_acceleration;
		EntityMovement();
		
		#endregion
		
		ColunaRageAttackProceed();	
	}
}

function ColunaRageTransition(){
	if(!raged && AnimationEnd(5))
	{
		raged = true;
		with(pobj_hero)
		{
			var _dist = x - other.x;
			if(abs(_dist) <= 80)
			{
				EntityPush(self,other.pushing_speed,sign(_dist),other.pushing_direction);	
			}
		}
	}
	else
	{
		if(AnimationEnd())
		{
			sprite_index = spr_coluna_activated_idle;
			image_index = 0;
			sprite_idle = sprite_index;
			spd *= 1.5;
			push_vulnerable = true;
			damage_vulnerable = true;
			state_free = ColunaStateFree;
			state = state_free;
			hit_sound = noone;
		}
	}
}

function ColunaDamagedCheck(){
	if(current_hp != previous_hp)
	{
		current_hp++;
		coluna_defs_left--;
		var _x = x + lengthdir_x(coluna_defs_circle_R,coluna_defs_spin_prog + 90 * coluna_defs_left);
		var _y = y + lengthdir_y(coluna_defs_circle_R,coluna_defs_spin_prog + 90 * coluna_defs_left);
		EffectCreate(_x,_y,spr_coluna_defense_death,image_xscale,false);
		if(coluna_defs_left = 0)
		{
			ColunaEnrage();
		}
	}
	previous_hp = current_hp;
}

function ColunaEnrage(){
	if(state == state_free)
	{
		sprite_index = spr_coluna_rage_transition;
		image_index = 0;
		sprite_idle = sprite_index;
		state_free = ColunaRageTransition;
		state = state_free;
		push_vulnerable = false;
		damage_vulnerable = false;
		emitter_sound(sn_coluna_transition,false);
	}
	else
	{
		alarm[0] = 3;	
	}
}

function ColunaRageAttackProceed(){
	var _inst_hit = instance_place(x,y,enemy_parent)
	if(_inst_hit != noone && _inst_hit.state!=EntityStatePushed)
	{
		EntityDamage(_inst_hit,sign(Vx));
		EffectCreateOnTarget(spr_ruga_hit,image_xscale,_inst_hit,false);
		EntityPush(_inst_hit,pushing_speed,sign(_inst_hit.x - x), pushing_direction);
	}
}












