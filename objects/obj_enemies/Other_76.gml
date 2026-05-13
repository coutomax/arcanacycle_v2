var _instance_id		= layer_instance_get_instance(event_data[? "element_id"]);

if (_instance_id == id)
{
	switch (event_data[? "message"])
	{
		case "hit":
			if (global.life > 0)
			{
				global.life		-= damage;
				scr_pop_damage(self, obj_player);
				audio_play_sound(snd_damage_taken, 0, false, 0.03);
				attack_cd.update();
			}
			attack_cd.update();
		break;
	
		case "reset":
			sprite_index	= idle_sprite;
		break;
	}
}