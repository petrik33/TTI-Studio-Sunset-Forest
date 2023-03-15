/// @description Drawing Variables
event_inherited();
dummy_yoffset = -50;
y  = FLOOR_Y + dummy_yoffset;

//transformation_timer = 0;

var _default_push_spd = 3.5;
push_weight = 5/(_default_push_spd);
angle_acceleration = (2 * _default_push_spd) / (FRAME_RATE*1.5);
angle_goal = 0;
angle_speed = 0;
friction_K = (FRAME_RATE * 3);
max_angle_speed = 15;

revive = true;
dummyWalking = false;
dummy_target = noone;

//sprite_body = spr_dummy_body;
//sprite_background = spr_dummy_background;

creaking_sound = -1;
swing_sound = -1;

#region Dummy Transformation

//dummy_transform_targets = [obj_ice_trap,obj_firewall];
sprite_transform = spr_dummy_transform;
dummy_transform_check_frqncy = 3;

DummyTransformCheck();

//dummy_targets_list_clear_frqncy = FRAME_RATE * 20;

//alarm[0] = 1; //Dummy Transformation Check
//alarm[1] = dummy_targets_list_clear_frqncy;

#endregion

//background_image_index = 0;
//background_image_speed = sprite_get_speed(sprite_background) / FRAME_RATE;
//background_image_number = sprite_get_number(sprite_background) - 1;



