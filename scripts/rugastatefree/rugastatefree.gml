//function RugaStateFree(){
//	EntityMovement();
//	if(Vx!=0)
//	{
//		sprite_index = sprite_run;
//		image_xscale = sign(Vx);
//	}
//	AttackUseDefaultAI(attack_struct);
//}

function RugaDamagedCheck(){
	var _damaged = noone;
	
	var _previous_mask = mask_index;
	mask_index = spr_ruga_face_HB;
	var _damaged = instance_place(x,y,pobj_hero);
	mask_index = _previous_mask;
	
	if(_damaged != noone && _damaged.Vy > 0)
	{
		damage_vulnerable = true;
		EntityDamage(self,0);
		damage_vulnerable = false;
		RugaGetDamage(true);
	}
}

///@arg jumped_on
function RugaGetDamage(_jumped_on){
	if(_jumped_on)
	{
		state = RugaStateDamaged;
		movement_direction = 0;
		sprite_index = spr_ruga_push;
		image_index = 0;
		ruga_pushed = false;
	}
	if(current_hp == 1)
	{
		stun_vulnerable = false;
		push_vulnerable = false;
		if(!_jumped_on)
		{
			RugaWeaken();	
		}
	}
}

function RugaStateDamaged(){
	EntityMovement();
	if(AnimationEnd(1) && !ruga_pushed)
	{
		var _inst_on_me = instance_place(x,y,pobj_hero);
		EntityPush(_inst_on_me,pushing_speed,image_xscale,pushing_direction);
		ruga_pushed = true;
	}
	
	if(AnimationEnd())
	{
		if(current_hp > 1)
		{
			EntityMakeFree();
			push_vulnerable = true;
		}
		else
		{
			RugaWeaken();	
		}
	}
}

function RugaWeaken(){
	movement_direction = 0;
	sprite_index = spr_ruga_weak_transition;
	image_index = 0;
	state = RugaStateWeakTransition;
	state_free = state;
	ruga_weakened = true;
	with(instance_create_layer(x,FLOOR_Y,"Effects",obj_ruga_weak_spot))
	{
		owner = other;
	}
	emitter_sound(sn_ruga_weak_reveal,false);
}

function RugaStateWeakFree(){
}

function RugaStateWeakTransition(){
	EntityMovement();
	if(AnimationEnd())
	{
		x += ruga_weak_trans_x_shift * image_xscale;
		spd /= 2;
		//sprite_death = spr_ruga_weakened_death;
		//sprite_idle = spr_ruga_weak_idle;
		//sprite_pushed = sprite_idle;
		EntityUpdateSprites(spr_ruga_weak_idle,spr_ruga_weakened_death);
		state_free = RugaStateWeakFree;
		EntityMakeFree();
	}
}

function RugaReturnToNormal(){
	x -= ruga_weak_trans_x_shift * image_xscale;
	sprite_index = spr_ruga_weak_transition;
	image_index = image_number - 1;
	image_speed = -1;
	state = RugaStateReturnTransition;
	state_free = state;
	spd *= 2;
}

function RugaStateReturnTransition(){
	if(AnimationEndReverse())
	{
		//sprite_idle = spr_ruga_idle;
		//sprite_pushed = sprite_idle;
		//sprite_death = spr_ruga_death;
		EntityUpdateSprites(spr_ruga_idle,spr_ruga_death);
		state_free = EnemyDefaultBehaviour;
		EntityMakeFree();
		push_vulnerable = true;
		current_hp++;
		ruga_weakened = false;
		stun_vulnerable = true;
	}
}







































