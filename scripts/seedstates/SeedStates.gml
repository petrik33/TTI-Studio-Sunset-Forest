function SeedStateFalling(){
	if(y < FLOOR_Y)
	{
		Vy += _gravity;
	}
	else
	{
		if(!fallen)
		{
			Vy *= 0.1;
			Vx *= 0.1;
			fallen = true;
		}
		if(y + underground_gravity < seed_underground_y)
		{
			Vy += underground_gravity;
		}
		else
		{
			Vy = 0;
			Vx = 0;
			y = seed_underground_y;
			sprite_index = sprite_idle;
			image_index = 0;
			state = SeedStateFree;
		}
	}
	x += Vx;
	y += Vy;
	image_angle = point_direction(0,0,Vx,Vy);
}

function SeedStateFree(){
	var _x_dif = target_x - x;
	if(abs(_x_dif) <= curved_movement_distance)
	{
		direction += radtodeg(spd/curved_movement_distance) * sign(_x_dif);
	}
	else
	{
		direction = 90 - 90 * sign(_x_dif);
	}
	Vx = lengthdir_x(spd,direction);
	Vy = lengthdir_y(spd,direction);
	x += Vx;
	y += Vy;
	image_angle = direction;
	if(y <= FLOOR_Y)
	{
		EntitySurge(surging_sprite,object_to_spawn,x,FLOOR_Y,"Instances",EnemyFindMovementDirection(),sound_surge)
		instance_destroy();
	}
}

///@arg xs_array x coordinate values as an array with 2 array-entries 2 entries each
///@arg min_distance
function SeedGetRandomX(_xs_array,_min_distance){
	do
	{
		var _side = irandom(1);
		var _x_result = irandom_range(_xs_array[_side][0],_xs_array[_side][1]);
	}
	until(abs(x - _x_result) > _min_distance)
	return _x_result;
}