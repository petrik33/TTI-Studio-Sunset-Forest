///@arg string
///@arg file_name
function StringSaveInFile(_string,_file_name){
	var _file = file_text_open_write(_file_name);
	file_text_write_string(_file,_string);
	file_text_close(_file);
}