/// @description Slow Destruction
image_alpha -= dying_alpha_spd;
if(image_alpha <= 0) instance_destroy();
else alarm[0] = 1;
