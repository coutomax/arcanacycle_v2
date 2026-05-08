function scr_ground_collision(inst, obstacle)
{
	with (inst)
	{
		if (place_meeting(x, y + yspd, obstacle))
		{
			var _y_pixel_check	= sign(yspd);
						
			while (!place_meeting(x, y + _y_pixel_check, obstacle))
			{
				y			+= _y_pixel_check;
			}
			at_ground		= true;
			yspd			= 0;
		}
	}
}