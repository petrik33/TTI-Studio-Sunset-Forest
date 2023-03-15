// Inherit the parent event
event_inherited();

attack_struct = new AttackRanged(
	self,
	spr_boss_thunder_minion_attack_charge,
	noone,
	6,
	1,
	pobj_hero,
	boss_ranged_attacks_range,
	noone,
	true,
	noone,
	obj_boss_minion_thunder_wave,
	noone,
	28,
	0,
	[true,true],
	0
)

with(attack_struct)
{
	attack_cooldown = attack_cooldown_time / 2;	
}

//state = EntityFlyingReturn;
