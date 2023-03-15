// Inherit the parent event
event_inherited();

flash_sprite = noone;
flash_particle = noone;
flash_part_direction = 0;
flash_time = 0;

var _buttons_y = y + page_h - bestiary_border_w - GUI_BOUND - sprite_get_height(spr_arrow_button)/2;

var _space_w = bestiary_border_w + GUI_BOUND + sprite_get_width(spr_arrow_button)/2;
var _left_bx = x + _space_w;
var _right_bx = x + page_w - _space_w;

var _lb_action = function(){
	with(global.bestiary)
	{
		FlashNotificationCreate(flash_sprite,-1,flash_particle,flash_part_direction,flash_time);
	}
}

var _rb_action = function(){
	with(global.bestiary)
	{
		FlashNotificationCreate(flash_sprite,1,flash_particle,flash_part_direction,flash_time);
	}
}

left_button_inst = TapButtonCreate(_left_bx,_buttons_y,HALIGN.LEFT,VALIGN.TOP,spr_arrow_button,,_lb_action,vk_left);
with(left_button_inst) image_xscale = -1;
right_button_inst = TapButtonCreate(_right_bx,_buttons_y,HALIGN.LEFT,VALIGN.TOP,spr_arrow_button,,_rb_action,vk_right);
