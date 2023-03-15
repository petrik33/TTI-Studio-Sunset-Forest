///@arg file
function SaveEnemiesData(_file){
	var _map_to_save = ds_map_create();
	for(var k = 0; k < ENEMIES.VOA; k ++)
	{
		var _key = global.enemies[ENEMY.NAME][k];
		var _value = global.enemies[ENEMY.ACTIVE][k];
		ds_map_add(_map_to_save,_key,_value);
	}
	DS_MapSaveToJSON(_map_to_save,_file);
	ds_map_destroy(_map_to_save);
}