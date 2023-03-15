event_inherited();
if(!game_paused && AnimationEnd(6))
{
	with(player_owner)
	{
		if(pausing)
		{
			pausing = false;
			sleeping = true;
			ScreenFlash(10,c_white);
			DayNightPausedModeSwitch(2,1);
			sprite_index = sprite_pause;
			image_speed = 1;
			//Create Staff
			instance_destroy(staff_inst);
			staff_inst = instance_create_layer(x,y,"Hero",obj_staff);
			global.oMenu = instance_create_layer(0,0,"Managers",obj_pause_menu);
		}
		else
		{
			player_gui_display = true;
			ContinueGame();
			clock_unhide();
			ScreenFlash(10,c_white);
			DayNightPausedModeSwitch(0,0);
			
			BossDisplayGUI();
			
			unpausing = false;
			sleeping = false;
			
			
			y = paused_y;
			instance_destroy(staff_inst);
			with(obj_staff)
			{
				instance_destroy();	
			}
			
		}
	}
	game_paused = true;
}
