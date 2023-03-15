event_inherited();
if(!global.game_is_paused)
{
	if(portal_spawning)
	{
		if(spawn_voa)
		{
			#region//Spawning Voas
			if(voa_counter<voa_max_count && --voa_spawn_timer<=0)
			{	
				PortalVoaSpawn();
			}
			#endregion
		}
		
		if(spawn_momma)
		{
			if(--momma_spawn_timer<=0)
			{
				PortalMommaSpawn();
			}
		}
	}	
}

