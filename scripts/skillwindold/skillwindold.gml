function SkillWindOld() {
	var skill_range = skill_wind_range;
	var _inst_list = ds_list_create();
	
	#region//Push entities
	var instances_in_range = 0;
	with(pobj_colliding_entity)
	{
		if(abs(x - other.x) < skill_range && other.id!=self.id)
		{
			ds_list_add(_inst_list,self);	
			instances_in_range++;
		}
	}
	for(var i = 0;i<instances_in_range;i++)
	{
		with(_inst_list[| i])
		{
			if(object_is_ancestor(object_index,pobj_alive_entity))
			{
				EntityPush(self,7,sign(x-other.x),30);
			}
			else
			{
				//Pushing Bullets
				Vx += lengthdir_x(15,30) * sign(x-other.x);
				Vy -= 2;
			}
				
		}
	}
	ds_list_destroy(_inst_list);
	#endregion
	
	#region//Leaves Effect
	EffectCreate(x,y,spr_leaves,image_xscale,false);
	#endregion

}
