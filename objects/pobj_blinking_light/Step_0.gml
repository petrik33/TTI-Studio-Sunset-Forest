if(!dying)
{
	image_alpha = minimal_alpha + abs(cos(blink_progress)) * additional_alpha;
	blink_progress += blinking_spd;
	if(blink_progress> double_pi) blink_progress = blink_progress mod double_pi;
}
