function EntityStateStatic(){
	EntityMovement();
}

function EntityStateNone(){
	//	
}


function BossStateStatic(){
	InstanceRotateCentrally(FacePlayer());
	EntityMovement();
	BossWaving();
}