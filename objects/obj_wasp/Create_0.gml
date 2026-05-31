event_inherited();

data.stats.life				= 25 * global.enemy_life_multiplier;
data.on_die.experience		= 7	 * global.enemy_exp_multiplier;
data.move.total_speed		= 2.2 * global.enemy_speed_multiplier;
data.attack.cooldown		= 60 * global.enemy_attack_interval;
data.visual.attack_index	= 2;
data.visual.idle_sprite		= spr_wasp;
data.visual.attack_sprite	= spr_wasp_attack;
data.visual.dead_sprite		= spr_dead_wasp;
data.flag.pursue			= true;
data.flag.semi_pursue		= false; //vai perseguir até uma certa distância (para inimigos que atiram)
data.on_die.create_on_die	= [spr_left_antenna, spr_right_antenna, spr_wing, spr_wing];
data.move.rotate			= -90;
data.stats.damage			= 7 * global.enemy_damage_multiplier;
data.flag.rotate_after_die	= true;
data.audio.sound			= snd_wasp_buzz;
data.audio.sound_offset		= -1; // -1 para sons universais, 0 para nenhum e > 0 para sons com distanciamento
data.audio.sound_loop		= true;
data.audio.die_sound		= snd_wasp_die;