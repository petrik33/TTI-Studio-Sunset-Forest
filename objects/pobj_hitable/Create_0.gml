// Inherit the parent event
event_inherited();

#region Shader

enemy_flashing = false;
enemy_flash_time_length = FRAME_RATE * 0.55;
enemy_flash_time_left = 0;

u_pixelWidth = shader_get_uniform(sh_outline,"pixelWidth");
u_pixelHeight = shader_get_uniform(sh_outline,"pixelHeight");
//u_outline_colour = shader_get_uniform(sh_outline,"outline_colour");

texelH = outline_scale * texture_get_texel_height(sprite_get_texture(sprite_index,0));
texelW = outline_scale * texture_get_texel_width(sprite_get_texture(sprite_index,0));

outline_idle_color = c_white;
outline_damaged_color = make_color_rgb(255,0,49);
outline_color = outline_idle_color;


//attacked_outline_colour = c_white;
//attacked_timer = 0;
//flash = 0;
//flash_spd = 1 / (FRAME_RATE * 0.1);
//flash_colour = [1,1,1];

//u_flash_colour = shader_get_uniform(sh_flash,"flash_color");
#endregion
