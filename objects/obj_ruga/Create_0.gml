event_inherited();

ruga_weakened = false;

attack_struct = new AttackDash(
	self,
	spr_ruga_attack,
	1,
	2,
	1,
	pobj_hero,
	175,
	sn_ruga_attack,
	spr_ruga_charge,
	0.75,
	1,
	200,
	[7,45],
	spr_ruga_hit,
	noone
);

ruga_pushed = false;

ruga_avoided_damage = false;
ruga_shield_flash_progress = 0;
ruga_shield_alpha = 0;
var _flash_time = FRAME_RATE * 0.5;
ruga_shield_alpha_spd = (pi) / (_flash_time);

