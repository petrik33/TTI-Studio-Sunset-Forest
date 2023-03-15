///@arg key_previous
///@arg key_next
///@arg lerp_amount
///@arg colors
function mix_key_colors(key_previous,key_next,lerp_amount,colors){
	var color_mix = [
			 lerp(colors[key_previous,0],colors[key_next,0],lerp_amount),
			 lerp(colors[key_previous,1],colors[key_next,1],lerp_amount),
			 lerp(colors[key_previous,2],colors[key_next,2],lerp_amount)];
			 
	return color_mix
}