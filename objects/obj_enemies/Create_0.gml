depth		= 2;

data		=
{
	stats	:
	{
		life				: 0,
		damage				: 0		
	},
	move	:
	{
		xspd				: 0,
		yspd				: 0,
		rotate				: 0,
		total_speed			: 0,
		y_direction			: 1
	},
	visual	:
	{
		idle_sprite			: noone,
		attack_sprite		: noone,
		dead_sprite			: noone
	},
	audio	:
	{
		sound_offset		: 0,// -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
		die_sound			: noone,
		loop				: noone,
		sound				: noone,
		sound_data			: false
	},
	attack	:
	{
		target_x			: 0,
		target_y			: 0,
		cooldown			: 0,
		attack_cd			: 0,
		custom_attack_speed	: 0
	},
	flag	:
	{
		alive				: true,
		pursue				: false,
		semi_pursue			: false,
		rotate_after_die	: false,
		is_object			: false
	},
	on_die	:
	{
		experience			: 0,
		drop_on_die			: [],
		create_on_die		: []
	}	
};

toggle_parts	= true;

function chaser ()
{
	if (data.flag.pursue && data.flag.alive)
	{
		data.attack.target_x	= global.player.x;
		data.attack.target_y	= global.player.y;
		
		if (data.flag.alive)
		{
			var _dir			= point_direction(x, y, data.attack.target_x, data.attack.target_y);
			
			mp_potential_step(data.attack.target_x, data.attack.target_y, data.move.total_speed, false);
			
			direction	= _dir;
			
			if (direction > 90 && direction < 270)
			{
				image_xscale	= 1;
			}
			else
			{
				image_xscale	= -1;
			}
		}
	}
}
function enemy_attack ()
{
	if (data.flag.pursue && data.flag.alive)
	{
		if (y < yprevious)
		{
			data.move.y_direction		= -1;
		}  
		else
		{
			data.move.y_direction		= 1;
		}		
		
		var _attacker	= instance_place(x - (15 * image_xscale), y + (20 * data.move.y_direction), obj_player);
		
		if (_attacker != noone)
		{
			if	(data.attack.attack_cd.is_done() || !data.attack.attack_cd.active)
			{
				sprite_index			= data.visual.attack_sprite;
				data.attack.attack_cd.start();
			}
			data.attack.attack_cd.update();			
		}
		else
		{
			sprite_index				= data.visual.idle_sprite;
			data.attack.attack_cd.update();
		}
	}
}
function enemy_die ()
{
	if (data.stats.life <= 0)
	{
		if (audio_is_playing(data.audio.loop))
		{
			audio_stop_sound(data.audio.loop);
		}
		
		if (data.flag.alive)
		{
			array_push(global.objects_list, self);
			if (data.audio.die_sound != noone)
			{
				audio_play_sound(data.audio.die_sound, 0, false, 0.07);
			}
			
			drop_roll(global.drop_table);
		}
		
		data.flag.alive			= false;
		sprite_index		= data.visual.dead_sprite;
		
		if (array_length(data.on_die.create_on_die) > 0 && toggle_parts)
		{
			toggle_parts	= false;
			for (var i = 0; i < array_length(data.on_die.create_on_die); i++)
			{
				var _dead_parts		= instance_create_layer(x, y, "Instances", obj_parts);
					
				_dead_parts.sprite_index		= data.on_die.create_on_die[i];
				
				array_push(global.objects_list, _dead_parts);
			}
		}
		
		if (data.flag.rotate_after_die && image_angle != (data.move.rotate * image_xscale))
		{
			image_angle		-= 5 * image_xscale;
		}
		
		collisions(self);
		movement_apply(self);
	}
}
function enemy_sound ()
{
	if (data.audio.sound != noone && data.flag.alive && !audio_is_playing(data.audio.sound))
	{	
		var _distance	= point_distance(x, y, obj_player.x, obj_player.y);
		
		if ((data.audio.sound_offset > 0 && _distance <= data.audio.sound_offset)
			|| data.audio.sound_offset == -1)
		{
			data.audio.loop = audio_play_sound(data.audio.sound, 0, false, 0.07);
				audio_sound_loop(data.audio.loop, data.audio.sound_data);
		}
	}
}
function drop_roll ()
{
	
}