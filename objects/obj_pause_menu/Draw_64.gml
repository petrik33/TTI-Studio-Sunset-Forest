if(!sleeping)
{
	draw_set_alpha(image_alpha);
	event_inherited();
	draw_set_alpha(1);
}