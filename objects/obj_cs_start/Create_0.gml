event_inherited();
scene_info =
[
	[scene_textbox,Text("start: after illustrations")],
	[scene_textbox,Text("start: main goal")],
	[scene_textbox,Text("start: balance")],
	[scene_textbox,Text("start: dark matter")],
	[
		scene_create_effect,
		global.oPlayer.x,	
		global.oPlayer.y - global.oPlayer.view_y_offset - global.oPlayer.worry_y_offset,
		global.oPlayer.worry_sprite,
		global.oPlayer.image_xscale,
		false
	],
	[scene_wait,1],
	
	[scene_stop_forest_ambient,true,fade_time.fast],
	[scene_camera_shake,15,45],
	[scene_play_audio,sn_earthquake_cutscene8_1,[MIN_PITCH_DEFT,MAX_PITCH_DEFT],MAX_GAIN_DEFT * 1.25],
	
	[scene_textbox,Text("start: no more time")],
	[scene_change_camera_state,CameraStateStatic],
	[scene_camera_move,spawn_point_right_x,CAMERA_Y,CAMERA_CS_SPD],
	[scene_wait,0.4],
	[scene_create_object,spawn_point_right_x,FLOOR_Y - spawn_point_y,"Effects",obj_portal_creation],
	[scene_wait,1.5],
	[scene_textbox,Text("start: portal appeared")],
	[scene_camera_move,spawn_point_left_x,CAMERA_Y,CAMERA_CS_SPD],
	[scene_wait,0.4],
	[scene_create_object,spawn_point_left_x,FLOOR_Y - spawn_point_y,"Effects",obj_portal_creation],
	[scene_wait,1.5],
	[scene_textbox,Text("start: one more")],
	[scene_textbox,Text("start: text over")]
]
