sequence_ending_callback = function () { return };
sequence_starting_callback = function () { return };

#region Image

x = global.initial_viewW / 2;
y = global.initial_viewH / 2;

var scale = min(window_get_width() div ILLU_WIDTH,window_get_height() div ILLU_HEIGHT)/global.initial_viewScale;
image_xscale = scale;
image_yscale = scale;

image_speed = 0;

show_image = false;

#endregion

#region Text

text_y = y + ILLU_TEXT_Y * scale;
text_width = global.GUI_W - GUI_BOUND * 6;
text_font = Font(fn_illustrations);
text_progress = 0;
text_array = -1;
current_text = -1;

skip_button = false;

#endregion

#region Time

var transitionTime = FRAME_RATE * 2;
timeWait = FRAME_RATE * 5;
timeBetweenTransitions = 10; //Frames

#endregion 

#region Transitions

transition_progress = 0;
transition_speed = 1 / transitionTime; //Start

//screen_top = -global.GUI_YOFFSET;
screen_centre = global.initial_viewH / 2;
//screen_bot = global.initial_viewH + global.GUI_YOFFSET;

//var empty_space_height = (display_get_height() - illustrations_scale * ILLU_HEIGHT) / 2

gui_bot = global.GUI_H;
gui_top = 0;

gui_left = 0;
gui_right = global.GUI_W;

#endregion

#region States

timer = 0;

function StateTransitionIn(){
	transition_progress += transition_speed;
	if(transition_progress >= 1 || skip_button)
	{
		transition_progress = 1;
		timer = timeBetweenTransitions;
		state = StateBetweenTransitions;
		
		text_progress = 0;
		
		if(show_image == false)
		{
			//First Transition In
			sequence_starting_callback();
			current_text = TextSeparate(text_array[0],text_font,text_width);
			show_image = true;
			//if(global.illustrations_watched)
			//{
			//	full_skip_show = true;
			//}
			return;
		}
		
		if(image_index == image_number - 1 || full_skip)
		{
			//Last Transition In
			sequence_ending_callback();
			show_image = false;
			current_text = -1;
			return;
		}
		
		image_index++;
		current_text = TextSeparate(text_array[image_index],text_font,text_width);
	}
}

function StateBetweenTransitions(){
	if(--timer <= 0 || skip_button){
		timer = 0;
		state = StateTransitionOut;
	}
}

function StateTransitionOut(){
	transition_progress -= transition_speed;
	if(transition_progress <= 0 || skip_button)
	{
		transition_progress = 0;
		if(show_image == false)
		{
			//Final Transition
			global.illustrations_watched_this_time = true;
			instance_destroy();
			return;
		}
		state = StateTextProgress;
	}
}

function StateTextProgress(){
	text_progress += global.text_speed;
	var str_len = string_length(current_text);
	if(text_progress >= str_len || skip_button)
	{
		text_progress = str_len;
		timer = timeWait;
		state = StateWait;
	}
}

function StateWait(){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
		state = StateTransitionIn;
	}
}

state = StateTransitionIn;

#endregion

#region Full Skip

//full_skip_show = false;

//full_skip_sin_progress = 0;
//full_skip_sin_spd = pi / (FRAME_RATE * 4);

//full_skip_max_alpha = 0.8;

//full_skip_alpha = abs(sin(full_skip_sin_progress) * full_skip_max_alpha);

//full_skip_text = Text("Illustrations: skip tip");
full_skip_counter = 0;
full_skip_time = FRAME_RATE * 1;

//full_skip_y_offset = y - ILLU_HEIGHT/2 * scale;
//full_skip_x_offset = x - (ILLU_WIDTH/2 - ILLU_BARS_WIDTH) * scale;

//full_skip_x_offset = GUI_BOUND - global.GUI_XOFFSET;
//full_skip_y_offset = GUI_BOUND - global.GUI_YOFFSET;

full_skip = false;

#endregion