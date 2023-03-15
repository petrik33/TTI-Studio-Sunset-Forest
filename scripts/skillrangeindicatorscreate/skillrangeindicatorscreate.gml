///@arg time
function SkillRangeIndicatorsCreate(_time){
	
	if(player_gui_display)
	{
		if(current_skill[SKILL.RANGE] != noone)
		{
			var _xpos_offset = current_skill[SKILL.RANGE][0];
			var _range = current_skill[SKILL.RANGE][1];
		
			var _xoffset1 = _xpos_offset - _range;
			var _xoffset2 = _xpos_offset + _range;
	
			with(instance_create_layer(x + _xoffset1 * image_xscale,FLOOR_Y,"GUI",obj_skill_range_indicator))
			{
				x_offset = _xoffset1;
				image_xscale = other.image_xscale;
				alarm[0] = _time;
			}
	
			with(instance_create_layer(x + _xoffset2 * image_xscale,FLOOR_Y,"GUI",obj_skill_range_indicator))
			{
				x_offset = _xoffset2;
				image_xscale = -other.image_xscale;	
				alarm[0] = _time;
			}
		}
	}
}