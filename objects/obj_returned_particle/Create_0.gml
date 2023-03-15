skill_stolen = -1;
image_speed = 0;
angle_rotating_speed = special_stack_angle_speed;

directional_spd = 4;
//waving_spd = 2.5;
attack_target_instance = global.oPlayer;

waving_animation_progress = 0;
waving_animation_spd = 1 / (FRAME_RATE * 3);
waving_amplitude = 10;
waving_animation_curve = animcurve_get_channel(anc_particle_waving,0);

time_before_return = FRAME_RATE * 1.5;

target_xoffset = SpriteBBoxOffset(spr_player_idle,0);
target_yoffset = SpriteBBoxYOffsetCenter(spr_player_idle,true);

//particle_caught = false;

#region//Particles

particles_colors = [c_aqua,c_red,c_green,c_white];
particles_sprites = [spr_small_ice,spr_small_fire,spr_small_wind,spr_small_thunder];

#region//Spark Particle
spark_particle = part_type_create();

part_type_sprite(spark_particle,spr_default_cross_particle,false,false,false);
part_type_life(spark_particle,FRAME_RATE * 1, FRAME_RATE * 2);

part_type_size(spark_particle,0.75,1.25,0,0);
part_type_orientation(spark_particle,0,360,1,0,false);
part_type_blend(spark_particle,true);

part_type_alpha3(spark_particle,1,1,0)

part_type_direction(spark_particle,0,360,0,0.1);
part_type_speed(spark_particle,0.2,0.8,0,0.01);
part_type_gravity(spark_particle,0.0008,270);

#endregion

#region//Small Particle
small_particle = part_type_create();

part_type_sprite(small_particle,particles_sprites[0],0,0,0);
part_type_life(small_particle,FRAME_RATE * 1, FRAME_RATE * 2);

part_type_scale(small_particle,1,1);
part_type_size(small_particle,1,1,0,0);
part_type_orientation(small_particle,0,360,1,0,false);
part_type_blend(small_particle,true);

part_type_alpha3(small_particle,1,1,0)

part_type_direction(small_particle,0,360,0,0.1);
part_type_speed(small_particle,0.2,0.8,0,0.01);
part_type_gravity(small_particle,0.0008,270);

alarm[0] = 7;

#endregion

#endregion



