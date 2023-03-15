event_inherited();

#region//Colors + ConSatBrt

//color_mix = -1;
colors[0][0][0] = undefined;
colors[1][0][0] = undefined;
//key_previous = -1;
//key_next = -1;

con_sat_brt[0][0][0] = undefined;
con_sat_brt[1][0][0] = undefined;
//con_sat_brt_mix = -1;

#region//Stages

//colors[0] = color_mix;
//con_sat_brt[0] = con_sat_brt_mix;

past_color_mix = noone;
past_con_sat_brt = noone

cycle_progress = 0;
var _cycle_time = FRAME_RATE * 60;
cycle_spd = 1 / _cycle_time;
cycle_direction = 1;

scr_add_boss_stage_colors(125,240,255,1,0.85,0.16,0,1,0);//Ice
scr_add_boss_stage_colors(74,168,255,1,1.18,0.1,-1,0.37,1);

scr_add_boss_stage_colors(194,176,173,1,1,-0.04,0,1,0);//Fire
scr_add_boss_stage_colors(163,130,168,0.97,1.04,0.04,0,1,1);

scr_add_boss_stage_colors(71,219,79,1,1.36,0.04,0.18,0.03,0);//Wind
scr_add_boss_stage_colors(112,255,69,1,0.95,0.06,0,1,1);

scr_add_boss_stage_colors(178,204,232,1,0.35,-0.08,-0.38,0.22,0);//Thunder
scr_add_boss_stage_colors(186,71,255,1,0.22,0.04,0.5,0.35,1);

scr_add_boss_stage_colors(198,99,188,0.80,0.60,-0.06,-1,0.72,0);//Idle
scr_add_boss_stage_colors(216,66,255,0.80,0.36,-0.14,-1,0.72,1);

scr_add_boss_stage_colors(150,171,94,1,1.10,0.14,0,0,0);//Final Dawn
scr_add_boss_stage_colors(150,171,94,1,1.10,0.14,0,0,1);//Duplicate for constant cycle

#endregion

current_stage = 0;
stage_transition = false;
transition_stage = -1;
var _transition_time = FRAME_RATE * 8;
transition_speed = 1 / _transition_time;
transition_progress = 0;

#endregion


