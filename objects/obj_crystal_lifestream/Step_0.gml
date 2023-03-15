// Inherit the parent event
event_inherited();

Vy += _gravity;
image_angle = point_direction(0,0,Vx,Vy);
if(EntityCollision())
{
	instance_destroy();
}
