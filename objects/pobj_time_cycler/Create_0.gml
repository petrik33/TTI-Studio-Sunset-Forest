#region//Shader Stuff
shader = sh_day_night_cycle_V1_1;

u_col = shader_get_uniform(shader,"col");
u_con_sat_brt = shader_get_uniform(shader,"con_sat_brt");

s_lights = shader_get_sampler_index(shader,"lights");
tex_lights = -1;
srf_lights = -1;

#endregion

#region//Colors + ConSatBrt
color_mix = [0,0,0];
colors[0,0] = undefined;
key_previous = -1;
key_next = -1;

con_sat_brt[0,0] = undefined;
con_sat_brt = con_sat_brt;
con_sat_brt_mix = [1,1,0,0,1];


#endregion

#region//Application Surface Stuff
//app_surface_x_offset = global.GUI_XOFFSET;
//app_surface_y_offset = global.GUI_YOFFSET;
//GUI_SCALE = global.GUI_SCALE;

//view_w = camera_get_view_width(view_camera[0]);
//view_h = camera_get_view_height(view_camera[0]);

#endregion

//alarm[0] = 4;


