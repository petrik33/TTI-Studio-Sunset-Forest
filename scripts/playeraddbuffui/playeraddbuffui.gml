///@arg sprite
function PlayerAddBuffUI(_sprite){
	if(instance_exists(global.oPlayer))
	{
		var _buff_id = -1;
		with(global.oPlayer)
		{
			for(var i = 0; i < player_max_buffs; i++)
			{
				if(buffs_list[i] == -1)
				{
					buffs_list[i] = _sprite;
					buffs_anim_list[i] = 0;
					//buffs_anim_list[i] = sprite_get_number(_ui);
					_buff_id = i;
					break;
				}
			}
		}
		return _buff_id;
	}
}

///@arg id
function PlayerRemoveBuffUI(_id)
{
	if(instance_exists(global.oPlayer) && _id != -1)
	{
		global.oPlayer.buffs_list[_id] = -1;
	}
}