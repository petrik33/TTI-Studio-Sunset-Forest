event_inherited();
filling_steps = 0;
sprite_index = sprite_edge;

key_control = noone;

//Offsets
edge_x_offset = 4;
edge_y_offset = sprite_height - 4;
var empty_space_y = 30; 

text_x_offset = sprite_width / 2;
text_y_offset = sprite_height / 2;

filling_max_y_scale = empty_space_y / sprite_get_height(sprite_filling)
