///@desc Slow Light Up
image_alpha+=light_up_alpha_spd;
if(image_alpha >= alpha_target) image_alpha = alpha_target;
else alarm[1] = 1;
