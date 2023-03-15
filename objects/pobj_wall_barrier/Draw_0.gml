if(barrier_activated)
{
	flash_progress += alpha_spd;
	image_alpha = sin(flash_progress);
	if(flash_progress >= pi)
	{
		barrier_activated = false;
		flash_progress = 0;
		image_alpha = 0;
	}
}
if(image_alpha > 0)
{
	draw_self();	
}
