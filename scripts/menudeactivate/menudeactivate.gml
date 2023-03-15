//function MenuActivate(false){
//	with(global.oMenu)
//	{
//		menu_active = false;
//		visible = false;
//	}
//}

///@arg on
function MenuActivate(_switch = true){
	with(global.oMenu)
	{
		menu_active = _switch;
		visible = _switch;
	}	
}	