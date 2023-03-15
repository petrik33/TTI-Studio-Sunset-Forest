function PauseMenuControlsSetDefault(){
	var alternative_controls_page = menu_pages[@ menu_page.alternative_keys];
	var skills_controls_page = menu_pages[@ menu_page.skills_controls];
	
	//Change Skills
	for(var i=0;i<=SKILLS.THUNDER;i++)
	{
		var _control_element = skills_controls_page[@ i];
		_control_element[@ menu_element.current_value] = global.default_skill_controls[i];
		_control_element[@ menu_element.first_entry] = chr(global.default_skill_controls[i]);
	}
	
	global.alternative_controls_on = false;
	var _controls_page = menu_pages[@ menu_page.controls];
	_controls_page[@ (alternative_keys_element - 1)][@ menu_element.current_value] = false;
	_controls_page[@ alternative_keys_element][@ menu_element.current_value] = false;
	
	for(var k=0;k<=alternative_key.push;k++)
	{
		var _control_element = alternative_controls_page[@ k];	
		_control_element[@ menu_element.current_value] = global.default_alternative_controls[k];
		_control_element[@ menu_element.first_entry] = chr(global.default_alternative_controls[k]);
		if(k>0) _control_element[@ menu_element.value_range] = false;
		
	}
}
	
function PauseMenuSoundsOff(){
	menu_pages[menu_page.audio][0][menu_element.current_value] = 0;
	menu_pages[menu_page.audio][1][menu_element.current_value] = 0;
	ChangeSoundsVolume(0);
	ChangeMusicVolume(0);
}

function PauseMenuSoundsFull(){
	menu_pages[menu_page.audio][0][menu_element.current_value] = 1 * menu_pages[menu_page.audio][0][menu_element.value_factor];
	menu_pages[menu_page.audio][1][menu_element.current_value] = 1 * menu_pages[menu_page.audio][1][menu_element.value_factor];
	ChangeSoundsVolume(1);
	ChangeMusicVolume(1);
}