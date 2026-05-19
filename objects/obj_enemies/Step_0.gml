if (global.paused)
{
	image_speed		= 0;
	exit;
}

image_speed			= 1;

chaser();
enemy_attack();
enemy_sound();
enemy_die();
