///@arg x
///@arg y
///@arg text
///@arg time* in seconds
///@arg halign*
///@arg valign*
function TextNotification(_x,_y,_text,_time = 2,_halign = fa_center,_valign = fa_middle){
	var _inst = instance_create_layer(_x,_y,"Managers",obj_text_notification);
	with(_inst)
	{
		text = _text;
		text_lifetime = _time * FRAME_RATE;	
		h_align = _halign;	
		v_align = _valign;		
	}
	return _inst;
}