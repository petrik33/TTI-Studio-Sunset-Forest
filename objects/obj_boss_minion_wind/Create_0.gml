// Inherit the parent event
event_inherited();
drop_chance = 1;
drops_list = [obj_drop_defense,obj_drop_attack_spd,obj_drop_movement_spd];

u_pixelWidth = shader_get_uniform(sh_outline,"pixelWidth");
u_pixelHeight = shader_get_uniform(sh_outline,"pixelHeight");
//u_outline_colour = shader_get_uniform(sh_outline,"outline_colour");

texelH = outline_scale * texture_get_texel_height(sprite_get_texture(sprite_index,0));
texelW = outline_scale * texture_get_texel_width(sprite_get_texture(sprite_index,0));
