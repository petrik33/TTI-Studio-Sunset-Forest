function PlayerLoadControls(){
	var controls_map = DS_MapLoadFromJSON(global.controls_file);
	
	//Skills Controls
	for(var i = 0;i<SKILLS.NUMBER;i++)
	{
		with(global.oPlayer)
		{
			var control_name = skills[i][SKILL.NAME];
			var _new_control = controls_map[? control_name];
			skills[@ i][@ SKILL.HOTKEY] = _new_control;	
		}
	}
	
	global.alternative_controls_on = controls_map[? "Alternative Toggle"];
	
	//Alternative Controls
	if(global.alternative_controls_on)
	{
		with(global.oPlayer)
		{
			alternative_controls[alternative_key.attack] = controls_map[? "Attack"];
			alternative_controls[alternative_key.push] = controls_map[? "Push"];
			alternative_controls[alternative_key.interaction] = controls_map[? "Interaction"];
		}
	}	
}