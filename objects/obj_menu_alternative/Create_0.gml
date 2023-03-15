#region//Settings Loading

#region//Controls

if(!file_exists(global.controls_file) || global.controls_file_reset)
{
	var default_controls_map = ds_map_create();
	
	for(var i=0;i<array_length(global.default_skill_controls);i++)
	{
		var _control = global.default_skill_controls[i];
		ds_map_add(default_controls_map, global.oPlayer.skills[i][SKILL.NAME], _control);
		global.controls_used[i] = _control;
	}
	
	ds_map_add(default_controls_map,"Alternative Toggle", false);
	
	for(var k=0;k<array_length(global.default_alternative_controls);k++)
	{
		var _alt_control = global.default_alternative_controls[k];
		ds_map_add(default_controls_map, global.oPlayer.alternative_controls_names[k], _alt_control);
		global.controls_used[i + k] = _alt_control;
	}
	
	DS_MapSaveToJSON(default_controls_map,global.controls_file);
	
	ds_map_destroy(default_controls_map);
}
else
{
	MenuLoadControls();
}

#endregion

#region//Audio

if(!file_exists(global.audio_settings_file))
{
	var default_settings_map = ds_map_create();
	global.music_group_gain = 1;
	global.sounds_group_gain = 1;
	default_settings_map[? "Music"] = global.music_group_gain;
	default_settings_map[? "Sounds"] = global.sounds_group_gain;
	
	DS_MapSaveToJSON(default_settings_map,global.audio_settings_file);
	
	ds_map_destroy(default_settings_map);
}
else
{
	MenuLoadSoundSettings();
}

#endregion

#region Game Data

MenuLoadGameData();

#endregion

//#region Game Progress Data

//MenuLoadGameData()

//#endregion

#endregion

#region Delayed Activation

menu_active = false;
alarm[1] = FRAME_RATE * 2;

#endregion

#region//Create Menu Pages

menu_pages = array_create(menu_page.last_empty,noone);

create_menu_page(
	menu_page.main,
	[Text("New Game"),		menu_element_type.script_runner,	StartGame],
	[Text("Credits"),		menu_element_type.script_runner,	MenuRunCredits],
	[Text("Settings"),		menu_element_type.page_transfer,	menu_page.settings],
	[Text("Exit"),			menu_element_type.script_runner,	ExitGame]
)
#region Save File Exists Check
if(global.save_exists)
{
	menu_pages[menu_page.main][0] = [Text("Start Game"),	menu_element_type.page_transfer,	menu_page.start_game];
	create_menu_page(
		menu_page.start_game,
		[Text("Continue"),		menu_element_type.script_runner,	MenuStartSavedGame],
		[Text("New Game"),		menu_element_type.script_runner,	StartGame],
		[Text("Tutorial"),		menu_element_type.script_runner,	StartTutorialOnly],
		[Text("Back"),		menu_element_type.page_transfer,	menu_page.main],
	)
}
#endregion

create_menu_page(
	menu_page.settings,
	[Text("Game"),  menu_element_type.page_transfer,    menu_page.graphics],
	[Text("Audio"),		menu_element_type.page_transfer,	menu_page.audio],
	[Text("Controls"),	menu_element_type.page_transfer,	menu_page.controls],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.main]
)

if(debug_version)
{
	array_insert(menu_pages[menu_page.settings],0,[Text("Debug"),		menu_element_type.page_transfer,	menu_page.debugging]);	
}

create_menu_page(
	menu_page.graphics,
	[
		Text("Language"),
		menu_element_type.shifter,
		[Text("English"),Text("Russian"),Text("Portuguese")],
		global.language,
		MenuChangeLanguage
	],
	[Text("Windowed"),			menu_element_type.toggle,  WindowedToggle,		global.windowed],
	[Text("Photosensitive"),	menu_element_type.toggle, PhotosensitiveToggle,		global.photosensitive],
	[Text("Back"),				menu_element_type.page_transfer,	menu_page.settings]
)

create_menu_page(
	menu_page.audio,
	[Text("Music"),		menu_element_type.rectangular_bar,	ChangeMusicVolume,	global.music_group_gain * 10,	[0,10], 10	],
	[Text("Sounds"),	menu_element_type.rectangular_bar,	ChangeSoundsVolume,	global.sounds_group_gain * 10,	[0,10], 10	],
	[Text("Silence"),	menu_element_type.script_runner,	SoundsOff],
	[Text("Default"),	menu_element_type.script_runner,	SoundsFull],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.settings]
)

create_menu_page(
	menu_page.controls,
	[Text("Skills"),			menu_element_type.page_transfer,		menu_page.skills_controls],
	[Text("Laptop"),			menu_element_type.toggle,				AlternativeControlsToggle,	global.alternative_controls_on],
	[Text("Other"),				menu_element_type.page_transfer,		menu_page.alternative_keys],
	[Text("Default"),			menu_element_type.script_runner,		ControlsSetDefault],
	[Text("Back"),				menu_element_type.page_transfer,		menu_page.settings]
)

#region Controls Get
var _controls = array_create(SKILLS.NUMBER);
for(var i = 0; i < SKILLS.NUMBER; i++)
{
	_controls[i] = global.oPlayer.skills[i][SKILL.HOTKEY];	
}
#endregion

create_menu_page(
	menu_page.skills_controls,
	[Text("Ice Trap"),				menu_element_type.control_input,				chr(_controls[0]),		_controls[0]],
	[Text("Fire Ball"),				menu_element_type.control_input,				chr(_controls[1]),		_controls[1]],
	[Text("Wind Wave"),				menu_element_type.control_input,				chr(_controls[2]),		_controls[2]],
	[Text("Thunder Strike"),		menu_element_type.control_input,				chr(_controls[3]),		_controls[3]],
	[Text("Back"),					menu_element_type.page_transfer,		menu_page.controls]
)

create_menu_page(
	menu_page.debugging,
	[Text("Quick Start"), menu_element_type.script_runner,    MenuQuickStart],
	[Text("Day & Night"), menu_element_type.script_runner,	DayNightDebugModeRun],
	[Text("Enemies"),	menu_element_type.page_transfer,		menu_page.enemies],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.settings]
)

create_menu_page(
	menu_page.day_night_debug,
	[Text("Contrast"),		menu_element_type.slider,	DayNightDebugSetContrast,		0.8,	[0,1]],
	[Text("Saturation"),	menu_element_type.slider,	DayNightDebugSetSaturation,		1,		[0,1.6]],
	[Text("Brightness"),	menu_element_type.slider,	DayNightDebugSetBrightness,		0,		[-1,1]],
	[Text("Pop Strength"),	menu_element_type.slider,	DayNightDebugSetPopStrength,	0,		[-1,1]],
	[Text("Pop Threshold"),	menu_element_type.slider,	DayNightDebugSetPopThreshold,	1,		[0,1.6]],
	[Text("Color R"),		menu_element_type.slider,	DayNightDebugSetColorR,			0.5,	[0,1]],
	[Text("Color G"),		menu_element_type.slider,	DayNightDebugSetColorG,			0.5,	[0,1]],
	[Text("Color B"),		menu_element_type.slider,	DayNightDebugSetColorB,			0.5,	[0,1]],
	[Text("Reset"),			menu_element_type.script_runner, DayNightDebugReset],
	//[Text("Save"),			menu_element_type.script_runner, DayNightDebugSaveValues],
	[Text("Back"),			menu_element_type.script_runner, DayNightDebugModeExit]
)


create_menu_page(
	menu_page.enemies,
	[Text("Boss"), menu_element_type.page_transfer,	menu_page.boss],
	[
		Text("Enemies Used"),
		menu_element_type.enemy_toggle,
		0,
		-1
	],
	[Text("All Enemies"), menu_element_type.script_runner,  MenuAllEnemiesOn],
	[Text("Back"),		menu_element_type.page_transfer,	menu_page.debugging]
)

create_menu_page(
	menu_page.boss,
	[Text("Fight Test"), menu_element_type.script_runner, BossFightQuickTest],
	[
		Text("First Element"),	
		menu_element_type.shifter,
		[
			Text("Ice"),
			Text("Fire"),
			Text("Wind"),
			Text("Thunder"),
			Text("Idle")
		],
		global.boss_first_steal_enum,
		BossSetFirstSteal
	],
	[Text("Back"), menu_element_type.page_transfer, menu_page.enemies]
)

#region Alternative Controls Get
var _controls = array_create(3);
for(var i = 0; i < 3; i++)
{
	_controls[i] = global.oPlayer.alternative_controls[i];	
}
#endregion
create_menu_page(
	menu_page.alternative_keys,
	[Text("Interaction"),	menu_element_type.control_input,			chr(_controls[0]),		_controls[0]],
	[Text("Attack"),		menu_element_type.mouse_alternative_input,	chr(_controls[1]),		_controls[1], global.alternative_controls_on],
	[Text("Push"),			menu_element_type.mouse_alternative_input,	chr(_controls[2]),		_controls[2], global.alternative_controls_on],
	[Text("Back"),			menu_element_type.page_transfer,			menu_page.controls]
)

#endregion

#region//Being Logo
x = GUI_BOUND;
y = GUI_BOUND;
var anim_curve = animcurve_get(anc_logo_waving);
logo_anim_channel = animcurve_get_channel(anim_curve,"y");
logo_anim_progress = 0;
logo_anim_speed = 0.008;
#endregion


event_inherited();


