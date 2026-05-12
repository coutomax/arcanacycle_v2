/*

						CRIA E INICIA TODAS AS VIARIÁVEIS GLOBAIS

*/

//arrays
global.objects_list		= []; //lista de objetos para serem deletados

//booleanos
global.new_game			= true;
global.paused			= false;
global.in_game			= true;

//numerics
global.gravity			= .25;
global.max_gravity		= 8;
global.max_life			= 100;
global.life				= 100;
global.damage			= 5;
global.attack_interval	= 1;
global.jump_quantity	= 1;

//Contadores para estatísticas do jogador
global.game_over			= 0;
global.kills				= 0;
global.waves_cleared		= 0;
global.life_lost			= 0;
global.life_healed			= 0;
global.damage_caused		= 0;
global.damage_taken			= 0;
global.most_damage_caused	= 0;
global.experience			= 0;
global.level				= 0;

//numerics para inimigos
global.enemies			= 1;
global.max_enemies		= 1;
global.wave				= 1;

global.enemy_attack_interval	= 2;

//multiplicadores do jogador
global.life_multiplier			= 1;
global.damage_multiplier		= 1;

//multiplicadores para inimigos
global.enemy_damage_multiplier	= 1;
global.enemy_life_multiplier	= 1;
global.enemy_speed_multiplier	= 1;
global.enemy_exp_multiplier		= 1;

global.enemy_interval_multiplier	= 2;// 1 ataque a cada 2 segundos