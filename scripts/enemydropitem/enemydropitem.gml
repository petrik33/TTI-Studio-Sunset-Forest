function EnemyDropItem(){
	if(random(1)<=drop_chance)
	{
		var drop_hp = 0;
		if(instance_exists(global.oPlayer))
		{
			var _max_hp = global.oPlayer.max_hp;
			var _hp = global.oPlayer.current_hp;
			drop_hp += (_max_hp - _hp) / (_max_hp - 1); //Less HP Higher Chance
		}
		if(random(1) < drop_hp)
		{
			var _drop_element = obj_hp_fragment;
		}
		else
		{
			var _drop_element = drops_list[irandom(array_length(drops_list)-1)];	
		}
		return instance_create_layer(x,y,"Effects",_drop_element);
	}
	return noone;
}