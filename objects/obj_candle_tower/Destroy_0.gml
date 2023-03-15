event_inherited();

//if(!global.boss_earthquake && !global.boss_fight_on)
//{

//	with(instance_create_layer(x,y,"Candles",obj_candle_tower_blown_off))
//	{
//		image_xscale = other.image_xscale;
//		if(image_xscale == -1)
//		{
//			global.leftCandle = self;	
//		}
//		else
//		{
//			global.rightCandle = self;	
//		}
//		target_y = other.ystart;
//	}

//	EffectCreateReversed(
//		x + candles_fires_x[0],
//		y + candles_fires_y[0],
//		spr_candle_fire_lightup,
//		image_xscale
//	)
	
//}
//else
//{
	EffectCreate(x,y,spr_candle_full_destruction,image_xscale,false);
	if(!blown_off)
	{
		EffectCreateReversed(
			x + candles_fires_x[0],
			y + candles_fires_y[0],
			spr_candle_fire_lightup,
			image_xscale
		)
	}
//}
