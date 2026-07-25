/*

						CRIA E INICIA TODAS AS VIARIÁVEIS GLOBAIS

*/

randomize();

//arrays
global.objects_list		= []; //lista de objetos para serem deletados

//booleanos
global.new_game			= true;
global.paused			= false;
global.started          = false;

//numerics
global.gravity			= .25;
global.max_gravity		= 8;


global.max_life			= 100;
global.life				= 100;
global.heal				= 25; //transferir para o struct de itens de cura
global.damage			= 5;
global.attack_interval	= 1;
global.jump_quantity	= 1;

//Contadores para estatísticas do jogador
global.player_stats		=
{
	games_played	: 0,
	kills			: 0,
	waves			: 0,
	life_lost		: 0,
	life_healed		: 0,
	damage_caused	: 0,
	damage_taken	: 0,
	experience		: 0,
	level			: 0,
	gold			: 0
};

//numerics para inimigos
global.enemies			= 1;
global.max_enemies		= 1;
global.wave				= 1;

global.enemy_attack_interval	= 2;

//multiplicadores de configuração
global.audio_multiplier			= 1;

//multiplicadores do jogador
global.life_multiplier			= 1;
global.damage_multiplier		= 1;
global.heal_multiplier			= 1;

//multiplicadores para inimigos
global.enemy_damage_multiplier	= 1;
global.enemy_life_multiplier	= 1;
global.enemy_speed_multiplier	= 1;
global.enemy_exp_multiplier		= 1;

global.enemy_interval_multiplier	= 2;// 1 ataque a cada 2 segundos

//structs or lists
global.path_queue 		= ds_priority_create();

global.cards        = [
    //{card: 0, name: "card_0", sprite: spr_card_0, description: "card_0"},
];

//drop table global para drops simples (mesmo comportamento, usam sprites)
global.drop_table	= [
	{item: -1, sprite: noone, weigth: 3, description: "unic_drop"},//drop unico
	{item: 0, sprite: noone, weigth: 85, description: "nothing"},//sem drop
	{item: 1, sprite: spr_health, weigth: 1500, description: "life"}
];

//drop table global para drops com comportamentos únicos (usa objetos próprios)
global.unic_drop_table		= [
	{item: 1, obj: noone, weigth: 100, description: ""},
	{item: 2, obj: noone, weigth: 100, description: ""},
	{item: 3, obj: noone, weigth: 100, description: ""}
];