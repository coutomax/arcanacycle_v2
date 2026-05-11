switch (event_data[? "message"])
{
	case "hit":
		if (global.life > 0)
		{
			global.life		-= damage;
		}
			
	break;
	
	case "reset":
		if (attack_cooldown.is_done() || !attack_cooldown.active 
			&& global.life > 0 && alive)
		{
			sprite_index	= idle_sprite;
			attack_cooldown.start();
		}
		attack_cooldown.update();
		
	break;
}