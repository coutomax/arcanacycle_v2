depth		= 1;

//variáveis editaveis
duration	= 0;
damage		= 7 * global.damage_multiplier;

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