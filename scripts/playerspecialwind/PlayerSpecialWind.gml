function PlayerSpecialWind(){
	with(instance_create_layer(x+wind_orb_x_offset*image_xscale,y+wind_orb_y_offset,"Effects",obj_wind_orb))
	{
		var _direction = 90 - ( (90 - other.orb_throw_direction) * other.image_xscale);
		var _spd = other.orb_throw_spd;
		Vx = lengthdir_x(_spd,_direction);
		Vy = lengthdir_y(_spd,_direction);
	}
}