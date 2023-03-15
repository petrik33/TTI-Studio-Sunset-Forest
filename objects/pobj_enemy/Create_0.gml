event_inherited();
//target = noone;
//attack_cooldown = 0;


if(enemy_id != noone)
{
	max_hp = global.enemies[ENEMY.MAX_HP][enemy_id];
	current_hp = max_hp;
	portrait = global.enemies[ENEMY.PORTRAIT][enemy_id];
	first_one_of_type = !global.enemies[ENEMY.BESTIARY_OPENED][enemy_id];
	bestiary_open_distance = global.GUI_W / 2.5;
	global.enemies[ENEMY.ACTIVE][enemy_id] = true;
}	
else
{
	first_one_of_type = false;
	drop_matter = false;
	//drop_chance = 100;
}

//More Entries Gives Higher Chance Of Drop
drops_list = [
	obj_drop_defense,
	obj_drop_attack_spd,obj_drop_attack_spd,
	obj_drop_movement_spd,obj_drop_movement_spd,obj_drop_movement_spd,
	obj_drop_special_fragment,obj_drop_special_fragment,obj_drop_special_fragment,obj_drop_special_fragment
];


