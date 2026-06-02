function collisions(inst){
	with (inst)
    {
		var _pixel_check_x		= sign(data.move.xspd);
		var _pixel_check_y		= sign(data.move.yspd);
		var _sub_pixel			= .5;
		
		//colisão vertical com o chão
        if place_meeting(x, y + data.move.yspd, obj_wall)
        {
            while (!place_meeting(x, y + _pixel_check_y, obj_wall))
            {
                y			+= _pixel_check_y;
            }
            data.flag.on_ground		= true;
			data.flag.at_surface	= false;
            data.move.yspd			= 0;
			
			stop_objects(inst);
        }
		
		// colisão horizontal		
		if (place_meeting(x + data.move.xspd, y, obj_wall))
		{
			//checa se é um slope
			if (!place_meeting(x + data.move.xspd, y - abs(data.move.xspd) - 1, obj_wall))
			{
				while(place_meeting(x + data.move.xspd, y, obj_wall))
				{
					y				-= _sub_pixel;
				}
			}
			else // se não, é uma colisão comum
			{
				var _pixel_check	= _sub_pixel * sign(data.move.xspd);
				
				while(!place_meeting(x + _pixel_check, y, obj_wall))
				{
					x			+= _pixel_check;
				}
				data.move.xspd		= 0;
			}
		}
				
		//colisão com plataformas
		var _platform			= instance_place(x + data.move.xspd, y + data.move.yspd, obj_platform);
 
		if (_platform != noone && !object_is_ancestor(object_index, obj_enemies))
		{
			if place_meeting(x, y + data.move.yspd, _platform) && data.move.yspd > 0 && bbox_bottom <= _platform.bbox_top + 1 //colide com a parte de cima da _platform e para de cair
			{
				while !place_meeting(x, y + _pixel_check_y, _platform)
				{
					y			+= _pixel_check_y;
				}
				data.flag.on_ground		= false;
				data.flag.at_surface	= true;
				data.move.yspd			= 0;
				
				stop_objects(inst);
			}
		}
				
		//colisão com rampas (descendo)
		if (data.move.yspd >= 0 && !place_meeting(x + data.move.xspd, y + 1, obj_slope) 
			&& place_meeting(x + data.move.xspd, y + abs(data.move.xspd) + 1, obj_slope))
		{
			while (place_meeting(x + data.move.xspd, y + _sub_pixel, obj_slope))
			{
				y			+= _sub_pixel;
			}
			data.flag.on_ground		= true;
			data.flag.at_surface	= false;
            data.move.yspd			= 0;
		}
    }
}

function stop_objects(inst)
{
	if (variable_struct_exists(inst.data, "flag"))
	{
		if (inst.data.flag.is_object)
		{
			inst.data.move.xspd			= 0;
			inst.data.flag.at_surface	= true;
		}
	}
}