depth		= 1;

duration	= 0;
damage		= 0;

xspd		= 0;
yspd		= 0;

target		= noone;

custom_speed	= false;

loop			= noone;
sound			= noone;
sound_offset	= 0; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
sound_loop		= false;
play_once		= false;
volume			= 0;

function movement ()
{
	if (!custom_speed)
	{
		x	+= xspd;
		y	+= yspd;
	}
}
function play_audio ()
{
	if (sound != noone)
	{
		if (play_once)
		{
			play_once		= !play_once;
			audio_play_sound(sound, 0, sound_loop, volume);
		}
	}
}