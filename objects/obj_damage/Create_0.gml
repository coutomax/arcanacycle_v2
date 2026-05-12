text		= "";
colour		= noone;
yspd		= -2;
image_alpha	= 1;

function damage_fade ()
{
	y			+= yspd;	
	image_alpha	-= 0.02;
	
	if (image_alpha <= 0)
	{
		instance_destroy(self);
	}
}
