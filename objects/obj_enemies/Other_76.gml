var _instance_id		= layer_instance_get_instance(event_data[? "element_id"]);

if (_instance_id == id)
{
	switch (event_data[? "message"])
	{
		case "hit":
			if (global.player.data.stats.life > 0)
			{
				global.player.data.stats.life		-= data.stats.damage;
				pop_damage(self, global.player);
				audio_play_sound(snd_damage_taken, 0, false, 0.03);
				data.attack.attack_cd.update();
			}
			data.attack.attack_cd.update();
		break;
	
		case "reset":
			sprite_index	= data.visual.idle_sprite;
		break;
	}
}