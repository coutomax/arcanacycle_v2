toggle		= true;
display_w 	= display_get_width();
display_h 	= display_get_height();

update_fps  = 0;
actual_fps  = fps_real;

respawn_timer 	= 0;

max_paths 		= 4;

game_set_speed(60, gamespeed_fps);
show_debug_overlay(false);

display_set_gui_size(1920, 1080);
gpu_set_texfilter(false);

surface_resize(application_surface, 1920, 1080);
//show_debug_overlay(true);

object_cleaner = function ()
{
	if (array_length(global.objects_list) > 50)
	{
		instance_destroy(global.objects_list[0]);
		array_delete(global.objects_list, 0, 1);
	}
}

path_tracker = function()
{
    if (ds_priority_empty(global.path_queue)) exit;  

	var _paths 	= 0;

    while (!ds_priority_empty(global.path_queue))
    {
        if (_paths >= max_paths) break;
        _paths++;

        var _enemy_id = ds_priority_delete_min(global.path_queue);

        
    }
}

enemy_spawner = function ()
{
	respawn_timer++;
	if (instance_number(obj_wasp) > 4) return;
	if (!global.started) return;
	if (respawn_timer < 30) return;

	var _random_x 	= 0;
	var _random_y 	= irandom_range(-150, 0);

	if (choose(true, false))
	{
		_random_x 	= irandom_range(-150, 0);
	}
	else
	{
		_random_x 	= irandom_range(display_w, display_w + 150);
	}

	var _enemy 	= instance_create_layer(_random_x, _random_y, "Instances", obj_wasp);
	respawn_timer = 0;
}