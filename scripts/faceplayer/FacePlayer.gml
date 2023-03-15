function FacePlayer(){
	if(instance_exists(global.oPlayer))
	{
		return(sign(global.oPlayer.x - x))
	}
	else
	{
		return 1;	
	}
}