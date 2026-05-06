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

	//ui controller
	global.active_ui		= "";

	//object destroyer
	if (object_exists(obj_player))
	{
		instance_destroy(obj_player);
	}
}

