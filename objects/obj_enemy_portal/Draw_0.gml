draw_self();

var _draw_x = x + portal_hp_xoffset * image_xscale;
var _draw_y = y + portal_hp_yoffset;
for(var i = 0; i < portal_hp; i++)
{
	draw_sprite_ext(portal_hp_sprite,i,_draw_x,_draw_y,image_xscale,image_yscale,image_angle,c_white,image_alpha);
}