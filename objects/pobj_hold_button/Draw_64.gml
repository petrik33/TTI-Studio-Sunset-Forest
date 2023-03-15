event_inherited();

//Drawing Feeling
draw_sprite_ext(sprite_filling,0,x+edge_x_offset,y+edge_y_offset,1,filling_steps/filling_time*filling_max_y_scale,0,c_white,image_alpha)

//Drawing Text
DrawSetText(c_white,fa_middle,fa_center,text_font);

draw_set_alpha(image_alpha);

draw_text_ext(x+text_x_offset,y+text_y_offset,text,text_separation,sprite_width);

draw_set_alpha(1);
