function LoadEnemiesData(_file)
{
	var _loaded_map = DS_MapLoadFromJSON(_file);
	for(var k = 0; k < ENEMIES.VOA; k++)
	{
		var _name = global.enemies[ENEMY.NAME][k];
		global.enemies[ENEMY.ACTIVE][k] = _loaded_map[? _name];	
	}
	ds_map_destroy(_loaded_map);
}