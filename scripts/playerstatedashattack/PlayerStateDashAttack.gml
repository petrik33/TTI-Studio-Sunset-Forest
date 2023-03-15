function PlayerStateDashAttack(){
	EntityCollision();
	Vy += _gravity;
	Vx -= dash_decceleration[dash_type] * sign(Vx);
	if(abs(Vx) <= dash_decceleration[dash_type])
	{
		EntityMakeFree();
		exit;
	}
	
	PlayerGatherBufferInput();
	
	if(AnimationEnd())
	{
		EntityMakeFree();
	}
	
	PlayerAttackProceed();
}