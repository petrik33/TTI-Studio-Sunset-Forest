function PlayerStateAttackInAir(){
	
#region//Controls

#region//Movement Controls
var key_right = ( keyboard_check(vk_right) || keyboard_check(ord("D")) ); 
var key_left = ( keyboard_check(vk_left) || keyboard_check(ord("A")) );
#endregion

#endregion

#region//Movement + Fall down check

movement_direction = key_right - key_left;
EntityMovement();

#region//Check For Falling Down
if(place_meeting(x,y+from_floor_to_jump,pobj_collideable))
{
	PlayerFallDownAfterJump();
	EntityMakeFree();
	ds_list_clear(hit_by_attack);
	current_attack_HB = noone;
}
#endregion

#endregion

PlayerAttackProceed();

#region//End State

if(AnimationEnd())
{
	EntityMakeFree();
	ds_list_clear(hit_by_attack);
	current_attack_HB = noone;
}
#endregion

#region//Animation
if(Vx!=0)
{
	InstanceRotateCentrally(sign(Vx),);
}
#endregion

}