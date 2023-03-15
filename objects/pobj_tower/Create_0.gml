#region//HP and Other
current_hp = max_hp;
damage_recieved = false;
damage_vulnerable = true;
hp_image_index = 0;
hp_image_speed = sprite_get_speed(sprite_hp) / FRAME_RATE;
hp_image_number = sprite_get_number(sprite_hp);
my_emitter = emitter_create();
sprite_idle = sprite_index;

hp_relative_posistions = array_create(max_hp);

find_hp_relatives = function(){
	for(var i = 0;i<current_hp;i++)
	{
		var angle_to_tower = 180/(current_hp+1) * (i+1);
		var _xx = lengthdir_x(hp_distance_to_tower,angle_to_tower);
		var _yy = lengthdir_y(hp_distance_to_tower,angle_to_tower);
		hp_relative_posistions[i] = [_xx,_yy];
	}
}

find_hp_relatives();

blown_off = false;

#endregion

function TowerCreateLight(){
	if(!instance_exists(light_instance))
	{
		if(light_sprite!=noone)
		{
			if(blinking_light)
			{
				light_instance = instance_create_layer(x,y - hp_center_y_offset,"Effects",pobj_blinking_light)
			}
			else
			{
				light_instance = instance_create_layer(x,y - hp_center_y_offset,"Effects",pobj_static_light)
			}
			with(light_instance)
			{
				sprite_index = other.light_sprite;
				image_xscale = other.image_xscale;
			}
			StaticLightUp();
		}
		else
		{
			light_instance = noone;	
		}
	}
}

light_instance = noone;

TowerCreateLight();
StaticLightUp();

#region//Shrine Candle Fires

//Align To The x_offset
for(var i = 0;i<candles_number;i++)
{
	candles_fires_x[i] *= sign(image_xscale);
	candles_fires_x[i] -= sprite_xoffset;
	candles_fires_y[i] -= (sprite_yoffset + candle_fire_distance);
}

candles_jitterings = array_create(candles_number,0);
candles_animation_progress = 0;
candles_animation_speed = sprite_get_speed(candle_sprite)/FRAME_RATE;
candles_image_number = sprite_get_number(candle_sprite);

for(var i = 1;i<candles_number;i++)
{
	candles_jitterings[i] = random(candles_image_number);
}

#endregion

#region//Step Sound
if(step_sound_resource!=noone)
{
	step_sound = emitter_sound(step_sound_resource,true);
}
#endregion

#region Candle Damaged Flash Particle
	
var _flash_particle = part_type_create();
part_type_sprite(_flash_particle,spr_candle_damaged_flash_particles,true,true,false)
part_type_life(_flash_particle,FRAME_RATE * 1.5, FRAME_RATE * 2.5);

part_type_scale(_flash_particle,1,1);
part_type_size(_flash_particle,0.8,1,0,0);
part_type_orientation(_flash_particle,0,360,0,0,true);
part_type_blend(_flash_particle,false);

part_type_alpha3(_flash_particle,1,1,0)

part_type_speed(_flash_particle,1.5,2,-0.008,0);
part_type_gravity(_flash_particle,0.03,270);
	
shrine_candle_damaged_flash_part = _flash_particle;
	
#endregion

flash_shader = sh_flash;
flash = false;
flash_color = [1,1,1];
flash_spd = 0;
flash_progress = 0;
u_flashColor = shader_get_uniform(sh_flash,"flash_color");

