depth				= 1;
xspd				= 0;
yspd				= 0;
walk_speed			= 2;

at_ground			= false;	

//definições do pulo
jump_spd			= -5.5;
jump_max			= 1;
jump_hold_frames	= 15;
jump_timer			= 0;
jump_count			= 0;

obstacle			= noone;

function movimento()
{
	image_speed			= 1;
			
	//teclas pressionadas
	var _w_pressed			= keyboard_check( ord("W") );
	var _a_pressed			= keyboard_check( ord("A") );
	var _s_pressed			= keyboard_check( ord("S") );
	var _d_pressed			= keyboard_check( ord("D") );
						
	var dir					= (_d_pressed - _a_pressed);			
				
	//aplica a gravidade no yspd	
	yspd				+= global.gravity;						
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
 
	if (at_ground && place_meeting(x,y + abs(xspd) + 1 ,obj_wall) && yspd >= 0)
	{   
	    yspd			+= abs(xspd) + 1;
	}
 
	var _v_collision = move_and_collide(0, yspd, obj_wall, abs(yspd)+1 , xspd, yspd, xspd, yspd)
	
	if (array_length(_v_collision)  > 0)
	{
	    yspd = 0;
	}		
}