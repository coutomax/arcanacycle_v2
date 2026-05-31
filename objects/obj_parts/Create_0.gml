depth	= 2;

data	=
{
	move	:
	{
		xspd		: irandom_range(-3, 3),
		yspd		: irandom_range(-2, 2),
	},
	flag	:
	{
		is_object	: true
	},
	stats	: {}
};

movement = function ()
{
	data.move.yspd	+= global.gravity;
	
	collisions(self);
	
	x				+= data.move.xspd;
	y				+= data.move.yspd;
}