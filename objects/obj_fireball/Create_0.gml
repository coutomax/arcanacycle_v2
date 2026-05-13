event_inherited();

xspd		= 8;
yspd		= 8;

damage		= 8 * global.damage_multiplier;

previous_xspd	= xspd;
previous_yspd	= yspd;

loop			= false;
sound			= snd_fireball;
sound_offset	= -1; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
sound_loop		= false;
play_once		= true;
volume			= 0.015;
