current_companion = COMPANION.plant;//0
dirt_effect = noone;

#region//Audio

entered_ground = false;
my_emitter = emitter_create();

#endregion

#region//Sprites
sprites_idle = [spr_plant_soul_idle,spr_bird_soul_idle];
sprites_reactivating = [spr_plant_soul_reactivating,spr_bird_soul_reactivating];
sprites_dead = [spr_plant_soul_dead,spr_bird_soul_dead];
sprites_death = [spr_plant_soul_destruction,spr_bird_soul_destruction];
#endregion

#region//Seeds
seeds_objects = [obj_plant_seed,obj_flying_companion_seed];
seeds_surging_sprites = [spr_plant_seed_surging,spr_flying_companion_seed_surging];
//seeds_objects = [obj_plant_seed];
//seeds_surging_sprites = [spr_plant_seed_surging,spr_flying_companion_seed_surging];
#endregion

#region//Physics
angle_speed = (double_pi) / (FRAME_RATE * 1);
spd = 4;

_gravity = 3;
underground_gravity = 1;
#endregion

#region//Target Point
var _range_from_edge = 128;
var _companion_seeds_spawn_range_left = [spawn_point_left_x + _range_from_edge, shrine_zone_left_x - _range_from_edge ];
var _companion_seeds_spawn_range_right = [shrine_zone_right_x + _range_from_edge , spawn_point_right_x - _range_from_edge ];
companion_seeds_spawn_range = [_companion_seeds_spawn_range_left,_companion_seeds_spawn_range_right];
target_x = RangeArrayGetNumber(companion_seeds_spawn_range[irandom(1)],true);
#endregion

#region//Behaviour
state = CompanionSoulDead;

reactivate_y = FLOOR_Y + 96;
curved_movement_distance = reactivate_y - FLOOR_Y;

#endregion

#region Sounds

soul_drop_sound = [sn_plant_soul_drop,sn_bird_soul_drop];
sound_death = sn_comp_soul_death;

#endregion
