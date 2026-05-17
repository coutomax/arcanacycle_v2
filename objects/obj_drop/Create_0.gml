depth		= 1;

xspd		= irandom_range(-2, 2);
yspd		= irandom_range(-2, 2);

default_sprite		= noone;

default_drop		= true; //for um drop sem especificidades, é aqui que ele será gerado.
float				= false; 
should_move			= false; //caso algum drop ande ou se mova pela room.
should_float		= false; //caso o objeto deva flutuar.

is_a_object			= true;
at_surface			= false;

description			= "";

amplitude			= 7;
floating_time		= 0;
min_speed			= 0.1;
float_speed			= 0.05;
friction_			= 0.98;
base_y				= 0;
ground_y			= -999;

function floating_drop ()
{
	if (!at_surface)
	{
		scr_collisions(self);
	}
	else
		if (should_float)
		{
			if (!float)
			{
				if (abs(xspd) < min_speed && abs(yspd) < min_speed)
				{
					xspd	= 0;
					yspd	= 0;
					base_y	= y;
					float	= true;
				}
			}
			else
			{
				floating_time	+= float_speed;
				y = base_y - sin(floating_time) * amplitude;
			}
		}
}
function height_adjustment ()
{
	if (at_surface && should_float)
	{
		if (ground_y == -999)
		{
			ground_y	= y;
		}
		
		if (y >= ground_y - (sprite_height / 2))
		{
			yspd	-= global.gravity;
		}
		else
		{
			yspd	= 0;
		}
	}
}
function movement ()
{
	if (float)
	{
		xspd *= friction_;
		yspd *= friction_;
	}
	
	x		+= round(xspd);
	y		+= round(yspd);
}