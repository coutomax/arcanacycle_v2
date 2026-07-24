if (ds_exists(global.path_queue, ds_type_priority))
{
	ds_priority_destroy(global.path_queue);
}