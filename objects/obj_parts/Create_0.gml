depth		= 2;

data		=
{
	move	:
	{
		xspd		: irandom_range(-3, 3),
		yspd		: irandom_range(-2, 2),
	},
	flag	:
	{
		is_object	: true,
		at_surface  : false
	},
	stats	: {}
};

movement = function ()
{
	collisions(id);

	if (!data.flag.at_surface)
	{
		data.move.yspd	+= global.gravity;

		x				+= data.move.xspd;
		y				+= data.move.yspd;
	}
}