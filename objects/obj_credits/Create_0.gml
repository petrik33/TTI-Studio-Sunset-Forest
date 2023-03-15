#region Turn everything odd off

//data_buffer = global.live_debug_data_on;
//global.live_debug_data_on = false;

#endregion

//#region Time
//var credits_time = 210 * FRAME_RATE;
//#endregion

#region Authors

enum CREDITS_ARRAY{
	animations,
	//statics,
	names,
	roles,
	size
}

enum authors{
	KURE,
	petrik,
	Jesus,
	Daryl,
	size
}

credits[CREDITS_ARRAY.animations] = [spr_credits_KURE,spr_credits_petrik,spr_credits_JesusBream,spr_credits_Daryl_new];

//credits[CREDITS_ARRAY.statics] = 
//[
//	spr_credits_static_KURE,
//	spr_credits_static_petrik,
//	spr_credits_static_Jesus,
//	spr_credits_static_Daryl
//]

credits[CREDITS_ARRAY.names] = 
[
	"Kure Mothri",
	"Timofey Petrikevich",
	"Jesus Brea",
	"Daryl Thompson"
];

credits[CREDITS_ARRAY.roles] = 
[
	"Game Art and Design",
	"Programming",
	"Music and Sound Design",
	"Sound Design"
];

//authors_font = fn_credits_authors;
authors_font = fn_credits_authors_crlc;

current_id = -1;

name_role_y = global.GUI_H * 0.8;

name_x = global.GUI_W * 0.1; // Left halign
role_x = global.GUI_W * 0.9; // Right halign

name_role_alpha = 0;

var name_role_transition_time = FRAME_RATE * 1;
var author_transition_out_time = FRAME_RATE * 1.5;
credits_time_forOne = FRAME_RATE * 5;

name_role_alpha_spd = 1 / name_role_transition_time;
author_transition_out_spd = 1 / author_transition_out_time;

#endregion

#region People

enum CREDITS_PAGE_SECTION {
	TESTERS,
	SPECIAL,
	NUMBER
}

//credits_page = array_create(CREDITS_PAGE_SECTION.NUMBER,ds_list_create());
credits_page_names = ["Play Testing","Special Thank You"];

//page_font = fn_credits;
page_font = fn_credits_crlc;
thank_you_font = fn_credits_thank_crlc;

section_gap = font_get_size(authors_font) * 0.33;
//names_gap = font_get_size(page_font) * 1.5;

//draw_set_font(authors_font);

//var _max = string_height(credits_page_names[0])
//for(var i = 1; i < CREDITS_PAGE_SECTION.NUMBER; i++)
//{
//	var _this = string_height(credits_page_names[i]);
//	if(_this > _max)
//	{
//		_max = _this;	
//	}
//}

page_width = global.GUI_W * 0.9;
page_height = global.GUI_H * 0.9;// - _max - section_gap;

current_people_role = -1;
current_person_id = -1;

show_people_delay_time = FRAME_RATE * 2;
var person_transition_time = FRAME_RATE * 2;
var thank_you_for_transition_time = FRAME_RATE * 1.5;
var people_role_transition_time = FRAME_RATE * 3;
people_trans_out_delay = FRAME_RATE * 3;
show_thank_you_delay = FRAME_RATE * 1;
person_delay = FRAME_RATE * 0.5;

people_role_alpha = 0;
person_alpha = 0;
thank_you_for_alpha = 0;

people_role_alpha_spd = 1 / people_role_transition_time;
person_alpha_spd = 1 / person_transition_time;
thank_you_for_alpha_spd = 1/ thank_you_for_transition_time;
people_trans_out_spd = people_role_alpha_spd;

people_role_y = (global.GUI_H - page_height) / 2;
people_role_x = global.GUI_W / 2;

people_leftX = (global.GUI_W - page_width) / 2;
people_rightX = people_leftX + page_width;

thank_you_gap = GUI_BOUND * 2;

#region Adding People

/////@arg name
/////@arg role_enum
//function credits_page_add_name(_name,_role = CREDITS_PAGE_SECTION.SPECIAL){
//	ds_list_add(credits_page[@ _role],_name);
//}

credits_page = 
[
	[
		"'Reen'",
		"'TomMakes'",
		"Caedmon Reichert",
		"Mako Winston",
		"'Demina'",
		"'CodeCombustion'",
		"'TacoBell_Lord'",
		"Giovanni Santos",
		"Michel Gerônimo",
		"Luiz Fernando",
		"Ivan Titslove",
		"Vladislav Sparish",
		"Artemy Kuteyko",
		"Dmitriy Krumkachev",
		"Ivan Kosiak",
		"Kirill Zavadskiy",
		"Anton Sadovskiy",
		"Alexey Kononov"
	],
	[
		"'Oaelluin'",
		"Pavel Rogovcov",
		"'Cazsu'",
		"Darya Kornacheva",
		"Zapsplat.com",
		"'Kerf Merf'",
		"Nadezhda Surmenyova",
		"Dafont.com",
		"Vladislav Petrikevich",
		"Мама,",
	]
];

thank_you_for_list = [
	"for main menu composition",
	"for neverending testing",
	"for sound design help",
	"for winning that UNO game",
	"for sound assets",
	"for proofreading",
	"for marketing video",
	"for font assets",
	"for always being there for me",
	"Я люблю тебя"
]

#endregion

#endregion

#region Else

visible = true;

MusicStart(ms_credits,fade_time.slow,global.MusicCallbackLoopDelayed);

x = global.GUI_W/2;
y = global.GUI_H/2;

#endregion

#region Message

message_text = Text("Credits: Thank You Message");
with_love_text = Text("Credits: With Love");

draw_set_font(page_font);

with_love_x = (page_width + global.GUI_W) / 2;
with_love_y = global.GUI_H / 2 + string_height_ext(message_text,-1,page_width) / 2 + GUI_BOUND * 3;

message_alpha = 0;
with_love_alpha = 0;

show_message_delay_time = FRAME_RATE * 0.5;
var message_transition_time = FRAME_RATE * 2;
message_show_time = FRAME_RATE * 15;
with_love_show_time = FRAME_RATE * 7;

message_alpha_spd = 1 / message_transition_time;
with_love_alpha_spd = 1 / (FRAME_RATE * 1);
message_trans_out_spd = 1 / (FRAME_RATE * 2);

#endregion

#region State Machine

function CreditsNewAnimation(){
	current_id++;
	if(current_id == authors.size)
	{
		sprite_index = -1;
		return false;
	}
	sprite_index = credits[CREDITS_ARRAY.animations][current_id];
	image_alpha = 1;
	image_index = 0;
	image_speed = 1;
	return true;
}

function CreditsStateStart(){
	if(--timer <= 0)
	{
		state = CreditsStateAnimation;
		CreditsNewAnimation();
		return true;
	}
}

function CreditsStateAnimation(){
	if(AnimationEnd() || skip_button)
	{
		image_speed = 0;
		image_index = image_number - 1;
		state = CreditsStateRoleReveal;
		timer = show_message_delay_time;
	}
}

function CreditsStateRoleReveal(){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	name_role_alpha += name_role_alpha_spd;
	if(name_role_alpha >= 1 || skip_button)
	{
		name_role_alpha = 1;
		state = CreditsStateDeveloperWait;
		timer = credits_time_forOne;
	}
}

function CreditsStateDeveloperWait(){
	if(--timer <= 0 || skip_button)
	{
		state = CreditsStateAnimationTransOut;
	}
}

function CreditsStateAnimationTransOut(){
	image_alpha -= author_transition_out_spd;
	name_role_alpha = image_alpha;
	
	if(image_alpha <= 0 || skip_button)
	{
		name_role_alpha = 0;
		image_alpha = 0;
		if(CreditsNewAnimation())
		{
			state = CreditsStateAnimation;
		}
		else
		{
			timer = show_message_delay_time;
			state = CreditsStateMessageTransition;
		}
	}
}

function CreditsStateMessageTransition(){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	message_alpha += message_alpha_spd;
	if(message_alpha >= 1 || skip_button)
	{
		message_alpha = 1;
		state = CreditsStateShowMessage;
		timer = message_show_time;
	}
}

function CreditsStateShowMessage(){
	if(--timer <= 0 || skip_button)
	{
		//CreditsEnd(0.5);
		state = CreditsStateWithLoveTransition;
		with_love_alpha = 0;
	}
}

function CreditsStateWithLoveTransition(){
	with_love_alpha += with_love_alpha_spd;
	if(with_love_alpha >= 1 || skip_button)
	{
		with_love_alpha = 1;
		state = CreditsStateShowWithLove;
		timer = with_love_show_time;
	}
}

function CreditsStateShowWithLove(){
	if(--timer <= 0 || skip_button)
	{
		state = CreditsStateMessageTransitionOut;
	}
}

function CreditsStateMessageTransitionOut(){
	message_alpha -= message_trans_out_spd;
	with_love_alpha = message_alpha;
	if(message_alpha <= 0 || skip_button)
	{
		message_alpha = 0;
		with_love_alpha = 0;
		CreditsShowNewPeopleRole();
	}
}

function CreditsShowNewPeopleRole(){
	if(current_people_role == CREDITS_PAGE_SECTION.NUMBER - 1)
	{
		return false;	
	}
	timer = show_people_delay_time;
	people_role_alpha = 0;
	person_alpha = 0;
	current_person_id = 0;
	current_people_role++;
	state = CreditsStatePeopleTransition;
	image_alpha = 1;
	return true;
}

function CreditsStatePeopleTransition(){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	people_role_alpha += people_role_alpha_spd;
	if(people_role_alpha >= 1 || skip_button)
	{
		timer = show_people_delay_time;
		people_role_alpha = 1;
		person_alpha = 0;
		current_person_id = 0;
		state = CreditsStatePeopleReveal;
	}
}

function CreditsStatePeopleReveal(){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	person_alpha += person_alpha_spd;
	if(person_alpha >= 1 || skip_button)
	{
		if(current_people_role == CREDITS_PAGE_SECTION.SPECIAL)
		{
			person_alpha = 1;
			state = CreditsStateThankYouReveal;
			timer = show_thank_you_delay;
			return;
		}
		if(!CreditsNewPerson())
		{
			person_alpha = 1;
			timer = people_trans_out_delay;
			state = CreditsStatePeopleTransitionOut;
			return false;	
		}
	}
}

function CreditsNewPerson(){
	person_alpha = 0;
	timer = person_delay;
	var person_num = array_length(credits_page[current_people_role]);
	current_person_id++;
	if(current_person_id == person_num)
	{
		return false;
	}
	return true;
}

function CreditsStateThankYouReveal( ){
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	thank_you_for_alpha += thank_you_for_alpha_spd;
	if(thank_you_for_alpha >= 1 || skip_button)
	{
		thank_you_for_alpha = 0;
		if(CreditsNewPerson())
		{
			state = CreditsStatePeopleReveal;	
		}
		else
		{
			person_alpha = 1;
			timer = people_trans_out_delay;
			state = CreditsStatePeopleTransitionOut;
			return false;		
		}
	}
}

function CreditsStatePeopleTransitionOut() {
	if(--timer <= 0 || skip_button)
	{
		timer = 0;
	}
	else
	{
		return;	
	}
	image_alpha -= people_trans_out_spd;
	people_role_alpha = image_alpha;
	person_alpha = image_alpha;
	if(image_alpha <= 0 || skip_button)
	{
		image_alpha = 0;
		people_role_alpha = 0;
		person_alpha = 0;
		if(!CreditsShowNewPeopleRole())
		{
			//Proceed to End
			CreditsEnd(0.5);
		}
	}
}

///@arg time
function CreditsEnd(_time) {
	MusicStop(_time*MILI_TO_SECONDS);
	state = CreditsStateEnd;
	if(!global.game_final)
	{
		FadeInRoom(room0,_time);
		return;
	}
	//instance_destroy(obj_game);
	//FadeInRoom(room_intro,_time);
	FadeInRoom(room_intro,_time);
}

function CreditsStateEnd(){
	
}

state = CreditsStateStart;

#endregion

var starting_time = FRAME_RATE * 2;
timer = starting_time;










