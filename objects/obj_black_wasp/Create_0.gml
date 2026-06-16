event_inherited();

data.stats.life					= 45 * global.enemy_life_multiplier;
data.on_die.experience			= 9	 * global.enemy_exp_multiplier;
data.move.total_speed			= 2.2 * global.enemy_speed_multiplier;
data.attack.cooldown			= 60 * global.enemy_attack_interval + irandom_range(-5, 10);
data.attack.radius_detection	= 400;
data.visual.attack_index		= 2;
data.visual.idle_sprite			= spr_black_wasp;
data.visual.attack_sprite		= spr_black_wasp_shoot_attack;
data.visual.dead_sprite			= spr_dead_black_wasp;
data.flag.pursue				= false;
data.on_die.create_on_die		= [spr_black_antenna, spr_black_antenna, spr_wing, spr_wing];
data.move.rotate				= -90;
data.stats.damage				= 11 * global.enemy_damage_multiplier;
data.flag.rotate_after_die		= true;
data.audio.sound				= snd_wasp_buzz;
data.audio.sound_offset			= -1; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
data.audio.sound_loop			= true;
data.audio.die_sound			= snd_wasp_die;

