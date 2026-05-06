function scr_player_movement()
{
	var p			= 
	{
		xspd				: 2,
		yspd				: 0,
		x_collision			: 0,
		
		on_step				: function (object)
		{
			if (global.paused)
			{
				object.image_speed		= 0;
				object.xspd				= 0;
				object.yspd				= 0;
				exit;
			}

			object.image_speed			= 1;
			
			//teclas pressionadas
			var _w_pressed			= keyboard_check( ord("W") );
			var _a_pressed			= keyboard_check( ord("A") );
			var _s_pressed			= keyboard_check( ord("S") );
			var _d_pressed			= keyboard_check( ord("D") );
			
			//teclas soltas
			var _a_released			= keyboard_check_released( ord("A") );
			var _d_released			= keyboard_check_released( ord("D") );
						
			//aplica a gravidade no yspd	
			object.yspd				+= global.gravity;
			
			if (_a_released || _d_released)
			{	
				object.xspd			= 0;
				object.sprite_index	= spr_stopped_player;
			}
			
			if (_a_pressed || _d_pressed)
			{
				object.sprite_index	= spr_walking_player;
			}
			
			if (_a_pressed)
			{
				object.xspd			= -abs(xspd);
				object.image_xscale	= -1;
			}
			
			if (_d_pressed)
			{
				object.xspd			= abs(xspd);
				object.image_xscale	= 1;
			}	
			
			/*
			*
			*								Configuração das colisões
			*
			*/
			
			//colisão em y
			scr_ground_collision(object, obj_ground);
			
			object.x			+= object.xspd;
			object.y			+= object.yspd;			
			
		}// fim on_step();
	}
	
	return p;
}