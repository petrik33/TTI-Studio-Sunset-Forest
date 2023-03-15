var _width = global.GUI_W * 0.1;
var _height = global.GUI_H;

#macro flash_notification_sprite_size 64

image_xscale = sign(global.GUI_W/2 - x) * (_width / flash_notification_sprite_size);
image_yscale = _height / flash_notification_sprite_size;

flash_spd = 1;
