///@arg hp
///@arg frag_id
function PlayerHeal(_hp_num,_frag_id){
	var _player = global.oPlayer;
	if(instance_exists(_player))
	{
		var _heal_num = min(_hp_num,_player.max_hp - _player.current_hp);
		if(_heal_num < 0)
		{
			return false;
		}
		for(var i = 0; i < _heal_num; i++)
		{
			with(_player)
			{
				var _frag_color_idx = _frag_id;
				if(_frag_color_idx == noone)
				{
					_frag_color_idx = irandom(hp_frag_DM_id - 1);	
				}
				for(var j = current_hp;j>0;j--)
				{
					hp_leaves[@ j]	= hp_leaves[j-1];
				}
				hp_leaves[@ 0] = _frag_color_idx;
				current_hp++;
			}
		}
	}
}

function PlayerMaxHPIncrease()
{
	with(global.oPlayer)
	{
		var _leaves_buf = array_create(max_hp);
		var _jitterings_buf = array_create(max_hp);
		array_copy(_leaves_buf,0,hp_leaves,0,max_hp);
		array_copy(_jitterings_buf,0,hp_jitterings,0,max_hp);
		
		hp_leaves = array_create(max_hp+1);
		hp_jitterings = array_create(max_hp+1);
		
		array_copy(hp_leaves,0,_leaves_buf,0,max_hp);
		array_copy(hp_jitterings,0,_jitterings_buf,0,max_hp);
		
		hp_leaves[max_hp] = 0;
		hp_jitterings[max_hp] = random(1);
		
		max_hp++;
	}
}