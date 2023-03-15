/// @description fade + transition
draw_set_alpha(alpha);
draw_set_color(c_black);

draw_rectangle(0,0,gui_w,gui_h,false);

draw_set_alpha(1);
draw_set_color(c_white);

//Transition progress
alpha += fade_speed * fade_sign;

if(alpha >= 1 )
{
	alpha = 1;
	fade_sign = -1;
	room_goto(target_room);
}

if(alpha <= 0)
{
	instance_destroy();	
}

