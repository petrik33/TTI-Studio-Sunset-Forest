if(!global.game_is_paused)
{
	if(++life_timer < life_time)
	{
		
		event_inherited();
	
		WaveCollision();

		#region//Animation
		
		BulletAnimation();
		
		#endregion

		#region//Light
		
		BulletAttachedLightUpdate();
		
		#endregion
	}
	else
	{
		instance_destroy();	
	}
	return false;
}
