event_inherited();
pushing_speed = 8;
pushing_direction = 45;

image_speed = 0;
exploded = false;
enemy_parent = pobj_hitable;
exploding = false;

function WindOrbExplode(){
	image_speed = 1;
	exploding = true;
	Vx = 0;
	Vy = 0;
	sound_xy(sn_wind_special);
}

