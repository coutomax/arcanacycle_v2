
if (global.started)
{
    global.paused		= !global.paused;
    layer_set_visible("ui_pause_menu", global.paused)
}


