///@arg enemy
function BestiaryOpenEnemy(_enemy_id){
	global.bestiary = instance_create_layer(0,0,"GUI",obj_enemy_bestiary);
	BestiaryChangeEnemy(_enemy_id);
}

function BestiaryOpen_HP_DM_tutorial(){
	global.bestiary = instance_create_layer(0,0,"GUI",obj_HP_DM_tutorial_bestiary);
}

function BestiaryClear(){
	ds_queue_clear(global.bestiary_queue);
	BestiaryButtonHide();
}

///@arg text
function BestiaryOpenText(_text){
	global.bestiary = instance_create_layer(0,0,"GUI",pobj_text_bestiary);
	with(global.bestiary)
	{
		bestiary_text = _text;	
	}
}

function BestiaryOpenFlashNotification(_enum,_text,_sprite,_particle,_particle_direction,_time)
{
	global.bestiary = instance_create_layer(0,0,"GUI",pobj_flash_notification_bestiary);
	with(global.bestiary)
	{
		bestiary_text = _text;
		flash_sprite = _sprite;
		flash_particle = _particle;
		flash_part_direction = _particle_direction;
		flash_time = _time;
	}
}

///@arg page_info
function BestiaryOpenPage(_page_info){
	switch(_page_info[0])
	{
		case BESTIARY_PAGE_TYPE.ENEMY:
			
		BestiaryOpenEnemy(_page_info[1]);
		
		break;
		
		case BESTIARY_PAGE_TYPE.HP_DM_TUTORIAL:
			
		BestiaryOpen_HP_DM_tutorial();
		
		break;
		
		case BESTIARY_PAGE_TYPE.TEXT:
		
		BestiaryOpenText(_page_info[1]);
		
		break;
		
		case BESTIARY_PAGE_TYPE.FLASH_NOTIFICATION:
		
		BestiaryOpenFlashNotification(_page_info[1][0],_page_info[1][1],_page_info[1][2],_page_info[1][3],_page_info[1][4],_page_info[1][5]);
		
		break;
	}	
}

///@arg page_info
function BestiaryChangePage(_page_info){
	if(instance_exists(global.bestiary))
	{
		instance_destroy(global.bestiary);
		PlayerSoundMake(sn_beastiary_next_page8_1);
		BestiaryOpenPage(_page_info);
		with(global.bestiary)
		{
			lerp_progress = 1;
			alpha_spd *= 2;
		}
	}
}

function BestiaryOpen(_page_info = noone){
	if(global.pause_available)
	{
		if(instance_exists(pobj_bestiary))
		{
			instance_destroy(pobj_bestiary);	
		}
		BestiaryButtonHide();	
		StopGame();
		MenuActivate(false);
		PlayerSoundMake(sn_beastiary_open8_1);
		var _queue_info = ds_queue_dequeue(global.bestiary_queue);
		BestiaryOpenPage(_queue_info);
	}
}

///@arg enemy
function BestiaryEnemyOpenFromMenu(_enemy){
	MenuActivate(false);
	PlayerSoundMake(sn_beastiary_open8_1);
	BestiaryOpenEnemy(_enemy);
	global.enemies[ENEMY.BESTIARY_OPENED][_enemy] = true;
	cursored_portrait_anim_counter = 0;
	inputing_buffer = -1;
	control_input_alpha_shift = 0;
	input_waving_progress = arcsin(0.5);	
}

function BestiaryButtonPopUp(){
	if(!global.gui_show) return;
	if(!instance_exists(obj_bestiary_button))
	{
		instance_create_layer(GUI_BOUND,GUI_BOUND,"GUI",obj_bestiary_button);
	}
	PlayerSoundMake(sn_beastiary_open8_1);
}

///@arg page_type
///@arg data* enemy_id/text
function BestiaryEnqueue(_page_type,_data = -1) {
	BestiaryButtonPopUp();
	ds_queue_enqueue(global.bestiary_queue,[_page_type,_data]);
}



function BestiaryButtonHide(){
	if(instance_exists(obj_bestiary_button))
	{
		instance_destroy(obj_bestiary_button);
		return true;
	}
	return false;
}

function BestiaryClose(){
	instance_destroy(global.bestiary);
	if(!instance_exists(global.oMenu))
	{
		ContinueGame();
	}
	else
	{
		MenuActivate();	
	}
}

///@arg enemy
function BestiaryChangeEnemy(_enemy_id){
	with(global.bestiary)
	{
		sprite_enemy_idle = global.enemies[ENEMY.IDLE][_enemy_id];
		enemy_idle_spr_spd = sprite_get_speed(sprite_enemy_idle) / FRAME_RATE;
		enemy_idle_spr_img_prog = 0;
		enemy_idle_spr_img_num = sprite_get_number(sprite_enemy_idle) - 1;

		enemy_hp_image = 0;
		if(_enemy_id == ENEMIES.DOUHTA)
		{
			enemy_hp_image = 1;	
		}

		//var _spr_height = sprite_get_height(sprite_enemy_idle);
		var enemy_idle_y_offset = -SpriteBBoxYOffsetCenter(sprite_enemy_idle,false);

		sprite_enemy_portrait = global.enemies[ENEMY.PORTRAIT][_enemy_id];
		idle_asset_y = circle_asset_y + enemy_idle_y_offset;
		enemy_hp = global.enemies[ENEMY.MAX_HP][_enemy_id];

		var _enemy_name = global.enemies[ENEMY.NAME][_enemy_id];
		title_string = Text(_enemy_name);

		page_text[ENEMY_BESTIARY_TEXT.ABOUT] = Text(("enemy about: " + _enemy_name));
		page_text[ENEMY_BESTIARY_TEXT.NAME] = Text(("enemy name: " + _enemy_name));
		page_text[ENEMY_BESTIARY_TEXT.TACTICS] = Text(("enemy tactic: " + _enemy_name));

	}
	
}