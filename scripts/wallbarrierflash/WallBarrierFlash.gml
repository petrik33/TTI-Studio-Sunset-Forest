function WallBarrierFlash(){
	if(!barrier_activated)
	{
		barrier_activated = true;
	}
}

function WallBarrierExtinguish(){
	flash_progress = pi/2;
	barrier_activated = true;
}