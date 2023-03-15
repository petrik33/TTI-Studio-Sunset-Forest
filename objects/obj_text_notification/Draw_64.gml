image_alpha = animcurve_channel_evaluate(anim_channel,timer/text_lifetime)
draw_set_alpha(image_alpha);
draw_set_color(text_color);

draw_set_halign(h_align);
draw_set_valign(v_align);

draw_text(x,y,text);

draw_set_color(c_white);
draw_set_alpha(1);


if(++timer >= text_lifetime) instance_destroy();