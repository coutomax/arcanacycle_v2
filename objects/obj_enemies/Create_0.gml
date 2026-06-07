depth			= 2;

toggle_parts	= true;
close_to_player	= noone;

data			=
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
		attack_index 		: 0,
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
		counter				: 0,
		custom_attack_speed	: 0
	},
	flag	:
	{
		alive				: true,
		pursue				: false,
		semi_pursue			: false,
		rotate_after_die	: false,
		at_surface			: false,
		is_object			: false
	},
	on_die	:
	{
		experience			: 0,
		drop_on_die			: [],
		create_on_die		: []
	}	
};

sm 				= new state_machine("Idle");

sm.parent_run 	= function()
{
	image_speed		= 1;

	if (y < yprevious)
	{
		data.move.y_direction		= -1;
	}  
	else
	{
		data.move.y_direction		= 1;
	}

	close_to_player	= instance_place(x - (5 * image_xscale), y + (5 * data.move.y_direction), obj_player);

	if(close_to_player != noone && data.flag.alive)
	{
		data.move.xspd		= 0;
		data.move.yspd		= 0;
	}

	if (data.attack.counter < data.attack.cooldown)
	{
 		data.attack.counter++;
	}

	_enemy_sound();

	collisions(self);

	x 			+= data.move.xspd;
	y 			+= data.move.yspd;
}

sm.add_state("Idle",
{
	on_enter	: function ()
	{
		sprite_index	= data.visual.idle_sprite;
	}
});

sm.add_state("Chase",
{
	on_enter	: function ()
	{
		sprite_index	= data.visual.idle_sprite;
	},
	on_step		: function ()
	{
		if (data.flag.alive && instance_exists(obj_player))
		{
			if (global.player.data.stats.life <= 0)
			{
				return;
			}
			
			var _dx 			 	= global.player.x - x;
			var _dy			 		= global.player.y - y;

			data.attack.target_x	= sign(_dx);
			data.attack.target_y	= sign(_dy);

			if (abs(_dx) > 15 * abs(image_xscale))
			{
				data.move.xspd		= lerp(data.move.xspd, data.attack.target_x * data.move.total_speed, 0.1);
			}

			if (abs(_dy) > 15 * abs(image_yscale))
			{
				data.move.yspd		= lerp(data.move.yspd, data.attack.target_y * data.move.total_speed, 0.1);
			}
			if (data.move.xspd != 0)
			{
				image_xscale	= -sign(data.move.xspd);
			}
		}
	}
});

//melee distance only
sm.add_state("Hit",
{
	on_enter	: function ()
	{
		sprite_index			= data.visual.attack_sprite;
		
		if (data.attack.counter >= data.attack.cooldown)
		{
			image_index			= data.visual.attack_index;
		}
	},
	on_step		: function ()
	{
		if (data.attack.counter >= data.attack.cooldown)
		{
			sprite_index		= data.visual.attack_sprite;
			data.attack.counter	= 0;
		}
	}
});

sm.add_state("Die",
{
	on_enter	: function ()
	{
		data.flag.alive		= false;

		if (audio_is_playing(data.audio.loop))
		{
			audio_stop_sound(data.audio.loop);
		}

		array_push(global.objects_list, self);

		if (data.audio.die_sound != noone)
		{
			audio_play_sound(data.audio.die_sound, 0, false, 0.07);
		}
		
		drop_roll(global.drop_table);

		sprite_index		= data.visual.dead_sprite;
	},
	on_step		: function ()
	{
		data.move.yspd		+= global.gravity;

		if (array_length(data.on_die.create_on_die) > 0 && toggle_parts)
		{
			toggle_parts	= false;

			var _y_offset	= 0;

			if (data.flag.at_surface)
			{
				_y_offset = sprite_height;
			}

			for (var i = 0; i < array_length(data.on_die.create_on_die); i++)
			{
				var _dead_parts				= instance_create_layer(x, y - _y_offset, "Instances", obj_parts);
					
				_dead_parts.sprite_index	= data.on_die.create_on_die[i];
				
				array_push(global.objects_list, _dead_parts);
			}
		}
		
		if (data.flag.rotate_after_die && image_angle != (data.move.rotate * image_xscale))
		{
			image_angle		-= 5 * image_xscale;
		}

		data.move.xspd		= 0;
	}
});

sm.add_transition("Chase", "Idle", function () {
	return global.player.data.stats.life <= 0;
});

sm.add_transition("Idle", "Chase", function () {
	return data.flag.pursue && data.flag.alive && global.player.data.stats.life > 0 && close_to_player == noone;
});

sm.add_transition("Chase", "Hit", function () {
	return data.flag.pursue && data.flag.alive && close_to_player != noone && data.attack.counter >= data.attack.cooldown;
});

sm.add_transition("Hit", "Chase", function () {
	return data.flag.pursue && data.flag.alive && close_to_player == noone;
});

sm.add_transition("Hit", "Idle", function () {
	return global.player.data.stats.life <= 0;
});

sm.add_transition("Chase", "Die", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Hit", "Die", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Idle", "Die", function () {
	return data.stats.life <= 0;
});

_enemy_sound = function ()
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