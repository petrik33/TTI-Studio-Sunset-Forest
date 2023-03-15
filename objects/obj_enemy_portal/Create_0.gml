event_inherited();

#region//Portal Sprites

portal_opened = spr_new_portal;
portal_closed = spr_new_portal_closed;
portal_invoking = spr_new_portal_invoking;
portal_closing = spr_portal_closing;
portal_about_to_spawn = spr_portal_about_to_spawn;
portal_damaged = spr_portal_damaged;

#endregion

#region Portal Sounds

sound_portal_close = sn_portal_teleport;
sound_portal_teleport = sn_portal_teleport;
sound_portal_open = sn_portal_teleport;
sound_portal_spawn = sn_portal_teleport;
sound_portal_hit = sn_portal_damage9_1;

#endregion 

#region//Variables

portal_hp = portal_max_hp;
portal_hp_sprite = spr_enemy_portal_hp;
portal_hp_deaths = [spr_enemy_portal_hp_death1,spr_enemy_portal_hp_death2,spr_enemy_portal_hp_death3];
portal_hp_xoffset = 2;
portal_hp_yoffset = -92;

spawn_time = FRAME_RATE * 18;
spawn_cooldown = spawn_time / 3;
spawn_x_offset = 20;

var spawn_push_time = AnimationGetFrameLength(portal_invoking);
push_range = spawn_push_time * global.oPlayer.spd + 40;

about_to_spawn_offset = FRAME_RATE * 1;

portal_open_time_buffer = FRAME_RATE * 1.5;
portal_opening_timer = portal_open_time_buffer;

portal_spawning = false;

spawn_queue = ds_queue_create();

#endregion

#region Voa Spawn

spawn_voa = false;

voa_spawn_time_range = [FRAME_RATE * 20, FRAME_RATE * 30];
voa_spawn_timer = RangeArrayGetNumber(voa_spawn_time_range,true);

voa_min_distance = 100;
voa_counter = 0;
voa_max_count = 2;

#endregion

#region//Momma Spawn

spawn_momma = false;

momma_spawn_time_range = [FRAME_RATE * 30, FRAME_RATE * 40];
momma_spawn_timer = RangeArrayGetNumber(momma_spawn_time_range,true);

#endregion

#region Flash Particles

#region//Portal Flash
	
var _flash_particle = part_type_create();
part_type_sprite(_flash_particle,spr_portal_flash_particles,false,false,false)
part_type_life(_flash_particle,FRAME_RATE * 0.75, FRAME_RATE * 1.5);

part_type_scale(_flash_particle,1,1);
part_type_size(_flash_particle,0.6,0.8,0,0);
part_type_orientation(_flash_particle,0,360,0,0,true);
part_type_blend(_flash_particle,false);

part_type_alpha3(_flash_particle,1,1,0)

part_type_speed(_flash_particle,1,1.5,-0.008,0);
	
portal_spawn_flash_part = _flash_particle;
	
#endregion
	
#region Momma/Voa Spawn Flash
	
_flash_particle = part_type_create();
part_type_sprite(_flash_particle,spr_momma_voa_spawn_flash_particles,true,true,false)
part_type_life(_flash_particle,FRAME_RATE * 0.75, FRAME_RATE * 1.5);

part_type_scale(_flash_particle,1,1);
part_type_size(_flash_particle,0.6,0.8,0,0);
part_type_orientation(_flash_particle,0,360,0,0,true);
part_type_blend(_flash_particle,false);

part_type_alpha3(_flash_particle,1,1,0)

part_type_speed(_flash_particle,1.5,2,-0.009,0);

	
momma_voa_spawn_flash_part = _flash_particle;
	
#endregion

#endregion
