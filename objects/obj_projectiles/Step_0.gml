if (global.paused)
{		
	image_speed		= 0;
	exit;
}

image_speed			= 1;

movement();
play_audio();