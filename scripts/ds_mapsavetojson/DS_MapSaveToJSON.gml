///@ds_map
///@file
function DS_MapSaveToJSON(ds_map_to_save,file_to_save){
	var string_to_save = json_encode(ds_map_to_save);
	var _new_file = file_text_open_write(file_to_save);
	file_text_write_string(_new_file,string_to_save);
	file_text_close(_new_file);
	ds_map_destroy(ds_map_to_save);
}