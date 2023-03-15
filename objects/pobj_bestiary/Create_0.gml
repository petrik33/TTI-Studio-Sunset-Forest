text_font = Font(fn_bestiary);

lerp_progress = 0;
lerp_spd = 1 / (FRAME_RATE * 0.5);

alpha_progress = 0;
alpha_spd = 1 / (FRAME_RATE * 1.5);

#macro bestiary_border_w 30

//page_w = global.view_w;
//page_h = global.view_h;
page_w = ORIGINAL_VIEW_W;
page_h = ORIGINAL_VIEW_H;

x = (global.GUI_W - page_w) / 2;
y = (global.GUI_H- page_h) / 2;



