function VoaAttackWindUp(){
	with(attack_struct)
	{
		if(!instance_exists(attack_charge_effect_inst))
		{
			//Shoot
			attack_cooldown = 0;
			with(attack_owner)
			{
				var _shooter_x = x;
				var _shooter_y = y;
				var _shooting_side = image_xscale;
				EntityMakeFree();
				emitter_sound(attack_struct.attack_sound,false);
			}
				
			instance_create_layer(_shooter_x + attack_x_offset*_shooting_side,_shooter_y+attack_y_offset,"Effects",bullet_object);
		}
	}	
}