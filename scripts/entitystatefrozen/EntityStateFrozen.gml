function EntityStateFrozen(){
	Vy+=_gravity;
	EntityCollision();
	if(--entity_frozen_timer<=0)
	{
		EntityMakeFree();	
	}
}