function SkillFireBall() {
	with(instance_create_layer(x+93*other.image_xscale,y-37,"Hero",obj_fire_ball))
	{
		Vx = spd*other.image_xscale;
	}
}
