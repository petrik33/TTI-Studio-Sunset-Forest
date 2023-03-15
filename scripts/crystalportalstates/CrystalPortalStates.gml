function CrystalPortalStateOpened(){
	PortalTeleporting();	
}

function CrystalPortalStateSurging(){
	if(AnimationEnd())
	{
		sprite_index = portal_opened;
		image_index = 0;
		state = CrystalPortalStateOpened;
	}
}