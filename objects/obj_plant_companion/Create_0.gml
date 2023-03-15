event_inherited();

#region//Sprites
sprite_idle = spr_plant_idle;
sprite_hiding = spr_plant_surging;
sprite_hidden = spr_plant_hidden;
sprite_death = spr_plant_death;
sprite_attack = spr_plant_attack;

sprite_index = sprite_hidden;

#endregion

//Start Hidden by default
hide_distance = 555;
state = PlantHidden;

#region//Ranged Attack
attack_struct = new AttackRanged(
self,
spr_plant_attack,
0.75,
3,
1,
pobj_hitable,
333,
sn_plant_shot,
false,
sprite_get_number(spr_plant_attack)-1,
obj_plant_bullet,
noone,
43,
-41,
false,
0
);

#endregion

#region//Grow If Enemies Near
var nearest_enemy = instance_nearest(x,y,enemy_parent);
if(nearest_enemy!=noone)
{
	if(abs(nearest_enemy.x - x)<=hide_distance)
	{
		PlantShowUp();
	}
}
#endregion

