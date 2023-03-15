function SkillWind(){
	//var _wave = instance_create_layer(
	//x+wind_skill_x_offset*image_xscale,
	//y+wind_skill_y_offset,
	//"Effects",
	//obj_wind_wave);
	//with(_wave) image_xscale = other.image_xscale;
	//return _wave;
	BulletShoot(self,wind_skill_x_offset,wind_skill_y_offset,obj_wind_wave);
}