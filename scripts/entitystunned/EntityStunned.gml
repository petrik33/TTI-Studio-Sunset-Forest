function EntityStunned(){
	var _grounded = (FLOOR_Y - y <= 1);
	if(!_grounded) Vy += _gravity;
	EntityCollision();
}