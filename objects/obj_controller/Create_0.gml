toggle		= true;
display_w 	= display_get_width();
display_h 	= display_get_height();

gpu_set_texfilter(false);

game_set_speed(60, gamespeed_fps);
show_debug_overlay(false);
window_set_size(display_w, display_h-76);
window_set_fullscreen(false);
//call_later(2, time_source_units_frames, window_center);

function object_cleaner ()
{
	if (array_length(global.objects_list) > 50)
	{
		instance_destroy(global.objects_list[0]);
		array_delete(global.objects_list, 0, 1);
	}
}

global.player	= instance_create_layer(768, 750, "Instances", obj_player);