function scr_collisions(inst){
	with (inst)
    {
		yspd					+= global.gravity;
		var _pixel_check_x		= sign(xspd);
		var _pixel_check_y		= sign(yspd);
		var _sub_pixel			= .5;
		
		//colisão vertical com o chão
        if place_meeting(x, y + yspd, obj_wall)
        {
            while (!place_meeting(x, y + _pixel_check_y, obj_wall))
            {
                y			+= _pixel_check_y;
            }
            at_ground		= true;
            yspd			= 0;
			
			stop_objects(inst);
        }
		
		// colisão horizontal		
		if (place_meeting(x + xspd, y, obj_wall))
		{
			//checa se é um slope
			if (!place_meeting(x + xspd, y - abs(xspd) - 1, obj_wall))
			{
				while(place_meeting(x + xspd, y, obj_wall))
				{
					y				-= _sub_pixel;
				}
			}
			else // se não, é uma colisão comum
			{
				var _pixel_check	= _sub_pixel * sign(xspd);
				
				while(!place_meeting(x + _pixel_check, y, obj_wall))
				{
					x		+= _pixel_check;
				}
				xspd	= 0;
			}
		}
				
		//colisão com plataformas
		var _platform			= instance_place(x + xspd, y + yspd, obj_platform);
 
		if (_platform != noone)
		{
			if place_meeting(x, y + yspd, _platform) && yspd > 0 && bbox_bottom <= _platform.bbox_top + 1 //colide com a parte de cima da _platform e para de cair
			{
				while !place_meeting(x, y + _pixel_check_y, _platform)
				{
					y			+= _pixel_check_y;
				}
				at_ground		= true;
				yspd			= 0;
				
				stop_objects(inst);
			}
		}
				
		//colisão com rampas (descendo)
		if (yspd >= 0 && !place_meeting(x + xspd, y + 1, obj_slope) 
			&& place_meeting(x + xspd, y + abs(xspd) + 1, obj_slope))
		{
			while (place_meeting(x + xspd, y + _sub_pixel, obj_slope))
			{
				y		+= _sub_pixel;
			}
			at_ground		= true;
            yspd			= 0;
		}
    }
}

function stop_objects(inst)
{
	if (variable_instance_exists(inst, "is_a_object"))
	{
		if (inst.is_a_object)
		{
			inst.xspd	= 0;
		}
	}
}