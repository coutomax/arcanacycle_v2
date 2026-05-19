if (global.paused)
{
	exit;
}

if (global.player.data.stats.life < 0)
{
	global.player.data.stats.life			= 0;
	
	if (toggle)
	{
		toggle						= false;
		obj_hp_bar.sprite_index		= spr_broken_hp_bar;
		audio_play_sound(snd_breaking_glass, 0, false, 0.37);
	}
}

object_cleaner();