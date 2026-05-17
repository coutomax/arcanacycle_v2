depth		= 1;

xspd		= irandom_range(-2, 2);
yspd		= irandom_range(-2, 2);

default_sprite		= noone;

default_drop		= true; //for um drop sem especificidades, é aqui que ele será gerado.
float				= false; //caso o objeto deva flutuar.
should_move			= false; //caso algum drop ande ou se mova pela room.

is_a_object			= true;

description			= "";

function movement ()
{
	x		+= round(xspd);
	y		+= round(yspd);
}