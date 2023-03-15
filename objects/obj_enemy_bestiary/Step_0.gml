event_inherited();

if(lerp_progress == 1)
{
	var _mouse_gui_x = device_mouse_x_to_gui(0);
	var _mouse_gui_y = device_mouse_y_to_gui(0);

	var _dist = point_distance(_mouse_gui_x,_mouse_gui_y,circle_asset_x,circle_asset_y);
	if(_dist <= circle_asset_R)
	{
		enemy_idle_spr_img_prog += enemy_idle_spr_spd;
		if(enemy_idle_spr_img_prog >= enemy_idle_spr_img_num)  enemy_idle_spr_img_prog %= enemy_idle_spr_img_num;
	}
}