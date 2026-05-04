xscale			= escalaX * 1.1;
yscale			= escalaY * 0.8;

image_index		= 1;

if (selfText != undefined)
{
	flexpanel_node_style_set_position(selfText, flexpanel_edge.top, 5, flexpanel_unit.point);
}

if (visible)
{
	audio_play_sound(snd_button_click_down, 0, false, 0.05);
}