if (global.paused)
{
	image_speed		= 0;
	xspd			= 0;
	yspd			= 0;
	exit;
}

image_speed			= 1;


chaser();
enemy_attack();