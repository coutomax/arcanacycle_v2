depth			= 1;

h_input 		= false;
v_input 		= false;
fall_input		= false;
jump_input		= false;
attack_input	= false;
dash_input		= false;

grav 			= global.gravity;

data			=
{
	stats	:
{
		life				: 100,
		max_life			: 100,
		damage				: 8
	},	
	move	:
	{
		xspd				: 0,
		yspd				: 0,
		walk_speed			: 3,
		jump 				: 
		{
			spd				: -6.5,
			jump_max		: 2,
			jump_count 		: 0
		},
		dash 				: 
		{
			enabled			: true,
			active			: false,
			spd				: 8,
			timer_base		: 14,
			dash_counter	: 0,
			dash_timer		: 0,
			cooldown		: 180
		}
	},	
	attack	:
	{
		cooldown			: 1,
		attack_cd			: 0
	},
	flag	:
	{
		alive				: true,
		on_ground			: false,
		at_surface			: false,
		is_object			: false
	}
};

data.move.dash.dash_timer 	= data.move.dash.timer_base;
data.attack.attack_cd		= timer(data.attack.cooldown);

sm 				= new state_machine("Idle");

sm.parent_run 	= function()
{
	image_speed		= 1;

	h_input 		= keyboard_check(ord("D")) - keyboard_check(ord("A"));
	fall_input		= keyboard_check(ord("S"));
	attack_input	= mouse_check_button(mb_left);
	jump_input		= keyboard_check_pressed(vk_space);	
	dash_input		= keyboard_check_pressed(vk_shift);

	if (data.flag.alive && !data.move.dash.active)
	{
		data.move.xspd	= h_input * data.move.walk_speed;

		if (h_input != 0)
		{
			image_xscale	= h_input;
		}
	}

	if (data.move.dash.cooldown < 180)
	{
		data.move.dash.cooldown++;
	}

	data.move.yspd			+= grav;

	collisions(self);
	player_attack();

	data.flag.on_ground		= place_meeting(x, y + 1, [obj_wall, obj_slope]);
	data.flag.at_surface	= place_meeting(x, y + 1, obj_platform);

	x += data.move.xspd;
	y += data.move.yspd;
}

sm.add_state("Idle",
{
	on_enter	: function ()
	{
		sprite_index	= spr_idle_player;
		data.move.xspd	= 0;
	}		
});

sm.add_state("Walk",
{
	on_enter	: function ()
	{
		sprite_index 	= spr_walking_player;
	}
});

sm.add_state("Jump", 
{
	on_enter	: function ()
	{
		if(data.move.jump.jump_count <= 0 || data.flag.on_ground || data.flag.at_surface)
		{
			data.move.jump.jump_count = 2;
		}

		data.move.yspd					= data.move.jump.spd;
		data.move.jump.jump_count--;
	},
	on_step	: function ()
	{
		if (jump_input && data.move.jump.jump_count > 0)
		{
			data.move.yspd				= data.move.jump.spd;
			data.move.jump.jump_count--;
		}
	},
	on_exit	: function ()
	{
		if (data.flag.on_ground || data.flag.at_surface)
		{
			data.move.jump.jump_count = 0;
		}
	}
});

sm.add_state("Fall",
{
	on_enter	: function ()
	{
		if (data.flag.at_surface)
		{
			y += 2;
		}
	}
});

sm.add_state("Dash",
{
	on_enter	: function ()
	{
		grav 					= 0;
		data.move.dash.cooldown = 0;
		data.move.dash.active 	= true;
		data.move.xspd 			= data.move.dash.spd * image_xscale;
		data.move.yspd 			= 0;

		var dash_instance 		= instance_create_layer(x, y, "Instances", obj_dash);

		dash_instance.image_xscale = image_xscale * -1;
	},
	on_step	: function ()
	{
		data.move.dash.dash_timer--;
	},
	on_exit	: function ()
	{
		grav = global.gravity;
		data.move.dash.dash_timer = data.move.dash.timer_base;
		data.move.dash.active = false;
	}
});

sm.add_state("Dead",
{
	on_enter	: function ()
	{
		sprite_index	= spr_dead_player;
		data.flag.alive	= false;
		data.move.xspd	= 0;
	},	
});

sm.add_transition("Idle", "Walk", function () { 
	return h_input != 0; 
});

sm.add_transition("Walk", "Idle", function () { 
	return h_input == 0; 
});

sm.add_transition("Idle", "Jump", function () { 
	return jump_input && (data.flag.on_ground || data.flag.at_surface) && h_input == 0; 
});

sm.add_transition("Walk", "Jump", function () { 
	return jump_input && ((data.flag.on_ground || data.flag.at_surface) || data.move.jump.jump_count > 0) && h_input != 0; 
});

sm.add_transition("Jump", "Idle", function () { 
	return (data.flag.on_ground || data.flag.at_surface) && !jump_input && h_input == 0 && data.move.yspd == 0;
});

sm.add_transition("Jump", "Walk", function () { 
	return (data.flag.on_ground || data.flag.at_surface) && !jump_input && h_input != 0 && data.move.yspd == 0; 
});

sm.add_transition("Idle", "Fall", function () {
	return data.flag.at_surface && fall_input;
});

sm.add_transition("Walk", "Fall", function () {
	return data.flag.at_surface && fall_input;
});

sm.add_transition("Fall", "Idle", function () {
	return (data.flag.on_ground || data.flag.at_surface) && h_input == 0 && data.move.yspd == 0;
});

sm.add_transition("Fall", "Walk", function () {
	return (data.flag.on_ground || data.flag.at_surface) && h_input != 0;
});

sm.add_transition("Idle", "Dead", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Walk", "Dead", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Jump", "Dead", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Fall", "Dead", function () {
	return data.stats.life <= 0;
});

sm.add_transition("Jump", "Dash", function () {
	return dash_input && data.move.dash.enabled && data.move.dash.cooldown >= 180;
});

sm.add_transition("Fall", "Dash", function () {
	return dash_input && data.move.dash.enabled && data.move.dash.cooldown >= 180;
});

sm.add_transition("Dash", "Walk", function () {
	return data.move.dash.dash_timer <= 0 && h_input != 0 && data.move.dash.enabled;
});

sm.add_transition("Dash", "Fall", function () {
	return data.move.dash.dash_timer <= 0 && h_input == 0 && data.move.dash.enabled;	
});

function player_attack () //criar subrotina pra quando houverem cartas que afetam os projéteis
{	
	if (attack_input && data.attack.attack_cd.is_done())
	{
		var _dir				= point_direction(x, y, mouse_x, mouse_y);
		
		var _attack				= instance_create_layer(x, y, "Instances", obj_fireball);
		
		_attack.data.move.xspd	= lengthdir_x(_attack.data.move.xspd, _dir);
		_attack.data.move.yspd	= lengthdir_y(_attack.data.move.yspd, _dir);
		
		_attack.direction 		= _dir;
		_attack.image_angle 	= _dir - 220;
	
		data.attack.attack_cd.start();
	}
	data.attack.attack_cd.update();
}
