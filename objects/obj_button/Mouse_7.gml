button_reset();

active.on_activate();

if (visible)
{
	audio_play_sound(snd_button_click_up, 0, false, 0.05);
}