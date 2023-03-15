shader_set(sh_outline);
shader_set_uniform_f(u_pixelWidth,texelW);
shader_set_uniform_f(u_pixelHeight,texelH);

image_blend = outline_color;

draw_self();

shader_reset();
