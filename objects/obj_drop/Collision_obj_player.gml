switch (description)
{
	case "nothing":
	
	break;
	
	case "life":
				
		scr_pop_damage(self, other);
		
		global.life			+= global.heal * global.heal_multiplier;
		
		if (global.life > 100)
		{
			global.life		= 100;
		}
		
		audio_play_sound(snd_life, 0, false, 0.07);
		
		instance_destroy(self);
	break;
}