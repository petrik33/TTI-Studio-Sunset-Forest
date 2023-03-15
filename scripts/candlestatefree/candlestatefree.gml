function CandleStateFree(){
	if(AttackDefaultBehaviour(attack_struct))
	{
		var _x_offset = candles_fires_x[0];
		var _y_offset = candles_fires_y[0];
		EffectCreateOnTargetOffset(spr_candle_fire_attack_vfx,image_xscale,self,_x_offset,_y_offset,false);	
	}
}

function CandleReceiveDarkMatter(){
	if(blown_off)
	{
		CandleBlowUp();
		//if(image_xscale == -1)
		//{
		//	global.leftCandle = self;	
		//}
		//else
		//{
		//	global.rightCandle = self;	
		//}
		//instance_destroy();
	}
	else
	{
		if(current_hp < max_hp)
		{
			current_hp++;
			find_hp_relatives();
		}
	}
}

function CandleBlowUp(){
	sprite_index = spr_candle_reactivate;
	image_index = 0;
	image_speed = 1;
	state = CandleStateBlowingUp;
	
	blown_off = false;
	
	candles_number = 1;
	
	var anim_time = AnimationGetFrameLength(sprite_index) + 3; // 3 is buffering time
	var fire_sprite = spr_candle_fire_lightup;
	var img_num = sprite_get_number(fire_sprite);
	sprite_set_speed(fire_sprite,img_num/anim_time,spritespeed_framespergameframe);
	
	TowerCreateLight();
	StaticLightUp(anim_time);
	
	CandleFireUpdateSprite(fire_sprite);
	CandleWavingReactivate();
}

function CandleStateBlowingDown(){
	if(AnimationEnd())
	{
		candles_number = 0;
		image_index = image_number - 1;
		image_speed = 0;
		state = CandleStateBlownOff;
	}
}

function CandleStateBlowingUp(){
	current_hp = floor(max_hp * image_index / (image_number - 1));
	find_hp_relatives();
	if(AnimationEnd())
	{
		sprite_index = spr_candle_active;
		image_index = 0;
		state = CandleStateFree;
		blown_off = false;
		current_hp = max_hp;
		CandleFireUpdateSprite(spr_candle_fire);
	}
}

function CandleStateBlownOff(){
	//	
}
	
function TowerFlash(_time,_color){
	flash = true;
	flash_progress = 0;
	flash_spd = 1 / _time;
	var _R = color_get_red(_color) / 255;
	var _G = color_get_green(_color) / 255;
	var _B = color_get_blue(_color) / 255;
	flash_color = [_R,_G,_B];
}
