///@arg time_source
function time_source_active(_tsource){
	return (time_source_get_state(_tsource) == time_source_state_active);
}

///@arg time_source
function time_source_stop_active(_tsource){
	if(time_source_active(_tsource))
	{
		time_source_stop(_tsource);	
	}
}