depth		= 1;

data		=
{
	stats	:
	{
		life				: 100,
		max_life			: 100,
		damage				: 8,
	},	
	move	:
	{
		xspd				: 0,
		yspd				: 0,
		walk_speed			: 3,
		jump_spd			: -5.5,
		jump_max			: 1,
		jump_hold_frames	: 15,
		jump_timer			: 0,
		jump_count			: 0,
	},	
	attack	:
	{
		cooldown			: 1,
		attack_cd			: 0
	},
	flag	:
	{
		alive				: true,
		grounded			: true,
		is_object			: false,
		s_press				: false,
	}
};

data.attack.attack_cd		= timer(data.attack.cooldown);

function movement()
{
	image_speed			= 1;
			
	//teclas pressionadas
	var _w_pressed			= keyboard_check( ord("W") );
	var _a_pressed			= keyboard_check( ord("A") );
	var _s_pressed			= keyboard_check_pressed( ord("S") );
	var _d_pressed			= keyboard_check( ord("D") );
						
	var _dir				= (_d_pressed - _a_pressed);				
							
	data.move.xspd					= _dir * data.move.walk_speed;
	
	data.flag.s_press					= _s_pressed;
			
	if (_dir != 0)
	{
		image_xscale		= _dir;
		sprite_index		= spr_walking_player;
	}
	else
	{
		sprite_index		= spr_stopped_player;
	}	
	
	if (_s_pressed && !data.flag.grounded)
	{
		data.flag.grounded = false;
		y	+= data.move.walk_speed;
	}
	
	collisions(self);	
	movement_apply(self);
}
function player_attack () //criar subrotina pra quando houverem cartas que afetam os projéteis
{
	var _mouse_click		= mouse_check_button( mb_left );
	
	if (_mouse_click && data.attack.attack_cd.is_done())
	{
		var _dir			= point_direction(x, y, mouse_x, mouse_y);
		
		var _attack			= instance_create_layer(x, y, "Instances", obj_fireball);
		
		_attack.data.move.xspd		= lengthdir_x(_attack.data.move.xspd, _dir);
		_attack.data.move.yspd		= lengthdir_y(_attack.data.move.yspd, _dir);
		
		_attack.direction = _dir;
		_attack.image_angle = _dir - 220;
	
		data.attack.attack_cd.start();
	}
	data.attack.attack_cd.update();
}
