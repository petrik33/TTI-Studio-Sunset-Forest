///@func scr_add_key_time
///@arg R
///@arg G
///@arg B
///@arg con
///@arg sat
///@arg brt
///@arg popS
///@arg popT
function scr_add_key_time(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	if(colors[0,0] = undefined)
	{
		var i = 0;	
	}
	else
	{
		var i = array_length(colors)	
	}
	colors[i,0] = argument0/255;
	colors[i,1] = argument1/255;
	colors[i,2] = argument2/255;

	con_sat_brt[i,0] = argument3;
	con_sat_brt[i,1] = argument4;
	con_sat_brt[i,2] = argument5;
	con_sat_brt[i,3] = argument6;
	con_sat_brt[i,4] = argument7;


}
