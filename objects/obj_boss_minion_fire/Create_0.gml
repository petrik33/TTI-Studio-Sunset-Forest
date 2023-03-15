// Inherit the parent event
event_inherited();

attack_struct = new AttackRanged(
	self,
	spr_boss_fire_minion_attack_charge,
	noone,
	6,
	1,
	pobj_hero,
	boss_ranged_attacks_range,
	noone,
	false,
	noone,
	obj_boss_minion_fire_projectile,
	noone,
	33,
	0,
	[true,false],
	0
)

with(attack_struct)
{
	attack_cooldown = attack_cooldown_time / 2;	
}

//Debug
//y = FLOOR_Y;//For Accuracy
