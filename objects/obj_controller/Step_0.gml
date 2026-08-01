if (language != global.language)
{
    load_language(global.language);
    language    = global.language;
}

if (global.paused)
{
	exit;
}

var _has_player     = instance_exists(obj_player);

if (!_has_player && global.started)
{
	global.player	= instance_create_layer(768, 750, "Instances", obj_player);

	global.grid_properties 	= set_grid_properties(32, [obj_wall, obj_platform], [obj_slope]);
	global.grid_properties.create_grid();

	global.grid 			= variable_clone(global.grid_properties);
	global.original_grid 	= variable_clone(global.grid);

	global.path_queue 		= ds_priority_create();
}

if (global.started)
{
	object_cleaner();
  	path_tracker();
  	enemy_spawner();
  	roll_cards();
}

if (instance_exists(obj_player) && global.player.data.stats.life <= 0 && !global.paused)
{
	game_over_delay_timer++;

	if (game_over_delay_timer >= ui_game_over_delay)
	{
		global.last_layer		= "ui_game_over";

		layer_set_visible("ui_game_over", true);
		game_over_delay_timer 	= 0;
		global.paused			= true;		
	}
}

update_fps++;