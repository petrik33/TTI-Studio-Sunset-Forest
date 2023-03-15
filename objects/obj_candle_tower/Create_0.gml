event_inherited();

//if(image_xscale == -1)
//{
//	global.leftCandle = self;	
//}
//else
//{
//	global.rightCandle = self;	
//}

var anim_curve = animcurve_get(anc_candle_waving);
waving_channel = animcurve_get_channel(anim_curve,0);
waving_free_amplitude = 8;
waving_amplitude = waving_free_amplitude;
animation_progress = 0;
candle_waving_free_anim_spd = 0.008;
candle_waving_blow_up_down_spd = 1 / (FRAME_RATE * 2);
animation_speed = 0.008;
candle_waving_state = CandleWavingStateFree;

damaged_animation_progress = 0;
damaged_animation_speed = sprite_get_speed(sprite_damaged)/sprite_get_number(sprite_damaged)/FRAME_RATE;

var anim_curve = animcurve_get(anc_candle_damaged);
damaged_channel = animcurve_get_channel(anim_curve,0);

state_free = CandleStateFree;
state = state_free;


//Attack Create
attack_struct = new AttackRanged(
self,
spr_candle_attack,
noone,
6,
1,
pobj_enemy,
270,
noone,
true,
1,
obj_tower_bullet,
10,
0,
-202,
false,
0
);





