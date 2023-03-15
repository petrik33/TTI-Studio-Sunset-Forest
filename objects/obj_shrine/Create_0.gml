event_inherited();

state = EntityStateStatic;

#region//Crystal

crystal_on_shrine = true;

crystal_x = x;

crystal_y_start = y - hp_center_y_offset;
crystal_y = crystal_y_start

crystal_sprite_idle = spr_diamond
crystal_sprite_damaged = spr_diamond_damaged;
crystal_sprite = crystal_sprite_idle;

crystal_light = LightCreate(x,y,spr_crystal_light);

var anim_curve = animcurve_get(anc_candle_waving);
waving_channel = animcurve_get_channel(anim_curve,0);
animation_progress = 0;

crystal_image_index = 0;
var crystal_damaged_frames = sprite_get_number(crystal_sprite_damaged)
crystal_damaged_image_speed = sprite_get_speed(sprite_damaged) / sprite_get_number(sprite_damaged) * crystal_damaged_frames / FRAME_RATE;

var anim_curve = animcurve_get(anc_crystal_damaged);
damaged_channel = animcurve_get_channel(anim_curve,0);
damaged_animation_progress = 0;
damaged_animation_speed = 1 / crystal_damaged_frames * crystal_damaged_image_speed;

#endregion

var _collapse_time = FRAME_RATE * 15;
var _collapse_dist = sprite_height;
collapse_spd = _collapse_dist / _collapse_time;
collapsing = false;
