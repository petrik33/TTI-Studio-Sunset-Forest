function CheckForPlayerFallNear(){
	if(!instance_exists(global.oPlayer))
	{
		return;	
	}
	
	var _jumped = global.oPlayer.jumped;
	
	if(_jumped == false && previous_value == true)
	{
		//Check If Near
		var _dist = abs(global.oPlayer.x - x);
		if(_dist <= activation_range)
		{
			Vy -= jump_spd;	
			push_vulnerable = true;
		}
	}
	
	previous_value = _jumped;

}

function TutorialShrineActivate(){
	with(global.tutorial_shrine)
	{
		sprite_index = spr_tutorial_shrine_activate;
		image_index = 0;
		tutorial_shrine_activate = true;
	}
}

function SetProperTraectory(){
	
	var _target_x = global.tutorial_shrine.x;
	var _target_y = FLOOR_Y - 20;
	
	var _current_direction = point_direction(0,0,Vx,Vy);
	var _current_spd = point_distance(0,0,Vx,Vy);
	
	var _proper_direction = point_direction(x,y,_target_x,_target_y);
	
	var _angle_dif = angle_difference(_proper_direction,_current_direction);
	_current_direction += _angle_dif * 0.1;
	Vx = lengthdir_x(_current_spd,_current_direction);
	Vy = lengthdir_y(_current_spd,_current_direction);
	
}


