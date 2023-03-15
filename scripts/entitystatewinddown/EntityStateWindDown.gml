function EntityStateWindDown(){
	EntityMovement();
	if(AnimationEnd())
	{
		EntityMakeFree();
	}
}