///@arg key_previous
///@arg key_next
///@arg lerp_amount
///@arg con_sat_brt
function mix_key_con_sat_brt(key_previous,key_next,lerp_amount,con_sat_brt){
	var con_sat_brt_mix = [lerp(con_sat_brt[key_previous,0],con_sat_brt[key_next,0],lerp_amount),
			 lerp(con_sat_brt[key_previous,1],con_sat_brt[key_next,1],lerp_amount),
			 lerp(con_sat_brt[key_previous,2],con_sat_brt[key_next,2],lerp_amount),
			 lerp(con_sat_brt[key_previous,3],con_sat_brt[key_next,3],lerp_amount),
			 lerp(con_sat_brt[key_previous,4],con_sat_brt[key_next,4],lerp_amount)]; 
	return con_sat_brt_mix
}