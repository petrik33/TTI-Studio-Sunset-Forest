image_alpha+=flash_speed;
if(image_alpha > 1)
{
	if(--flash_wait <= 0)
	{
		flash_speed*=-1;
		image_alpha = 1 + flash_speed;
	}
}

if(image_alpha < 0)
{
	instance_destroy();	
}

draw_set_alpha(image_alpha);

draw_set_color(flash_color);

draw_rectangle(0,0,global.GUI_W,global.GUI_H,false);

draw_set_color(c_white);

draw_set_alpha(1);
