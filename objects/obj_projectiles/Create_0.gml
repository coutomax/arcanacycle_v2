depth	= 1;

data	=
{
	move	:
	{
		xspd			: 0,
		yspd			: 0,
	},
	stats	:
	{
		duration		: 0,
		damage			: 0,
		target			: noone,
	},
	audio	:
	{
		volume			: 0,
		sound_offset	: 0, // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
		loop			: noone,
		sound			: noone,
		collide_sound	: noone,
		sound_loop		: false,		
		play_once		: false,
	},
	flag	:
	{
		is_enemy		: false
	}
};

function movement ()
{	
	x		+= data.move.xspd;
	y		+= data.move.yspd;
}
function play_audio ()
{
	if (data.audio.sound != noone)
	{
		if (data.audio.play_once)
		{
			data.audio.play_once		= !data.audio.play_once;
			audio_play_sound(data.audio.sound, 0, data.audio.sound_loop, data.audio.volume);
		}
	}
}