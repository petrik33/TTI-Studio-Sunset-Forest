waving_x_amplitude = 40;
waving_spd = global.oPlayer.pause_waving_spd;
waving_progress = 0;
depth_start = layer_get_depth(layer);

fly_to_the_hand = false;
fly_x_target = xstart + 23 * global.oPlayer.image_xscale;
fly_spd = 2;
in_the_hand = false;