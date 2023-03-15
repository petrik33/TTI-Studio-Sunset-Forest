///@arg file
function DS_MapLoadFromJSON(file_to_load_from){
	var _readed_file = file_text_open_read(file_to_load_from);
	var _encoded_string = file_text_read_string(_readed_file);
	var ds_map_to_load_to = json_decode(_encoded_string);
	
	file_text_close(_readed_file);
	
	return ds_map_to_load_to
}