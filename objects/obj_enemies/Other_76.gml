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
			}
		break;

		case "shoot":
			if (global.player.data.stats.life > 0)
			{
				var _attack 	= instance_create_layer(x, y, "Instances", obj_sting);
				var _dir 		= point_direction(_attack.x, _attack.y, global.player.x, global.player.y);

				_attack.data.move.xspd 		= lengthdir_x(_attack.data.move.xspd, _dir);
				_attack.data.move.yspd 		= lengthdir_y(_attack.data.move.yspd, _dir);

				_attack.direction 			= _dir;
				_attack.image_angle 		= _dir - 90;
			}
		break;

		case "reset":
			sprite_index	= data.visual.idle_sprite;
		break;
	}
}