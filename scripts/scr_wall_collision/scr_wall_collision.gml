function scr_wall_collision(inst, obstacle){
	with(inst)
	{
		if (place_meeting(x + xspd, y, obstacle))
		{
			var _x_pixel_check		= sign(xspd);
			
			while (!place_meeting(x + _x_pixel_check, y, obstacle))
			{
				x	+= _x_pixel_check;
			}
			xspd			= 0;
		}
	}
}