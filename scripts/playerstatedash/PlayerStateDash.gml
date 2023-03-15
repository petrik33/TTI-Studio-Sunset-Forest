function PlayerStateDash(){
	//Vy += _gravity;
	EntityCollision();
	PlayerGatherBufferInput();
	if(dash_type == dash_types.forward && image_index < dash_attack_max_frame)
	{
		if(input_buffered = input_buffer_type.attack)
		{
			PlayerAttackInDash();
			input_buffered = noone;
		}
	}
	
	//#region//Jumping
	
	//var key_jump = keyboard_check_pressed(vk_space);
	
	//if(jumped && y >= FLOOR_Y - 1)
	//{
	//	PlayerFallDownAfterJump();	
	//}
	
	//if(key_jump && !jumped)
	//{
	//	PlayerJump();
	//}
	
	//#endregion
	
	var _decceleration = dash_decceleration[dash_type];
	
	Vx -= _decceleration * sign(Vx);
	if(abs(Vx) <= _decceleration)
	{
		Vx = 0; 
		EntityMakeFree();
		exit;
	}
}