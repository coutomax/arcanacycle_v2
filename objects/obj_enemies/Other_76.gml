switch (event_data[? "message"])
{
	case "hit":
		if (global.life > 0 && attack_cd.is_done())
		{
			global.life		-= damage;
		}
	break;
	
	case "reset":
		if (attack_cd.is_done() || !attack_cd.active 
			&& global.life > 0 && alive)
		{
			sprite_index	= idle_sprite;
			attack_cd.start();
		}
		attack_cd.update();
	break;
}