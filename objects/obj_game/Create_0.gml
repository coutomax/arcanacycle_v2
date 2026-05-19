gpu_set_texfilter(false);

toggle		= true;

function object_cleaner ()
{
	if (array_length(global.objects_list) > 50)
	{
		instance_destroy(global.objects_list[0]);
		array_delete(global.objects_list, 0, 1);
	}
}

global.player	= instance_create_layer(768, 750, "Instances", obj_player);