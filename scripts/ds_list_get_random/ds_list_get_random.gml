///@arg list
function ds_list_get_random(_list){
	var _id = irandom(ds_list_size(_list)-1);
	return (_list[| _id])
}