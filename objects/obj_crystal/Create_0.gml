light_instance = noone;
sprite_run = sprite_index;
sprite_idle = sprite_index;//For Cutscenes

stopped = false;
submerging = false;

//submerge_direction = 1;

sprite_dirt = spr_crystal_dirt;
dirt_width = sprite_get_width(sprite_dirt);
dirt_height = sprite_get_height(sprite_dirt);

dirt_img_id = 0;
dirt_img_num = sprite_get_number(sprite_dirt);
dirt_img_spd = sprite_get_speed(sprite_dirt) / FRAME_RATE;

dirt_alpha_spd = 1 / (FRAME_RATE * 0.25);
dirt_alpha = 1;

dirt_xoffset = sprite_get_xoffset(sprite_dirt);
dirt_yoffset = sprite_get_yoffset(sprite_dirt);

state = EntityStateNone;