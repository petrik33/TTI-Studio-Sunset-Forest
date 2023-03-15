if(global.game_on)
{
	if(!global.game_is_paused)
	{
		var _escape = keyboard_check_pressed(vk_escape);
		if(_escape)
		{
			PauseGame();
		}
	}
}




