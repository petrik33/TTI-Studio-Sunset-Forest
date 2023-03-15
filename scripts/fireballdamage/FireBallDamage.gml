///@arg inst
///@arg xscale
///@arg magical
function FireBallDamage(_inst,_img_xscale,_magical){
	EntityDamage(_inst,_img_xscale,_magical);
	PlayerSpecialAddProgress(SKILLS.FIRE_BALL);
}