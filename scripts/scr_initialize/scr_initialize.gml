/*

						CRIA E INICIA TODAS AS VIARIÁVEIS GLOBAIS

*/
global.language  		= 0; // 0 - pt-br, 1 - en
function initialize()
{ 
    randomize();

    //booleanos
    global.new_game			= true;
    global.paused			= false;
    global.started          = false;
    global.roll_cards 		= true;
      
    //numerics
    global.gravity			= .25;
    global.max_gravity		= 8;
    global.rerolls          = 0;
    //global.language  		= 0; // 0 - pt-br, 1 - en
      
    global.max_life			= 100;
    global.life				= 100;
    global.heal				= 25; //transferir para o struct de itens de cura
    global.damage			= 5;
    global.attack_interval	= 1;
    global.jump_quantity	= 1;
    
    //Gerenciador de layers (recebe 1 layer por vez)
    global.last_layer		= noone;
    global.last_action      = noone; // recebe a action do ultimo botão clicado.
    global.active_layer     = undefined;
    
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
    
    //structs, lists or arrays
    global.dialogue_struct	= noone;
    
    global.path_queue 		= ds_priority_create();
    global.card_list  		= ds_list_create();
    global.available_cards 	= ds_list_create();
    
    global.objects_list		= []; //lista de objetos para serem deletados
    global.drawn_cards		= []; //lista de cartas sorteadas
    
    global.bonuses 		= {
    damage: 1 //multiplicador de dano
    }
    
    global.cards        = [
        {card: 0, name: "LIFE", sprite: spr_card_life, description: "MORE LIFE!", maximum: 100}, // definir valor para infinito
    {card: 1, name: "PROJECTILES", sprite: spr_card_projectiles, description: "MORE PROJECTILES", maximum: 4},
    {card: 2, name: "BUBBLE PARTY", sprite: spr_card_bubbles, description: "card_2", maximum: 1},
    {card: 3, name: "DEADLY WRECKAGE", sprite: spr_card_debris, description: "card_3", maximum: 3},
    {card: 4, name: "GUIDED PROJECTILES", sprite: spr_card_auto_aim, description: "card_4", maximum: 1},
    {card: 5, name: "PORTALS", sprite: spr_card_portals, description: "card_5", maximum: 1},
    {card: 6, name: "TEST CARD", sprite: spr_card_portals, description: "card_6", maximum: 1},
    {card: 6, name: "TEST CARD", sprite: spr_card_portals, description: "card_6", maximum: 1},
    {card: 6, name: "TEST CARD", sprite: spr_card_portals, description: "card_6", maximum: 1},
    {card: 6, name: "TEST CARD", sprite: spr_card_portals, description: "card_6", maximum: 1},
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
}

initialize();

function game_reset()
{
	if (global.path_queue != undefined) ds_priority_destroy(global.path_queue);
    if (global.card_list != undefined) ds_list_destroy(global.card_list);
    if (global.available_cards != undefined) ds_list_destroy(global.available_cards);

    if (array_length(global.objects_list) > 0)
    {
        for (var i = 0; i < array_length(global.objects_list); i++)
        {
            if (object_exists(global.objects_list[i]))
            {
                with(global.objects_list[i])
                {
                    instance_destroy(id);
                }
            }
        }
    }

    array_resize(global.objects_list, 0);
    array_resize(global.drawn_cards, 0);

    if (instance_exists(obj_hp_bar))
    {
        obj_hp_bar.sprite_index	    = spr_hp_bar;
        obj_hp_bar.toggle           = true;
    }

	//objects destroyer
	if (object_exists(obj_player))
	{
		instance_destroy(obj_player);
	}
	
	if (object_exists(obj_enemies))
	{
		with(obj_enemies)
		{
			instance_destroy(id);
		}
	}
    
    if (object_exists(obj_parts))
    {
        with(obj_parts)
		{
			instance_destroy(id);
		}
    }

    initialize();
}