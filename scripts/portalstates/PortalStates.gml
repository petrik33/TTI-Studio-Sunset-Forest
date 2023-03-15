//function PortalCloseAfterSpawn(){
//	PortalClose();
//}

#region Double Portal Actions

function PortalsStopSpawning(){
	with(obj_enemy_portal)
	{
		PortalStopSpawn();	
	}
}

function PortalsResumeSpawning(){
	with(obj_enemy_portal)
	{
		PortalResumeSpawn();	
	}
}

function PortalsBlock(){
	with(obj_enemy_portal)
	{
		PortalBlock();	
	}
}

function PortalsUnblock(){
	with(obj_enemy_portal)
	{
		PortalUnblock();	
	}
}

#endregion

function PortalStateAfterSpawn(){
	portal_opening_timer++;
	if(portal_opening_timer >= portal_open_time_buffer)
	{
		PortalOpen();
	}
}

function PortalOpen(){
	sprite_index = portal_closing;
	image_index = image_number - 1;
	image_speed = -1;
	state = PortalStateOpening;
	with(another_portal)
	{
		if(state == PortalStateClosed)
		{
			PortalOpen();	
		}
	}
	emitter_sound(sound_portal_open,false);
}

function PortalStateOpening(){
	if(AnimationEndReverse())
	{
		sprite_index = portal_opened;
		image_index = 0;
		image_speed = 1;
		state = PortalStateOpened;
	}
}

function PortalSpawnManagment(){
	if(portal_spawning) spawn_cooldown--;
	if(spawn_cooldown <= about_to_spawn_offset)
	{
		PortalPrepareForSpawning();
	}	
}
	
function PortalStateOpened(){
	PortalSpawnManagment();
	PortalTeleporting();
}

function PortalTeleporting(){
	if(instance_exists(another_portal))
	{
		var in_portal = instance_place(x,y,pobj_moving_entity);
		if(in_portal != noone && sign(in_portal.Vx) == side)
		{
			with(another_portal)
			{
				var _teleport_x = x - SpriteBBoxOffset(in_portal.sprite_index,side * in_portal.image_xscale) * in_portal.image_xscale;
				switch(side)
				{
					case -1:
						
					_teleport_x = max(global.leftEdge + 1,_teleport_x);
						
					break;
						
					case 1:
					
					_teleport_x = min(global.rightEdge - 1,_teleport_x);
						
					break;
				}
			}
			with(in_portal)
			{
				//x = _another_portal_x;
				x = _teleport_x;
					
				if(object_is_ancestor(object_index,pobj_enemy))
				{
					movement_direction *= -1;
				}
				emitter_sound(other.sound_portal_teleport,false);	
			}
		}
	}	
}
	
function PortalPrepareForSpawning(){
	sprite_index = portal_about_to_spawn;
	image_index = 0;
	state = PortalStateAboutToSpawn;
	#region//Prepare The Other Portal
	with(another_portal)
	{
		if(state == PortalStateOpened)
		{
			PortalClose();
		}
	}
	#endregion
}
	
function PortalStateAboutToSpawn(){
	if(portal_spawning) spawn_cooldown--;
	if(spawn_cooldown <= 0)
	{	
		//if(global.tutorial_wave)
		//{
		//	portal_spawning = false;	
		//}
		
		PortalStartInvoking();
		
		#region//Push Entities Out From Portal
		with(pobj_colliding_entity)
		{
			if(abs(x-other.x) < other.push_range)
			{
				EntityPush(self,portal_push_speed,other.image_xscale,portal_push_direction)	
			}
		}
		EffectCreate(x,y,push_effect,image_xscale,false);
	
		#endregion
	}
}
	
function PortalStartInvoking(){
	sprite_index = portal_invoking;
	image_index = 0;
	state = PortalStateInvoking;
}
	
function PortalStateInvoking(){
	if(AnimationEnd())
	{
		PortalSpawn();	
	}
}
	
function PortalClose(){
	portal_opening_timer = 0;
	sprite_index = portal_closing;
	image_index = 0;
	state = PortalStateClosing;
	emitter_sound(sound_portal_close,false);
}

function PortalCloseAfterSpawn() {
	portal_opening_timer = 0;
	sprite_index = portal_closing;
	image_index = 0;
	state = PortalStateClosingAfterSpawn;
	emitter_sound(sound_portal_close,false);
}

function PortalBlock(){
	sprite_index = portal_closing;
	image_index = 0;
	state = PortalStateBlocking;
	emitter_sound(sound_portal_close,false);
	PortalStopSpawn();
}

function PortalStateClosing(){
	if(AnimationEnd())
	{
		sprite_index = portal_closed;
		image_index = 0;
		image_speed = 1;
		state = PortalStateClosed;
	}
}

function PortalStateClosingAfterSpawn(){
	if(AnimationEnd())
	{
		sprite_index = portal_closed;
		image_index = 0;
		image_speed = 1;
		state = PortalStateAfterSpawn;
	}	
}

function PortalStateBlocking(){
	if(AnimationEnd())
	{
		sprite_index = portal_closed;
		image_index = 0;
		image_speed = 1;
		state = PortalStateBlocked;
	}
}

function PortalStateBlocked(){
	//	
}

function PortalStateClosed(){
	PortalSpawnManagment();
}
	
function PortalStateDamaged(){
	if(AnimationEnd())
	{
		PortalBlock();
	}
}

function PortalUnblock(){
	PortalOpen();
	PortalResumeSpawn();
}

function PortalBalanceNextWave() {
	spawn_time *= 0.93;
	spawn_time = round(spawn_time);
}

function PortalUpdateBalance() {
	repeat(portal_max_hp - portal_hp) {
		PortalBalanceNextWave();
	}
}	
	
function PortalReceiveDamage(){
	sprite_index = portal_damaged;
	image_index = 0;
	state = PortalStateDamaged;
	portal_hp--;
	EffectCreateOnTargetOffset(portal_hp_deaths[portal_hp],image_xscale,self,portal_hp_xoffset,portal_hp_yoffset,false);
	if(portal_hp <= 0)
	{
		DyingScript();	
	}
	else
	{
		PortalBalanceNextWave();
		EffectCreateOnTarget(spr_portal_ghost_vfx,image_xscale,self,false);
		emitter_sound(sound_portal_hit,false);	
	}
	//switch(portal_hp)
	//{
	//	case 2:
		
	//	spawn_momma = true;
		
		
	//	break;
		
	//	case 1:
		
	//	spawn_voa = true;
	//	EffectCreateOnTarget(spr_portal_ghost_vfx,image_xscale,self,false);
	//	emitter_sound(sn_portal_hit_PH,false);
		
	//	break;
		
	//	case 0:
		
	//	DyingScript();
		
	//	break;
	//}
}

function PortalStopSpawn(){
	portal_spawning = false;
}

function PortalResumeSpawn(){
	portal_spawning = true;
	if(portal_hp <= 2)
	{
		spawn_voa = true;
		if(portal_hp <= 1)
		{
			spawn_momma = true;	
		}
	}
}

///@arg portal
///@arg enemies
function PortalAddWave(_portal,_enemies){
	var _enemies_num = array_length(_enemies);
	for(var i = 0; i < _enemies_num; i++)
	{
		ds_queue_enqueue(_portal.spawn_queue,_enemies[i]);	
	}
	_portal.previous_size = _enemies_num+1;
}

function PortalsAddTutorialQueue(){
	var _tutorial_enemies = [ENEMIES.SLIME,ENEMIES.KOMAR,ENEMIES.BOHRA,ENEMIES.RUGA,ENEMIES.COLUNA];
	with(obj_enemy_portal)
	{
		ds_queue_clear(spawn_queue);	
	}
	PortalAddWave(global.rightPortal,_tutorial_enemies);
	PortalAddWave(global.leftPortal,_tutorial_enemies);
	//with(_portal)
	//{
	//	global.tutorial_wave = true;
	//	if(side == 1)
	//	{
	//		spawn_cooldown = spawn_time;
	//		portal_spawning = false;	
	//	}
	//	else
	//	{
	//		spawn_cooldown = FRAME_RATE * 8;
	//		portal_spawning = true;
	//	}
	//}
}

function PortalSpawn(){
	
	#region//Choosing Who To Spawn
	
	var spawnID = -1;
		
	if(ds_queue_empty(spawn_queue))
	{
		var _active_list = ds_list_create();
		
		for(var i = 0;i < ENEMIES.VOA; i++)
		{
			if(global.enemies[ENEMY.ACTIVE][i])
			{
				ds_list_add(_active_list,i);	
			}
		}
		
		if(ds_list_empty(_active_list))
		{
			PortalClose();
			exit;
		}
		
		spawnID = ds_list_get_random(_active_list);
		ds_list_destroy(_active_list);		
	}
	else
	{
        spawnID = ds_queue_dequeue(spawn_queue);
	}
		
	var unit = global.enemies[ENEMY.OBJECT][spawnID];
			
	#endregion
		
	with(instance_create_layer(x+image_xscale*spawn_x_offset,y - 10,"Instances",unit))
	{
		movement_direction = other.image_xscale;
		InstanceRotateCentrally(movement_direction);
		if (flying) y = flying_y;
	}
	
	spawn_cooldown = spawn_time;
	if(global.tutorial_wave)
	{
		spawn_cooldown /= 2;	
	}
	
	PortalFlashEffect();
	emitter_sound(sound_portal_spawn,false);
	
	if(global.tutorial_wave)
	{
		PortalStopSpawn();
		with(another_portal)
		{
			PortalResumeSpawn();
		}
		
		if(ds_queue_empty(spawn_queue))
		{
			PortalBlock();
			with(another_portal)
			{
				if(ds_queue_empty(spawn_queue))
				{
					PortalStopSpawn();
					global.last_tutorial_enemy = true;
				}
			}
			return;
		}
	}
	
	PortalCloseAfterSpawn();
}

function PortalFlashEffect(){
	if(!ObjectIsVisible())
	{
		var _flash = FlashNotificationCreate(spr_enemy_spawn_flash_gradient,side,portal_spawn_flash_part);
		
		if(!global.flash_bestiary_opened[FLASH_TYPE.ENEMY_SPAWN])
		{
			BestiaryEnqueue(
				BESTIARY_PAGE_TYPE.FLASH_NOTIFICATION,
				[FLASH_TYPE.ENEMY_SPAWN,Text("Bestiary: Enemy Spawn Flash"),spr_enemy_spawn_flash_gradient,portal_spawn_flash_part,0,FRAME_RATE * 0.75]
			);
			global.flash_bestiary_opened[FLASH_TYPE.ENEMY_SPAWN] = true;
		}
		
		return _flash;
	}
}

function MommaVoaSpawnFlashCreate(){
	if(!ObjectIsVisible())
	{
		var _flash = FlashNotificationCreate(spr_momma_spawn_flash,side,momma_voa_spawn_flash_part);
		
		if(!global.flash_bestiary_opened[FLASH_TYPE.MOMMA_VOA_SPAWN])
		{
			BestiaryEnqueue(
				BESTIARY_PAGE_TYPE.FLASH_NOTIFICATION,
				[FLASH_TYPE.MOMMA_VOA_SPAWN,Text("Bestiary: Momma/Voa Spawn Flash"),spr_enemy_spawn_flash_gradient,momma_voa_spawn_flash_part,0,FRAME_RATE * 0.75]
			);
			global.flash_bestiary_opened[FLASH_TYPE.MOMMA_VOA_SPAWN] = true;
		}
		
		return _flash;
	}
}

function PortalVoaSpawn(){
	
	#region//Counting Spawn X
	do
	{
		switch(side)
		{
			case -1:	
				
			var _spawn_x = irandom_range(spawn_point_left_x+64,shrine_zone_left_x - 270);
				
			break;
				
			case 1:
				
			var _spawn_x = irandom_range(shrine_zone_right_x+270,spawn_point_right_x-64);
				
			break;
		}
				
		var _closest_voa = instance_nearest(x,y,obj_voa);
			
		if(instance_exists(_closest_voa)) var _closest_x = _closest_voa.x;
		else _closest_x = nowhere;
				
	}
	until(abs(_spawn_x - _closest_x) >= voa_min_distance);
					
	#endregion
			
	var _spawn_y = irandom_range(voa_flying_y_min,voa_flying_y_max);
			
	voa_counter++;
			
	var _voa_surged = EntitySurge(spr_voa_surging,obj_voa,_spawn_x,_spawn_y,"Instances",image_xscale,noone);
	
	voa_spawn_timer = RangeArrayGetNumber(voa_spawn_time_range,true);
	
	MommaVoaSpawnFlashCreate();
	
	return _voa_surged;
}

function PortalMommaSpawn(){	
	var _momma_seed = instance_create_layer(x,y,"Effects",obj_momma_seed_new)
	with(_momma_seed)
	{
		Vx = lengthdir_x(5, 90 - 30 * other.image_xscale);
		Vy = lengthdir_y(5, 90 - 30 * other.image_xscale);
	}
	
	momma_spawn_timer = RangeArrayGetNumber(momma_spawn_time_range,true);
	
	MommaVoaSpawnFlashCreate();
	
	return _momma_seed;
}























