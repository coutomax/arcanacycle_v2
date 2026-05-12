if (global.paused)
{
	exit;
}

if (global.life < 0)
{
	global.life					= 0;
	obj_hp_bar.sprite_index		= spr_broken_hp_bar;
	audio_play_sound(snd_breaking_glass, 0, false, 0.07);
}

object_cleaner();