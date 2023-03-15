///@arg Enum_ID
///@arg ["Name",type,entry]
///@arg ["Name",type,entry]
///@arg ...
function create_menu_page(){
	var page_array = array_create(argument_count - 1);
	
	for(var i = 1;i<argument_count;i++)
	{
		var element_array = argument[i];
		page_array[(i-1)] = element_array
		
	}
	
	//Fill The page in
	menu_pages[@ argument[0]] = page_array;
}