///@arg array
///@arg irandom
function RangeArrayGetNumber(_range_array,_irandom){
	if(_irandom)
	{
		return irandom_range(_range_array[0],_range_array[1]);
	}
	else
	{
		return random_range(_range_array[0],_range_array[1]);
	}
}