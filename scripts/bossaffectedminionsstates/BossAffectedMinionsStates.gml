function BossAffectedMinionDefaultState(){
	if(instance_exists(global.oPlayer))
	{
		var _vec = global.oPlayer.x - x;
		movement_direction = sign(_vec);
	}
	EntityMovement();
	if(Vx!=0)
	{
		InstanceRotateCentrally(sign(Vx));
		sprite_index = sprite_run;
	}
	attack_struct.attack_default_AI(attack_struct);
}

function BossIceMinionStateFree(){
	if(entity_double_attack_executed)
	{
		attack_struct = ice_minion_dash;
		entity_double_attack_executed = false;
	}
	BossAffectedMinionDefaultState();	
}

function BossMinionWindStateFree(){
	if(instance_exists(global.oPlayer))
	{
		var _player_x = global.oPlayer.x;
		var _player_y = (global.oPlayer.bbox_top + global.oPlayer.bbox_bottom) / 2;
		
		var _target_direction = point_direction(x,y,_player_x,_player_y);
		var _angle_dif = angle_difference(direction,_target_direction);
		direction -= _angle_dif * targeting_rate;
		image_angle = direction;
		
		Vx = lengthdir_x(spd,direction);
		Vy = lengthdir_y(spd,direction);
		
		var _collided_with = BossMinionWindCollision();
		if(_collided_with != noone)
		{
			EntityDamage(_collided_with,sign(Vx));
			EntityPush(_collided_with,pushing_speed,sign(Vx),pushing_direction);
			DyingScript();
		}	
	}
}

function BossMinionWindCollision(){
	if(bbox_bottom>FLOOR_Y)
	{
		//if(hit_effect != noone)
		//{
		//	//Hitting Floor
		//	with(EffectCreate(x,FLOOR_Y,hit_effect,image_xscale,false))
		//	{
		//		image_angle = other.image_angle;	
		//	}
		//}
		DyingScript();
		return noone;
	}
	var _collided_with = instance_place(x+Vx,y+Vy,enemy_parent);
	x+=Vx;
	y+=Vy;
	return _collided_with;
}