depth				= 1;
xspd				= 0;
yspd				= 0;
walk_speed			= 2.5;

at_ground			= false;	

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
	var _s_pressed			= keyboard_check( ord("S") );
	var _d_pressed			= keyboard_check( ord("D") );
						
	var dir					= (_d_pressed - _a_pressed);				
							
	xspd				= dir * walk_speed;
			
	if (dir != 0)
	{
		image_xscale		= dir;
		sprite_index	= spr_walking_player
	}
	else
	{
		sprite_index	= spr_stopped_player;
	}
			
	at_ground			= place_meeting(x, y + 1, obj_wall);
 
	var _h_collision	= move_and_collide(xspd, 0, obj_wall, abs(xspd));
 
	if (at_ground && place_meeting(x, y + abs(xspd) + 1 ,obj_wall) && yspd >= 0)
	{   
	    yspd			+= abs(xspd) + 1;
	}
 
	scr_gravity_fall(self);	
}
function attack ()	//criar subrotina pra quando houverem cartas que afetam os projéteis
{
	var mouse_click		= mouse_check_button( mb_left );
	
	if (mouse_click && attack_cd.is_done())
	{
		var dir			= point_direction(x, y, mouse_x, mouse_y);
		
		var attack		= instance_create_layer(x, y, "Instances", obj_fireball);
		
		attack.xspd		= lengthdir_x(attack.xspd, dir);
		attack.yspd		= lengthdir_y(attack.yspd, dir);
		
		attack.direction = dir;
		attack.image_angle = dir - 220;
	
		attack_cd.start();
	}
	attack_cd.update();
}
