if (active_layer != global.active_layer)
{
    active_layer = global.active_layer;
    title        = get_tittle_id(global.active_layer);
    set_title_translation();
}