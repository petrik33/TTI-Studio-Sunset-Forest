draw_sprite_stretched(sprite_index,image_index,x1,global.GUI_H - GUI_BOUND - box_height,x2-x1,box_height);

DrawSetText(c_white,fa_top,fa_center,text_font);

var _print = string_copy(text,0,text_progress)
draw_text(global.GUI_W/2,global.GUI_H - box_height,_print);//Text is already separated inside Creation