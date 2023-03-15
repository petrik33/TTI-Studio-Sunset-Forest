function PlantStateFree(){
	
	#region//Hiding
	var nearest_enemy = instance_nearest(x,y,enemy_parent);
	if(nearest_enemy = noone || abs(nearest_enemy.x - x)>hide_distance)
	{
		PlantHide();
		exit;
	}
	#endregion
	
	#region//Ranged attack
	attack_struct.attack_default_AI(attack_struct);
	#endregion
	
}

function PlantHiding(){
	if(AnimationEndReverse())
	{
		sprite_death = spr_plant_death_hidden;
		sprite_index = sprite_hidden;
		image_index = 0;
		image_speed = 1;
		state = PlantHidden;
	}
}

function PlantHidden(){
	var nearest_enemy = instance_nearest(x,y,enemy_parent);
	if(nearest_enemy != noone && abs(nearest_enemy.x - x)<=hide_distance)
	{
		PlantShowUp();
	}
	with(attack_struct)
	{
		attack_cooldown = min(++attack_cooldown,attack_cooldown_time);
	}
}

function PlantShowUp(){
	state = PlantShowingUp;
	sprite_index = sprite_surging;
	image_index = 0;	
}

function PlantHide(){
	state = PlantHiding;
	sprite_index = sprite_hiding;
	image_index = image_number - 1;
	image_speed = -1;
}

function PlantShowingUp(){
	if(AnimationEnd())
	{
		sprite_death = spr_plant_death;
		EntityMakeFree();
	}
}










