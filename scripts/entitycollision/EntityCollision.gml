function EntityCollision() {
	
var _collided = false;
	
#region//Horizontal
x+=Vx;
#endregion

#region//Vertical
if(Vy!=0)
{
	if(bbox_bottom + Vy >= FLOOR_Y)
	{
		var _offset = ceil(bbox_bottom - y);
		y = FLOOR_Y - _offset;
		_collided = true;
		Vy = 0;
	}
	y+=Vy;
}
#endregion

return _collided;

}

