enum LANGUAGE
{
	ENG = 0,
	RUS,
	POR
}

function InitializeTranslations(){
	global.localData = load_csv("Localization.csv");
	
	var _height = ds_grid_height(global.localData);
	var _translations = ds_map_create();
	
	for(var i = 0; i <_height; i++)
	{
		ds_map_add(_translations, global.localData[# 0,i], i);
	}
	
	global.translations = _translations;
}

InitializeTranslations();

///@arg key
///@arg number?
function Text(key){
	var _text = "";
	
	if(global.translations[? key] != undefined)
	{
		var _text = global.localData[# (global.language+1), global.translations[? key]];
		
		var _num = argument_count > 1 ? argument[1] : "";
		_text = string_replace_all(_text,"{a}", _num);
		_text = string_replace_all(_text,"\\n","\n");
	}
	else
	{
		var _text = key;	
	}
	
	return _text;
}

///@arg text
///@arg language
///@arg number
function TextTranslate(_text,_language){
	for(var i = 0;i<ds_grid_height(global.localData);i++)
	{
		if(global.localData[# (global.language+1),i] == _text)
		{
			_text = global.localData[# (_language), i];	
		}
	}
	
	var _num = argument_count > 2 ? argument[2] : "";
	_text = string_replace_all(_text,"{a}", _num);
	_text = string_replace_all(_text,"\\n","\n");
	
	return _text;	
}