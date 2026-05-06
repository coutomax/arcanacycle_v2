if (global.in_game)
{
	global.paused		= !global.paused;
	layer_set_visible("ui_pause_menu", global.paused); //criar menu para a pausa
}

