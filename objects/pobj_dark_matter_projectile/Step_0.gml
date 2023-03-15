x+=spd * image_xscale;
BulletAttachedLightUpdate();

var _enemy_hit = instance_place(x,y,pobj_enemy);
if(_enemy_hit!=noone)
{
	if(hit_effect != noone)
	{
		EffectCreateOnTarget(spr_dark_projectile_hit,image_xscale,_enemy_hit,false);
	}
	with(_enemy_hit)
	{
		drop_matter = false;
		DyingScript();
	}
}

var _portal_hit = instance_place(x,y,obj_enemy_portal);
if(_portal_hit!=noone)
{
	if(_portal_hit != origin_portal)
	{
		if(original)
		{
			var _portal_y_center = (_portal_hit.bbox_bottom + _portal_hit.bbox_top) / 2;
			with(instance_create_layer(_portal_hit.x,_portal_y_center,"Effects",obj_dark_matter_stream))
			{
				image_xscale = -other.image_xscale;
				origin_portal = _portal_hit;
			}
		}
		if(hit_effect != noone)
		{
			EffectCreateOnTarget(spr_dark_projectile_hit,image_xscale,_portal_hit,false);
		}
		current_scene_proceed();
		with(_portal_hit) PortalReceiveDamage();
		instance_destroy();
	}
}
