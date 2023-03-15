// Inherit the parent event
event_inherited();

state = EntityFlyingReturn;

entity_double_attack_executed = false;

var ice_minion_melee = new AttackMelee(
	self,
	spr_boss_ice_minion_dash_finish,
	noone,
	boss_melee_time,
	1,
	pobj_hero,
	30,
	noone,
	spr_boss_ice_minion_dash_finishHB,
	spr_boss_ice_projectile_hit,
	[pushing_speed,pushing_direction],
	false,
	0
)

attack_struct = new AttackDashToMelee(
	self,
	spr_boss_ice_minion_dash,
	noone,
	boss_melee_time * 1.5,
	1,
	pobj_hero,
	150,
	noone,
	spr_boss_ice_minion_charge,
	noone,
	1,
	180,
	ice_minion_melee,
	noone
)

ice_minion_dash = attack_struct;

with(attack_struct)
{
	attack_cooldown = attack_cooldown_time;	
}
