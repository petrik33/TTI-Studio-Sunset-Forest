///@arg time
///@arg color
///@arg wait
function ScreenFlash(flash_time,_flash_color,_wait = 0){
	if(!global.photosensitive)
	{
		with(instance_create_layer(0,0,"Managers",obj_flash_light))
		{	
			flash_speed = 2 / flash_time;
			flash_color = _flash_color;
			flash_wait = _wait;
		}
	}
}