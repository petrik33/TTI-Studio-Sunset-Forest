event_inherited();
blinking_spd = pi / (blink_period_seconds * FRAME_RATE);
blink_progress = 0;
additional_alpha = 1 - minimal_alpha;
dying = true;
