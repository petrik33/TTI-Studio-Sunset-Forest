///@arg idle
///@arg death
///@arg run
///@arg pushed
function EntityUpdateSprites(_idle = sprite_index,_death = sprite_death,_run = _idle, _pushed = _idle){
	sprite_idle = _idle;
	sprite_death = _death;
	sprite_pushed = _pushed;
	sprite_run = _run;
}