function EntityPushedChangeStateBack(){
	if(previous_state != EntityStateStatic)
	{
		EntityMakeFree();
	}
	else
	{
		EntityMakeStatic();	
	}
}

function EntityStatePushed() {
	Vy += _gravity;
	if(EntityCollision())
	{
		Vx = 0;
		Vy = 0;
		
		EntityPushedChangeStateBack();
		DustEffectOnFallCreate();
		exit;
	}
	if(AnimationEnd())
	{
		image_index = image_number - 1;
		image_speed = 0;
	}
	//#region//Leave the State (Fall)
	//if(bbox_bottom >= FLOOR_Y-1)
	//{
		
	//}
	//#endregion


}

function EntityStatePushedByHeroSpecial(){
	Vy+=_gravity;
	if(EntityCollision())
	{
		Vx = 0;
		Vy = 0;
		
		EntityStrikeWithHeroIceSpecial(self);
		
		DustEffectOnFallCreate();
		
		EntityPushedChangeStateBack();
		
		exit;
	}
	if(AnimationEnd())
	{
		image_index = image_number - 1;
		image_speed = 0;
	}
	
}
