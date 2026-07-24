depth				= 2;

toggle_parts		= true;
player_distance		= 99999;
melee_distance		= noone;
current_frame		= 0;
obstacle 			= noone; //vai ficar no parent, quando for noone, então o state = chase, senão, state = path_finder
out_of_bounds 	 	= true;
birth 				= get_timer();

path_request_pending	= false;

obstacle_clear_timer	= 0;
obstacle_clear_delay	= 30;

data				=
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
		sound_offset		: 0, // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
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
		custom_attack_speed	: 0,
		radius_detection 	: 0
	},
	flag	:
	{
		alive				: true,
		pursue				: false,
		rotate_after_die	: false,
		at_surface			: false,
		on_ground			: false,
		is_object			: false
	},
	on_die	:
	{
		experience			: 0,
		drop_on_die			: [],
		create_on_die		: []
	}	
};

sm		= new state_machine("Idle");
a       = a_star(global.original_grid, octile);

sm.parent_run 	= function()
{
	image_speed = 1;

    var _x 		= x;
    var _y 		= y;

    if (_y < yprevious) 
	{
		data.move.y_direction 	= -1;
	}
    else 
    {
        data.move.y_direction 	= 1;
    }

	if (!out_of_bounds && ((_x < 0 || _x > room_width) || (_y < 0 || _y > room_height)))
	{
		out_of_bounds = true;
	}
	else
	{
		out_of_bounds = false;
	}

    player_distance = point_distance(_x, _y, obj_player.x, obj_player.y);

    if (player_distance < 64)
    {
        melee_distance 		= instance_place(_x - (5 * image_xscale), _y + (5 * data.move.y_direction), obj_player);
		obstacle 			= noone;
    }
    else
    {
        melee_distance 		= noone;
		obstacle = collision_line(_x, _y, global.player.x, global.player.y, [obj_wall, obj_platform, obj_slope], false, true);
    }

    if (player_distance <= data.attack.radius_detection && instance_exists(global.player)) 
    {
        image_xscale 		= -sign(global.player.x - _x);
    }

    if (melee_distance != noone && data.flag.alive)
    {
        data.move.xspd 		= 0;
        data.move.yspd 		= 0;
    }

    if (data.attack.counter < data.attack.cooldown)
    {
        data.attack.counter++;
    }

   	if (data.audio.sound != noone && data.flag.alive && !audio_is_playing(data.audio.sound))
	{
		data.audio.loop = audio_play_sound(data.audio.sound, 0, false, 0.07);
				audio_sound_loop(data.audio.loop, data.audio.sound_data);
	}

	path_request_pending = obstacle != noone && (data.move.xspd == 0 && data.move.yspd == 0);

    collisions(id);

    x 		+= data.move.xspd;
    y 		+= data.move.yspd;
}

sm.add_state("Idle",
{
	on_enter	: function ()
	{
		sprite_index	= data.visual.idle_sprite;
		data.move.xspd 	= 0;
		data.move.yspd 	= 0;
	}
});

sm.add_state("Path_Finder",
{
	on_enter	: function ()
	{
		sprite_index			= data.visual.idle_sprite;
		path_request_pending 	= true;

		var _priority 	=  player_distance + (birth - get_timer()) * 0.0001;

		ds_list_add(global.path_queue, _priority, id);
	},
	on_step		: function ()
	{
		if (data.stats.life <= 0) exit;
		if (a.path == undefined || ds_list_size(a.path) == 0) exit;

		a.move_instance(data.move.total_speed);

		if (obstacle == noone)
		{
			obstacle_clear_timer++;
		}
		else
		{
			obstacle_clear_timer 	= 0;
		}

		image_xscale 		= -sign(global.player.x - x);
	},
	on_exit		: function ()
	{
		a.clear();
		path_request_pending = false;
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
		if (data.stats.life <= 0) return;

		var _move_speed 	= data.move.total_speed;
		var _sep_radius 	= 96; // Radius within which to apply separation force
		var _sep_speed 		= 0.5; // Strength of separation force

		var _target_x 	= x;
		var _target_y 	= y;

		if (instance_exists(obj_player)) {
			_target_x 	= obj_player.x;
			_target_y 	= obj_player.y;
		}

		var _dir_to_player 	= point_direction(x, y, _target_x, _target_y);
		var _chase_x 		= lengthdir_x(_move_speed, _dir_to_player);
		var _chase_y 		= lengthdir_y(_move_speed, _dir_to_player);

		var _sep_x 		= 0;
		var _sep_y 		= 0;

		var _list 		= ds_list_create();
		var _num 		= collision_circle_list(x, y, _sep_radius, obj_enemies, false, true, _list, false);

		if (_num > 0) {
			for (var i = 0; i < _num; i++) {

				var _other 		= _list[| i];
				var _push_dir 	= point_direction(_other.x, _other.y, x, y);
				var _dist 		= point_distance(x, y, _other.x, _other.y);
				var _weight 	= (_sep_radius - _dist) / _sep_radius;
				
				_sep_x 	+= lengthdir_x(_sep_speed * _weight, _push_dir);
				_sep_y 	+= lengthdir_y(_sep_speed * _weight, _push_dir);
			}
		}
		ds_list_destroy(_list);

		velocity_x = _chase_x + _sep_x;
		velocity_y = _chase_y + _sep_y;

		var _current_speed = point_distance(0, 0, velocity_x, velocity_y);
		if (_current_speed > _move_speed + _sep_speed) {
			var _move_dir 	= point_direction(0, 0, velocity_x, velocity_y);
			velocity_x 		= lengthdir_x(_move_speed, _move_dir);
			velocity_y 		= lengthdir_y(_move_speed, _move_dir);
		}

		data.move.xspd 		= velocity_x;
		data.move.yspd 		= velocity_y;

		if (velocity_x != 0) {
			image_xscale 	= -sign(global.player.x - x); 
		}

	}
});

sm.add_state("Attack",
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

		a.clear();

		if (audio_is_playing(data.audio.loop))
		{
			audio_stop_sound(data.audio.loop);
		}

		array_push(global.objects_list, id);

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
/*

sm.add_transition("Idle", "Path_Finder", function () {
	var _can_act 		= data.flag.alive && global.player.data.stats.life > 0;
	var _in_sight 		= player_distance > data.attack.radius_detection;
	var _pursue 		= data.flag.pursue;
	var _has_obstacle 	= obstacle != noone;

	var _should_pursue 		= _pursue && _can_act && melee_distance == noone;
	var _far_from_player 	= _in_sight && !_pursue;

	return !out_of_bounds && _has_obstacle && (_should_pursue || _far_from_player);
});

sm.add_transition("Chase", "Path_Finder", function () {
	var _can_act 		= data.flag.alive && global.player.data.stats.life > 0;
	var _has_obstacle 	= obstacle != noone;

	return !out_of_bounds && _has_obstacle && _can_act && melee_distance == noone;
});

sm.add_transition("Attack", "Path_Finder", function () {
	var _can_act 		= data.flag.alive && global.player.data.stats.life > 0;
	var _has_obstacle 	= obstacle != noone;

	return !out_of_bounds && _has_obstacle && _can_act && melee_distance == noone;
});

sm.add_transition("Path_Finder", "Idle", function () {
	var _can_idle 		= global.player.data.stats.life <= 0;

	return _can_idle;
});

sm.add_transition("Path_Finder", "Chase", function () {
	var _can_act 		= data.flag.alive && global.player.data.stats.life > 0;
	var _has_obstacle 	= obstacle != noone;
	var _has_path 		= a.path != undefined && ds_list_size(a.path) > 0;
	var _histeresis 	= obstacle_clear_timer >= obstacle_clear_delay;

	return !_has_obstacle && _can_act && melee_distance == noone && _histeresis;
});

sm.add_transition("Path_Finder", "Attack", function () {
	var _alive        	= data.flag.alive;
	var _attack_ready   = data.attack.counter >= data.attack.cooldown;
	var _in_melee_range = melee_distance != noone;
	var _in_sight_range = player_distance <= data.attack.radius_detection;

	var _should_attack_while_pursuing 	= data.flag.pursue && _in_melee_range;
	var _should_attack_by_surprise  	= !data.flag.pursue && _in_sight_range;

	return _alive && _attack_ready && (_should_attack_while_pursuing || _should_attack_by_surprise);
});
*/

sm.add_transition("Chase", "Idle", function () {
	return global.player.data.stats.life <= 0;
});

sm.add_transition("Idle", "Chase", function () {
	var _can_act 	= data.flag.alive && global.player.data.stats.life > 0;
	var _in_sight 	= player_distance > data.attack.radius_detection;
	var _pursue 	= data.flag.pursue;

	var _should_pursue 		= _pursue && _can_act && melee_distance == noone;
	var _far_from_player 	= _in_sight && !_pursue;

	return _should_pursue || _far_from_player;
});

sm.add_transition("Chase", "Attack", function () {
	var _alive        	= data.flag.alive;
	var _attack_ready   = data.attack.counter >= data.attack.cooldown;
	var _in_melee_range = melee_distance != noone;
	var _in_sight_range = player_distance <= data.attack.radius_detection;

	var _should_attack_while_pursuing 	= data.flag.pursue && _in_melee_range;
	var _should_attack_by_surprise  	= !data.flag.pursue && _in_sight_range;

	return _alive && _attack_ready && (_should_attack_while_pursuing || _should_attack_by_surprise);
});

sm.add_transition("Attack", "Chase", function () {
	var _alive        		= data.flag.alive;
	var _far_from_player 	= player_distance > data.attack.radius_detection;
	var _pursue        		= data.flag.pursue;
	var _not_in_melee_range = melee_distance == noone;
	
	var _should_chase 				= _alive && _pursue && _not_in_melee_range;
	var _should_chase_by_distance 	= _far_from_player && !_pursue;

	return _should_chase || _should_chase_by_distance;
});

sm.add_transition("Attack", "Idle", function () {
	return global.player.data.stats.life <= 0;
});

sm.add_transition("Chase", "Die", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Attack", "Die", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Idle", "Die", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Path_Finder", "Die", function () {
	return data.stats.life <= 0;
});