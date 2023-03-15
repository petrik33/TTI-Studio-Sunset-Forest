function EnemyDropDarkMatterParticle(){
	if(instance_exists(global.oPlayer))
	{
		for(var i = 0;i < max_hp;i++)
		{
			var _x = irandom_range(bbox_left,bbox_right);
			var _y = irandom_range(bbox_top,bbox_bottom);
			instance_create_layer(_x,_y,"Effects",obj_dark_matter_particle);
		}
	}
}