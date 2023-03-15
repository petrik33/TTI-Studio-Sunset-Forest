//if(!global.game_is_paused)
//{
var current_scene = scene_info[scene];
var current_script = current_scene[0];
var args_number = array_length(current_scene)-1
var current_scene_args = array_create(args_number);

array_copy(current_scene_args,0,current_scene,1,args_number)

scene_timer++;
skip_button = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) || mouse_check_button_pressed(mb_left);
	
script_execute_alt(current_script,current_scene_args);
current_scene_args = -1;
	
