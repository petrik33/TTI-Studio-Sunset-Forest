event_inherited();

#region//Time Variables
time_offset = 0.75 - TIME_GAME_START;
global.time = TIME_MENU;

//timer_sign = 1;

#macro day_length  (FRAME_RATE * 60 * 4.5)
timer_step = 1 / day_length;

time_state = time_state_stop;

time_paused = false;

#region//Clock Drawing Variables

clock_state = clock_state_static;

sprite_moon = spr_clock_moon;
sprite_sun = spr_clock_sun;
sprite_separater_line = spr_clock_separater_line;
sprite_separater_edge = spr_clock_separater_edge;

clock_time = global.time + time_offset;

clock_circle_yoffset = sprite_get_yoffset(sprite_sun);
clock_circle_xoffset = sprite_get_xoffset(sprite_sun);

clock_circle_height = sprite_get_height(sprite_sun);
clock_circle_width = sprite_get_width(sprite_sun);

clock_line_height = sprite_get_height(sprite_separater_line);

clock_x_radius = 55;
clock_y_radius = 33;

clock_sun_x = cos(global.time*2*pi) * clock_x_radius;
clock_sun_y = sin(global.time*2*pi) * clock_y_radius;

clock_line_width = clock_x_radius * 2 + clock_circle_width;

clock_y_full_hide = - clock_y_radius;
clock_guiX = 0.5;
clock_y = GUI_BOUND + clock_y_radius + 8;
clock_y_start = clock_y;
clock_movement_spd = 1;

clock_enabled = false;

#endregion

#endregion

#region//Keytimes By KURE
scr_add_key_time(80,185,205,0.65,0.75,-0.18,0.35,0.19)//Midnight
scr_add_key_time(130,153,117,0.77,0.96,-0.14,0,1)//Early Morning
scr_add_key_time(133,176,138,1,1.17,0.20,-0.1,1.60)//Morning
scr_add_key_time(150,171,94,1,1.10,0.14,0,0)//Noon
scr_add_key_time(128,128,128,1,1,0,0,1)//Afternoon
scr_add_key_time(163,143,191,0.77,0.96,-0.16,0,1)//Evening
scr_add_key_time(90,150,240,0.55,1.1,-0.2,0.35,0.2);//Night

number_of_key_times = array_length(colors);
#endregion

#region//Fireflies

var _anim_curve = animcurve_get(anc_firefly_appear_chance);
fireflies_appear_chance_curve = animcurve_get_channel(_anim_curve,0);

//fireflies_min_distance = 80;
fireflies_on = true;

part_firefly = part_type_create();

part_type_color1(part_firefly,c_white);
part_type_sprite(part_firefly,spr_firefly,0,0,0);
part_type_alpha3(part_firefly,0,1,0);
part_type_life(part_firefly,FRAME_RATE * 12,FRAME_RATE * 24);
part_type_size(part_firefly,0.75,0.9,0,0);

light_layer_id = layer_get_id("Lights");

global.lights_part_system = part_system_create_layer(light_layer_id,false);
part_system_automatic_draw(global.lights_part_system,false);

fireflies_emitter = part_emitter_create(global.lights_part_system);
part_emitter_region(global.lights_part_system,fireflies_emitter,spawn_point_left_x,spawn_point_right_x,fireflies_min_y,fireflies_max_y,ps_shape_rectangle,ps_distr_linear);

#endregion

//alarm[0] = 4;


