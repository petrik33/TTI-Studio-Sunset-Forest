///@desc Creates Time Source for further reconfigure
///@arg parent
function time_source_create_empty(_parent){
	var _tsource = time_source_create(_parent,0,time_source_units_seconds,function(){});
	time_source_stop(_tsource);
	return _tsource;
}