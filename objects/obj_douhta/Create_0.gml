event_inherited();
movement_direction = EnemyFindMovementDirection();
attack_struct = new AttackMelee(
	self,
	spr_douhta_attack,
	noone,
	2,
	1,
	pobj_hero,
	120,
	sn_default_attack,
	spr_douhta_attack_new_HB,
	spr_douhta_hit,
	[8,35],
	false,
	player_worry_buffer_time
);
