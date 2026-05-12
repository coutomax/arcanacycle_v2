event_inherited();

idle_sprite		= spr_wasp;
attack_sprite	= spr_wasp_attack;
dead_sprite		= spr_dead_wasp;

pursue			= true;

create_on_die	= [obj_antenna, obj_antenna, obj_wing, obj_wing];

rotate			= -90;
damage			= 7 * global.enemy_damage_multiplier

rotate_after_die	= true;