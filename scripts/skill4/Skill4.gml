function Skill4() {
	//Find Instances in range
	var skill_range = skill_4_range;
	var in_range = ds_list_create();
	var hits = 0;
	with(pobj_hitable)
	{
		if( (x < other.x + skill_range) && (x > other.x - skill_range) )
		{
			ds_list_add(in_range,self);
			hits++;
		}
	}
	for(var i = 0;i<hits;i++)
	{
		var _inst = in_range[| i];
		PlayerThunderHit(_inst);
	}
	ds_list_destroy(in_range)
}

///@arg inst
///@arg anim_spd
function PlayerThunderHit(_inst,_anim_spd = 1){
	var _lightning = instance_create_layer(_inst.x,_inst.bbox_top,"Effects",obj_stunning_lightning);
	with(_lightning)
	{
		image_speed = _anim_spd;
		target = _inst;	
		movement_dir_buffer = _inst.movement_direction;
	}
	with(_inst)
	{
		movement_direction = 0;
		Vx = 0;
	}
	return _lightning;
}
