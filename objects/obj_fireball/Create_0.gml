event_inherited();

data.move.xspd				= 8;
data.move.yspd				= 8;

data.stats.damage			= 8 * global.damage_multiplier;

data.audio.loop				= false;
data.audio.sound			= snd_fireball;
data.audio.sound_offset		= -1; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
data.audio.collide_sound	= snd_enemy_damage_taken;
data.audio.sound_loop		= false;
data.audio.play_once		= true;
data.audio.volume			= 0.015;
data.flag.is_enemy			= false;