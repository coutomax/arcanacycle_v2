/*

						RESETA TODAS AS VIARIÁVEIS GLOBAIS

*/

function scr_reset()
{
	//booleanos
	global.new_game			= true;
	global.paused			= false;
	global.in_game			= false;

	//numerics
	global.gravity			= .25;
	global.max_gravity		= 8;
	global.max_life			= 100;
	global.life				= 100;
	global.wave				= 1;
	global.enemies			= 1;
	global.max_enemies		= 1;

	//multiplicadores
	global.life_multiplier			= 1;
	global.enemy_life_multiplier	= 1;

	//ui controller
	global.active_ui		= "";

	//object destroyer
	if (object_exists(obj_player))
	{
		instance_destroy(obj_player);
	}
}

