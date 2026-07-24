function collisions(inst){
	
	var _x 		= inst.x;
	var _y 		= inst.y;
	var _move	= inst.data.move;
	var _flag	= inst.data.flag;

	var _object_index 	= inst.object_index;		
	var _sprite_width	= inst.sprite_width;
	var _sprite_height	= inst.sprite_height;

	var _sub_pixel			= .5;
	var _next_x				= _x + _move.xspd;
	var _next_y				= _y + _move.yspd;
	var _pixel_check_x		= sign(_move.xspd);
	var _pixel_check_y		= sign(_move.yspd);		
	var _y_check			= _y + _pixel_check_y;
	var _x_check			= _x + _pixel_check_x;
	
	if (_move.xspd == 0 && _move.yspd == 0) return;

	//colisão vertical
	if (_move.yspd != 0)
	{
		//colisão vertical com o chão
		 if (place_meeting(_x, _next_y, obj_wall))
        {
			var _safety_loop = 0;

            while (!place_meeting(_x, _y_check, obj_wall))
            {
                _y			+= _pixel_check_y;
				_y_check	= _y + _pixel_check_y;
				inst.y 		= _y;

				_safety_loop++;
				if (_safety_loop > 32) break;
            }

            _flag.on_ground		= true;
			_flag.at_surface	= false;
            _move.yspd			= 0;
			
			stop_objects(inst);
        }
	}
	
	var _slope_check 	= instance_place(_next_x, _y, obj_wall);
	
	// colisão horizontal		
	if (_slope_check != noone && _move.xspd != 0)
	{
		//checa se é um slope
		if (_slope_check.object_index == obj_slope)
		{
			var _safety_loop = 0;

			while(place_meeting(_next_x, _y, obj_wall))
			{
				_y				-= _sub_pixel;
				inst.y			= _y;

				_safety_loop++;
				if (_safety_loop > 32) break;
			}
		}
		else 
		{			
			var _max_step 	= 8;
			var is_climbing	= false;
			
			for (var i = 0; i < _max_step; i++)
			{
				if (!place_meeting(_next_x, _y - i, obj_wall))
				{
					_y -= i;
					inst.y = _y;

					is_climbing = true;
					break;
				}
			}

			if(!is_climbing)// se não, é uma colisão comum
			{
				var _pixel_check	= _sub_pixel * sign(_move.xspd);
				var _safety_loop	= 0;
				
				while(!place_meeting(_x + _pixel_check, _y, obj_wall))
				{
					_x				+= _pixel_check;
					inst.x			= _x;

					_safety_loop++;
					if (_safety_loop > 32) break;
				}
				_move.xspd		= 0;
			}
		}
	}
			
	//colisão com plataformas
	var _platform			= instance_place(_next_x, _next_y, obj_platform);

	if (_platform != noone)
	{
		if place_meeting(_next_x, _next_y, _platform) && _move.yspd > 0 && bbox_bottom <= _platform.bbox_top + 1 //colide com a parte de cima da _platform e para de cair
		{
			var _safety_loop	= 0;
			while !place_meeting(_x, _y_check, _platform)
			{
				_y			+= _pixel_check_y;
				_y_check	= _y + _pixel_check_y;
				inst.y 		= _y;

				_safety_loop++;
				if (_safety_loop > 32 || _pixel_check_y == 0) break;
			}
			_flag.on_ground		= false;
			_flag.at_surface	= true;
			_move.yspd			= 0;
			
			stop_objects(inst);
		}
	}
			
	//"colisao" com os limites da tela no eixo x
	if (_object_index != obj_player) exit;
	if (_next_x < 0 - _sprite_width / 2 || _next_x > room_width - _sprite_width / 2)
	{
		_move.xspd	= 0;
	}

	//"colisao" com os limites da tela no eixo y
	if (_next_y < 0 - _sprite_height / 2 || _next_y > room_height - _sprite_height / 2)
	{
		_move.yspd	= 0;
	}

	/*
	//colisão com rampas (descendo)
	if (inst.data.move.yspd >= 0 && !place_meeting(inst.x + inst.data.move.xspd, inst.y + 1, obj_wall) 
		&& place_meeting(inst.x + inst.data.move.xspd, inst.y + abs(inst.data.move.xspd) + 1, obj_wall))
	{
		while (place_meeting(inst.x + inst.data.move.xspd, inst.y + _sub_pixel, obj_wall))
		{
			inst.y			+= _sub_pixel;
		}
		inst.data.flag.on_ground		= true;
		inst.data.flag.at_surface	= false;
		inst.data.move.yspd			= 0;
	}
	*/
}

function stop_objects(inst)
{
	var _data 	= inst.data;
	if (variable_struct_exists(_data, "flag"))
	{
		if (_data.flag.is_object)
		{
			_data.move.xspd			= 0;
			_data.flag.at_surface	= true;
		}
	}
}