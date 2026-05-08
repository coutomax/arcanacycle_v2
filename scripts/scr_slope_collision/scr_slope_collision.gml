function scr_slope_collision(inst, obstacle)
{	
	with (inst)
	{		
		var _y_pixel_check		= sign(yspd);
		
		if (at_ground && place_meeting(x + xspd, y + abs(xspd) + 1, obstacle) && yspd > 0)
		{
			y	-= abs(yspd) + 1//_y_pixel_check;
		}
		at_ground = true;
		yspd	= 0;
	}
}