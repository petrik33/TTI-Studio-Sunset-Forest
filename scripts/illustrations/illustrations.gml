///@arg sprite
///@arg text_array
///@arg cbk_start
///@arg cbk_end
///@arg music
function IllustrationSequenceCreate(_sprite,_text_array,_cbk_start,_cbk_end){
	var _inst = instance_create_layer(0,0,"Managers",obj_illustration_sequence);
	with(_inst)
	{
		sprite_index = _sprite;
		text_array = _text_array;
		sequence_starting_callback = _cbk_start;
		sequence_ending_callback = _cbk_end;
	}
	return _inst;
}