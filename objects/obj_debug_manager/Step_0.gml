var key = ds_map_find_first(debug_bindings);
do
{
	if(keyboard_check_pressed(key))
	{
		debug_bindings[? key]();//Activate Bind
	}
    key = ds_map_find_next(debug_bindings,key);
}
until (key == undefined);