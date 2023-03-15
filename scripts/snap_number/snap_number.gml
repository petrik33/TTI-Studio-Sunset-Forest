///@arg number
///@arg snap_degree
function snap_number(_number,_snap_degree){
	return ( round(_number/_snap_degree) * _snap_degree );
}