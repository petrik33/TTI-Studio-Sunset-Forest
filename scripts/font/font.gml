///@arg font
function Font(font){
	if(global.language == LANGUAGE.RUS)
	{
		return (global.font_alternatives_ru[? font] ?? font);
	}
	return font;
}