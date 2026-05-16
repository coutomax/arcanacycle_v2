depth		= 2;

xspd		= irandom_range(-3, 3);
yspd		= irandom_range(-2, 2);

is_a_object	= true;

function movement ()
{
	x		+= xspd;
	y		+= yspd;
}