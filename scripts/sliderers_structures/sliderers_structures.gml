///@arg value_name
///@arg value_min
///@arg value_max
///@arg value_current
///@arg decimals_count

function slider_struct(_value_name,_value_min,_value_max,_value_current,_decimals_count) constructor
{
	value_name = _value_name;
	value_min = _value_min;
	value_max = _value_max;
	current_value = _value_current;
	default_value = _value_current;
	decimals_count = _decimals_count;
}