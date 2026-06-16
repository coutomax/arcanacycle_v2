event_inherited();

data.move.xspd				= 12;
data.move.yspd				= 12;

data.stats.damage			= 9 * global.damage_multiplier;

data.audio.loop				= false;
data.audio.sound			= snd_fireball;
data.audio.collide_sound	= noone;
data.audio.sound_offset		= -1; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
data.audio.sound_loop		= false;
data.audio.play_once		= true;
data.audio.volume			= 0.015;
data.flag.is_enemy			= true;
