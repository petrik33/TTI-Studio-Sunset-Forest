event_inherited();

parent_portal = instance_nearest(x,y,obj_enemy_portal);

attack_struct = new AttackVoa(
	self,
	spr_voa_attack_charge,
	noone,
	2,
	1,
	pobj_hero,
	15,
	sn_default_attack,
	obj_voa_bullet,
	2,
	46
)

