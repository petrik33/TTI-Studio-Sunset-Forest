///@arg inst
function ObjectIsVisible(_inst = self){
	with(global.oCamera)
	{
		var view_xleft = x - view_w_half;
		var view_xright = x + view_w_half;
		
		var view_ytop = y - view_h_half;
		var view_ybot = y + view_h_half;
	}
	with(_inst)
	{
		if(sign(image_xscale) == 1)
		{
			var inst_xleft = x - sprite_get_xoffset(sprite_index);
			var inst_xright = inst_xleft + sprite_width;
		}
		else
		{
			var inst_xright = x + sprite_get_xoffset(sprite_index);
			var inst_xleft = inst_xright + sprite_width;	//sprite_width is multipyed by image_xscale automatically
		}
		
		var inst_ytop = y - sprite_get_yoffset(sprite_index);
		var inst_ybot = y + sprite_height;
	}
	
	return(
		inst_xleft < view_xright &&
		inst_xright > view_xleft &&
		inst_ytop < view_ybot &&
		inst_ybot > view_ytop
	)
}