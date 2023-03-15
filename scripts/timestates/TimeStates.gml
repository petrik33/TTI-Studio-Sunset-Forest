function time_state_free() {
	global.time+=timer_step;
	if(global.time>1) global.time-=1;
}

function time_state_stop() {
	//Nothing
}

function clock_unhide(){
	with(global.time_cycler)
	{
		clock_enabled = true;
		clock_state = clock_state_clock_unhide;
	}
}

function clock_hide(){
	with(global.time_cycler)
	{	
		clock_state = clock_state_clock_hide;
	}
}

function clock_state_clock_unhide(){
	if(clock_y_start - clock_y > clock_movement_spd)
	{
		clock_y+=clock_movement_spd;
	}
	else
	{
		clock_y = clock_y_start;
		clock_state = clock_state_static;
	}
}

function clock_state_clock_hide(){
	if(clock_y - clock_y_full_hide > clock_movement_spd)
	{
		clock_y-=clock_movement_spd;
	}
	else
	{
		clock_y = clock_y_full_hide;
		clock_state = clock_state_static;
		clock_enabled = false;
	}
}

function clock_state_static(){	
}

function time_state_controlled(){
	if(keyboard_check_pressed(vk_f2))
	{
		time_paused = !time_paused	
	}
	if(!time_paused)
	{
		global.time+=timer_step;
		
	}
	else
	{
		var _input = keyboard_check(vk_right) - keyboard_check(vk_left);
		global.time += _input * timer_step
	}
	if(global.time>1) global.time-=1;
	if(global.time<=0) global.time +=1;
}

#region//Time Quick Transition Func

///@func time_set_transition()
///@arg target
///@arg time(frames)
function time_set_transition(_target,_time){
	with(global.time_cycler)
	{
		var _count_target = _target;
		if(_target<global.time) 
		{
			_count_target+=1;	
		}
	
		time_transition_step = (_count_target - global.time) / _time;
		time_transition_target = _target;
	
		time_state_previous = time_state;
		time_state = time_state_transition;
	}
	
}
#endregion
	
function time_state_transition(){
	global.time+=time_transition_step;
	if(global.time>1) global.time-=1;
	if(global.time=time_transition_target)
	{
		time_state = time_state_previous;
		time_transition_step = 0;
		time_transition_target = 0;
	}
}

///@arg state
function time_state_change(_state){
	
	with(global.time_cycler)
	{
		time_state = _state;	
	}
		
}