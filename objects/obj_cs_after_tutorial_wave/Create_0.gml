event_inherited();
scene_info = 
[
	[scene_wait,0.5],
	[scene_make_player_static],
	[scene_wait,0.5],
	[scene_textbox,Text("tutorial wave: finished")],
	[scene_textbox,Text("tutorial wave: preparation")],
	[scene_textbox,Text("tutorial wave: dark matter left")],
	[scene_move_object,global.oPlayer,shrine_x,global.oPlayer.spd],
	[scene_wait,0.25],
	[scene_player_heal_candles_new],
	[scene_heal_instance,global.oPlayer,true,noone],
	[scene_wait,0.5],
	[scene_textbox,Text("tutorial wave: candles healed")],
	[scene_textbox,Text("tutorial wave: more help")],
	[scene_drop_Companion_Soul,companion_soul_drop_x],
	[scene_wait,1.25],
	[scene_textbox,Text("tutorial wave: companion soul")],
	[scene_textbox,Text("tutorial wave: companion egg")],
]
