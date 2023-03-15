/// @description Self and Defenses Draw

shader_set(sh_outline);
shader_set_uniform_f(u_pixelWidth,texelW);
shader_set_uniform_f(u_pixelHeight,texelH);

image_blend = outline_color;

draw_self();

if(!raged)
{
	for(var i = 0; i < coluna_defs_left; i++)
	{
		var _x = x + lengthdir_x(coluna_defs_circle_R,coluna_defs_spin_prog + 90 * i) * image_xscale;
		var _y = y + lengthdir_y(coluna_defs_circle_R,coluna_defs_spin_prog + 90 * i);
		draw_sprite(spr_coluna_defense,0,_x,_y);
	}
	coluna_defs_spin_prog+=coluna_defs_spin_spd;
	if(coluna_defs_spin_prog >= 360) coluna_defs_spin_prog %= 360;
}

shader_reset();


