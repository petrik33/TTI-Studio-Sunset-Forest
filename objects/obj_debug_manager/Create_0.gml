#region Data

debug_cutscene = obj_CS_dark_matter_unleash;
portals_blocked = false;

#endregion

debug_bindings = ds_map_create();

function DebugBind(key,bind) {
	ds_map_add(debug_bindings,key,bind);
}

#region Functions

var _debug_portals_block = function () {
	if(!portals_blocked)
	{
		PortalsBlock();
	}
	else
	{
		PortalsUnblock();
	}	
}
var _debug_restart = function () { game_restart(); };
var _debug_cutscene = function () {
	start_cutscene(debug_cutscene);	
}

var _debug_lose = function () {
	instance_destroy(global.oPlayer);	
}

var _debug_switch_gui = function () {
	global.gui_show = !global.gui_show;
	MenuActivate(global.gui_show);
	with(global.oPlayer)
	{
		player_gui_display = global.gui_show;
	}	
	with(global.boss_manager)
	{
		boss_gui_display = global.gui_show;	
	}
	if(instance_exists(obj_time_cycler))
	{
		with(obj_time_cycler)
		{
			clock_enabled = global.gui_show;
		}
	}
	if(!global.gui_show)
	{
		BestiaryButtonHide();
		cursor_sprite = -1;
	}
	else
	{
		if(!ds_queue_empty(global.bestiary_queue)) BestiaryButtonPopUp();
		with(obj_game)
		{
			alarm[0] = cursor_sleep_check_frequency;
		}
	}
	
}

var _spawn_voa = function () {
	with(obj_enemy_portal)
	{
		PortalVoaSpawn();	
	}
}

var _debug_portals_rush_spawn = function () {
	with(obj_enemy_portal)
	{
		if(portal_spawning)
		{
			PortalPrepareForSpawning();
			spawn_cooldown = 0;
		}
	}
}

var _debug_zoom = function () {
	if(global.viewScale == 1)
	{
		CameraZoom(2);
	}
	else
	{
		CameraZoom(1);
	}	
}

var _debug_kill_boss_accumulate = function () {
	if(instance_exists(obj_boss))
	{
		BossDebugKillTotally();
	}
	else
	{
		PlayerAccumulateAllSpecials();
	}
}

var _debug_towers_damage = function () {
	with(pobj_tower)
	{
		EntityDamage(self,0);
		find_hp_relatives();
	}
}

var _debug_boss_fight = function () {
	instance_destroy(obj_enemy_portal);
	with(pobj_enemy)
	{
		DyingScript();	
	}
	cutscene_run(obj_CS_boss_fight);	
}

var _debug_enemies_drop = function () {
	with(pobj_enemy)
	{
		drop_chance = 1;	
	}
}

#endregion

DebugBind(vk_f1,_debug_restart);
DebugBind(vk_f2,_spawn_voa);
DebugBind(vk_f3,_debug_cutscene);
DebugBind(vk_f4,_debug_towers_damage);
DebugBind(vk_f5,_debug_portals_rush_spawn);
DebugBind(vk_f6,_debug_zoom);
DebugBind(vk_f7,_debug_lose);
DebugBind(vk_f8,_debug_enemies_drop);
DebugBind(vk_f9,_debug_boss_fight);
DebugBind(vk_f10,global.MusicSkip);
DebugBind(vk_f11,_debug_switch_gui);
DebugBind(vk_f12,global.SaveGame);

DebugBind(ord("0"),_debug_kill_boss_accumulate);