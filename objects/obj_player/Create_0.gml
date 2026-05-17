depth				= 1;
xspd				= 0;
yspd				= 0;
walk_speed			= 3;
s_press				= false;

at_ground			= true;

alive				= true;

//definições do pulo
jump_spd			= -5.5;
jump_max			= 1;
jump_hold_frames	= 15;
jump_timer			= 0;
jump_count			= 0;

obstacle			= noone;

cooldown			= 1 * global.attack_interval
attack_cd			= scr_timer(cooldown);

function movement()
{
	image_speed			= 1;
			
	//teclas pressionadas
	var _w_pressed			= keyboard_check( ord("W") );
	var _a_pressed			= keyboard_check( ord("A") );
	var _s_pressed			= keyboard_check_pressed( ord("S") );
	var _d_pressed			= keyboard_check( ord("D") );
						
	var _dir				= (_d_pressed - _a_pressed);				
							
	xspd					= _dir * walk_speed;
	
	s_press					= _s_pressed;
			
	if (_dir != 0)
	{
		image_xscale		= _dir;
		sprite_index		= spr_walking_player;
	}
	else
	{
		sprite_index		= spr_stopped_player;
	}	
	
	if (_s_pressed && !at_ground)
	{
		at_ground = false;
		y	  += walk_speed;
	}
	
	scr_collisions(self);	
	movement_apply();
}
function attack () //criar subrotina pra quando houverem cartas que afetam os projéteis
{
	var _mouse_click		= mouse_check_button( mb_left );
	
	if (_mouse_click && attack_cd.is_done())
	{
		var _dir			= point_direction(x, y, mouse_x, mouse_y);
		
		var _attack			= instance_create_layer(x, y, "Instances", obj_fireball);
		
		_attack.xspd		= lengthdir_x(_attack.xspd, _dir);
		_attack.yspd		= lengthdir_y(_attack.yspd, _dir);
		
		_attack.direction = _dir;
		_attack.image_angle = _dir - 220;
	
		attack_cd.start();
	}
	attack_cd.update();
}
function movement_apply ()
{
	x			+= round(xspd);
	y			+= round(yspd);
}