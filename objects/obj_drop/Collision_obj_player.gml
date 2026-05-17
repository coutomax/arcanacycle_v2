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
		
		instance_destroy(self);
	break;
}