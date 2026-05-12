depth		= 1;

duration	= 0;
damage		= 0;

xspd		= 0;
yspd		= 0;

target		= noone;

custom_speed	= false;

function moviment ()
{
	if (!custom_speed)
	{
		x	+= xspd;
		y	+= yspd;
	}
}