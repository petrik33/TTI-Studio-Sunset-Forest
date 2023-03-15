/// @description
event_inherited();
if(attack_struct!=noone)
{
	delete attack_struct
}

if(global.last_tutorial_enemy && instance_number(pobj_enemy) == 1)
{
	cutscene_run(obj_CS_after_tutorial_wave);
	global.last_tutorial_enemy = false;
}

#region Drop Dark Matter Particle

if(drop_matter)
{
	EnemyDropDarkMatterParticle();
}

EnemyDropItem();

#endregion

