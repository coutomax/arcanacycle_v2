switch (data.behavior.description)
{
	case "nothing":
	
	break;
	
	case "life":
				
		pop_damage(self, other);
		
		global.player.data.stats.life		+= global.heal * global.heal_multiplier;
		
		if (global.player.data.stats.life	 > 100)
		{
			global.player.data.stats.life	= 100;
		}
		
		audio_play_sound(snd_life, 0, false, 0.07);
		
		instance_destroy(self);
	break;
}