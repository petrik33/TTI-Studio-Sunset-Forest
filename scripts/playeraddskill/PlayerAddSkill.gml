///@arg ID
///@arg SCRIPT
///@arg SPRITE
///@arg CAST_DURATION
///@arg COOLDOWN
///@arg HOTKEY
///@arg NAME
///@arg FULL_CAST
///@arg ICON
///@arg RANGE
///@arg SOUNDS
///@arg WALK
///@arg JUMP
function PlayerAddSkill(_id,_script,_sprite,_cast_dur,_CD,_HK,_name,_FC,_icon,_range,_sounds,_walk,_jump){
	skills[_id] = 
	[
		_id,
		_script,
		_sprite,
		FRAME_RATE * _cast_dur,
		FRAME_RATE * _CD,
		_HK,
		_name,
		_FC,
		_icon,
		_range,
		_sounds,
		_walk,
		_jump,
		true,
		0
	]
}