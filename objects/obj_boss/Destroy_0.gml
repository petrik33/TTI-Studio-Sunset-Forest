event_inherited();
instance_destroy(global.boss_manager);
for(var i = 0; i < SKILLS.NUMBER; i ++)
{
	var _state = boss_states[i];
	var _attacks = _state.boss_attacks;
	for(var j = 0; j < array_length(_attacks); j++)
	{
		var _struct = _attacks[j];
		delete _struct;
	}
	delete _state;
}
