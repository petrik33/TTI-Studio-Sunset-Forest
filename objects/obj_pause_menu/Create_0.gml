#region//Create Menu Pages

menu_pages = array_create(menu_page.last_empty,noone);

create_menu_page(
	menu_page.main,
	[Text("Resume"),		menu_element_type.script_runner,	UnpauseGame],
	[Text("Bestiary"),		menu_element_type.bestiary,			0,	-1],
	[Text("Photo Mode"),	menu_element_type.script_runner,	MenuHeadToPhotoModePage],
	[Text("Settings"),		menu_element_type.page_transfer,	menu_page.settings],
	[Text("Quit"),			menu_element_type.script_runner,	QuitToMainMenu]
)

menu_in_photo_mode = false;

create_menu_page(
	menu_page.photo_mode,
	[Text("Hide"),	menu_element_type.script_runner,	MenuPhotoModeOn],
	[Text("Special Light"),	menu_element_type.shifter,  [Text("Off"),Text("Stopped"),Text("Cycling")],	1,	DayNightPausedModeSwitch],
	[Text("Back"),	menu_element_type.page_transfer,	menu_page.main]
)

create_menu_page(
	menu_page.settings,
	[Text("Audio"),		menu_element_type.page_transfer,	menu_page.audio],
	[Text("Controls"),	menu_element_type.page_transfer,	menu_page.controls],
	//[Text("Graphics"),  menu_element_type.page_transfer,    menu_page.graphics],
	//[Text("Enemies"),	menu_element_type.page_transfer,	menu_page.enemies],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.main]
)

//create_menu_page(
//	menu_page.graphics,
//	[Text("Windowed"),			menu_element_type.toggle,  WindowedToggle,		global.windowed],
//	[Text("Photosensitive"),	menu_element_type.toggle, PhotosensitiveToggle,		global.photosensitive],
//	[Text("Back"),				menu_element_type.page_transfer,	menu_page.settings]
//)

create_menu_page(
	menu_page.audio,
	[Text("Music"),		menu_element_type.rectangular_bar,	ChangeMusicVolume,	global.music_group_gain * 10,	[0,10], 10	],
	[Text("Sounds"),	menu_element_type.rectangular_bar,	ChangeSoundsVolume,	global.sounds_group_gain * 10,	[0,10], 10	],
	[Text("Silence"),	menu_element_type.script_runner,	PauseMenuSoundsOff],
	[Text("Default"),	menu_element_type.script_runner,	PauseMenuSoundsFull],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.settings]
)

create_menu_page(
	menu_page.controls,
	[Text("Skills"),			menu_element_type.page_transfer,		menu_page.skills_controls],
	[Text("Laptop"),			menu_element_type.toggle,				AlternativeControlsToggle,	global.alternative_controls_on],
	[Text("Other"),				menu_element_type.page_transfer,		menu_page.alternative_keys],
	[Text("Default"),			menu_element_type.script_runner,		PauseMenuControlsSetDefault],
	[Text("Back"),				menu_element_type.page_transfer,		menu_page.settings]
)

create_menu_page(
	menu_page.skills_controls,
	[Text("Ice Trap"),				menu_element_type.control_input,		chr(global.oPlayer.skills[0][SKILL.HOTKEY]),		global.oPlayer.skills[0][SKILL.HOTKEY]],
	[Text("Fire Ball"),				menu_element_type.control_input,		chr(global.oPlayer.skills[1][SKILL.HOTKEY]),		global.oPlayer.skills[1][SKILL.HOTKEY]],
	[Text("Wind Wave"),				menu_element_type.control_input,		chr(global.oPlayer.skills[2][SKILL.HOTKEY]),		global.oPlayer.skills[2][SKILL.HOTKEY]],
	[Text("Thunder Strike"),		menu_element_type.control_input,		chr(global.oPlayer.skills[3][SKILL.HOTKEY]),		global.oPlayer.skills[3][SKILL.HOTKEY]],
	[Text("Back"),			menu_element_type.page_transfer,		menu_page.controls]
)

create_menu_page(
	menu_page.alternative_keys,
	[Text("Interaction"),	menu_element_type.control_input,			chr(global.oPlayer.alternative_controls[0]),		global.oPlayer.alternative_controls[0]],
	[Text("Attack"),		menu_element_type.mouse_alternative_input,	chr(global.oPlayer.alternative_controls[1]),		global.oPlayer.alternative_controls[1], global.alternative_controls_on],
	[Text("Push"),			menu_element_type.mouse_alternative_input,	chr(global.oPlayer.alternative_controls[2]),		global.oPlayer.alternative_controls[2], global.alternative_controls_on],
	[Text("Back"),			menu_element_type.page_transfer,			menu_page.controls]
)

//create_menu_page(
//	menu_page.enemies,
//	[Text("Enemies Used"),	menu_element_type.enemy_toggle, 0, -1],
//	[Text("Back"),			menu_element_type.page_transfer, menu_page.controls]
//)


#endregion

#region//Activation/Deactivation

no_input_sleep_time = FRAME_RATE * 4;
sleep_timer = 0;
var fade_away_time = FRAME_RATE * 1;
fade_away_spd = 1 / fade_away_time;
sleeping = false;

#endregion

event_inherited();

//#region//Saving/Loading

//MenuLoadSoundSettings();

//#endregion


