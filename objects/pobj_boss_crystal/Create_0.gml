event_inherited();
sprite_death = sprite_index;
element = -1;
waving_animation_progress = 0;
waving_animation_spd = (pi) / (FRAME_RATE);
waving_amplitude = 10;
crystal_waving = false;
rotation_spd = (360) / (FRAME_RATE * 1);
_gravity = 0.1;

flying_y = FLOOR_Y - 10 - 30;

#region Player Ultimate Activation

player_ultimate_activation_range = ORIGINAL_VIEW_W / 6;
player_ultimate_activation_check_frequency = 5;

alarm[0] = player_ultimate_activation_check_frequency;

#endregion