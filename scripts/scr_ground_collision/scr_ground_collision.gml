function scr_ground_collision(inst, obstacle)
{
	with (inst)
	{
		if (place_meeting(x, y + yspd, obstacle))
		{
			var _pixel_check	= sign(yspd);
			while (!place_meeting(x + xspd, y + _pixel_check, obstacle))
			{
				y			+= _pixel_check;	
			}
			at_ground	= true;
			yspd		= 0;
		}
	}
}