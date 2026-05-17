image_alpha	= 1;
text		= "";
colour		= noone;
yspd		= -2;

function damage_fade ()
{
	y			+= yspd;	
	image_alpha	-= 0.02;
	
	if (image_alpha <= 0)
	{
		instance_destroy(self);
	}
}
