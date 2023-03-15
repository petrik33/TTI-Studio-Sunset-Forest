///@func scr_add_boss_stage_colors()
///@arg R
///@arg G
///@arg B
///@arg con
///@arg sat
///@arg brt
///@arg popS
///@arg popT
///@arg part
function scr_add_boss_stage_colors(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7,_part) {
	if(colors[_part] = undefined)
	{
		var i = 0;	
	}
	else
	{
		var i = array_length(colors[_part])	
	}
	colors[_part][i,0] = argument0/255;
	colors[_part][i,1] = argument1/255;
	colors[_part][i,2] = argument2/255;

	con_sat_brt[_part][i,0] = argument3;
	con_sat_brt[_part][i,1] = argument4;
	con_sat_brt[_part][i,2] = argument5;
	con_sat_brt[_part][i,3] = argument6;
	con_sat_brt[_part][i,4] = argument7;


}
