event_inherited();
var _restart_scene_name = "restart: ";
if(!global.restart_game)
{
	_restart_scene_name += "loaded game";	
}
else
{
	if(global.boss_fight_on)
	{
		_restart_scene_name += "boss first";
	}
	else
	{
		if(global.restart_counter <= restart_base_texts_num)
		{
			_restart_scene_name += string(global.restart_counter);
		}
		else
		{
			_restart_scene_name += "extension";	
		}
	}
}
scene_info = 
[
	[scene_wait,4],
	[scene_player_wake_up],
	[scene_wait,2],
	[scene_textbox,Text(_restart_scene_name)]
]
