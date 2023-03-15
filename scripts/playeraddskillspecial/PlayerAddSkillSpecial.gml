///@arg ID
///@arg SCRIPT
///@arg SPRITE
///@arg CAST_DURATION
///@arg COOLDOWN
///@arg FULL_CAST
///@arg ICON
///@arg RANGE
///@arg SOUNDS
///@arg WALK
///@arg JUMP
function PlayerAddSkillSpecial(_id,_script,_sprite,_cast_dur,_CD,_FC,_icon,_range,_sounds,_walk,_jump){
	special_skills[_id] = 
	[
		_id,
		_script,
		_sprite,
		FRAME_RATE * _cast_dur,
		FRAME_RATE * _CD,
		-1,
		-1,
		_FC,
		_icon,
		_range,
		_sounds,
		_walk,
		_jump
	]
}