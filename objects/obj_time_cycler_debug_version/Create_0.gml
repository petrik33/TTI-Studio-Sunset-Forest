event_inherited();

#region//Colors + ConSatBrt

shader_values = array_create(7);

default_colors = [0.5,0.5,0.5];

default_con_sat_brt = [0.8,1,0.0,0,1];

shader_values[0] = [default_colors,default_con_sat_brt];

con_sat_brt_mix = default_con_sat_brt;
color_mix = default_colors;

#endregion

day_night_debug_cycling = false;
