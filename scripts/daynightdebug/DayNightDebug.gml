function DayNightDebugSetContrast(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.CON_SAT_BRT_ID][CON_SAT_BRT.contrast] = _value;
	}
}

function DayNightDebugSetBrightness(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.CON_SAT_BRT_ID][CON_SAT_BRT.brightness] = _value;
	}
}

function DayNightDebugSetSaturation(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.CON_SAT_BRT_ID][CON_SAT_BRT.saturation] = _value;
	}
}

function DayNightDebugSetPopStrength(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.CON_SAT_BRT_ID][CON_SAT_BRT.popStrength] = _value;
	}
}

function DayNightDebugSetPopThreshold(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.CON_SAT_BRT_ID][CON_SAT_BRT.popThreshold] = _value;
	}
}

function DayNightDebugSetColorR(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.COLORS_ID][COLOR_MIX.colorR] = _value;
	}
}

function DayNightDebugSetColorG(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.COLORS_ID][COLOR_MIX.colorG] = _value;
	}
}

function DayNightDebugSetColorB(_value){
	with(global.time_cycler)
	{
		var _id = global.day_night_debug_current_point;
		shader_values[_id][DAY_NIGHT_SHADER.COLORS_ID][COLOR_MIX.colorB] = _value;
	}
}




