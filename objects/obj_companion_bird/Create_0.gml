event_inherited();

//Ranged Attack Set Up
attack_struct = new AttackRanged(
self,
spr_companion_bird_attack,
0.8,
3,
1,
pobj_hitable,
233,
noone,
true,
1,
obj_birds_bullet,
200,
0,
12,
false,
0
);

wave_anim_prog = 0;
wave_y_range = 15;
wave_anim_spd = (double_pi) / (FRAME_RATE * 1.5);
