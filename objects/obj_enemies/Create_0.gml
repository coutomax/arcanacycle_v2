depth		= 2;

life		= 25 * global.enemy_life_multiplier;
damage		= 15 * global.enemy_damage_multiplier;
experience	= 7	 * global.enemy_exp_multiplier;
target_x	= 0;
target_y	= 0;
y_check		= 1;

xspd		= 0;
yspd		= 0;
rotate		= 0;

total_speed	= 2.2 * global.enemy_speed_multiplier;

cooldown		= 1 * global.enemy_attack_interval
attack_cd		= scr_timer(cooldown);

idle_sprite		= noone;
attack_sprite	= noone;
dead_sprite		= noone;

pursue			= false;
toggle_parts	= true;
alive			= true;


rotate_after_die		= false;
custom_attack_speed		= 0;

create_on_die			= [];



function chaser ()
{
	if (pursue && alive)
	{
		target_x	= obj_player.x;
		target_y	= obj_player.y;
		
		if (alive)
		{
			var dir			= point_direction(x, y, target_x, target_y);
			
			mp_potential_step(target_x, target_y, total_speed, false);
			
			direction	= dir;
			
			if (direction > 90 && direction < 270)
			{
				image_xscale	= 1;
			}
			else
			{
				image_xscale	= -1;
			}
		}
	}
}
function enemy_attack ()
{
	if (pursue && alive)
	{
		if (y < yprevious)
		{
			y_check		= -1;
		}
		else
		{
			y_check		= 1;
		}		
		
		if (place_meeting(x - (15 * image_xscale), y + (20 * y_check), obj_player))
		{
			if	(attack_cd.is_done() || !attack_cd.active)
			{
				sprite_index		= attack_sprite;
			}
			attack_cd.update();
		}
		else
		{
			attack_cd.update();
			sprite_index		= idle_sprite;
		}
	}
}
function enemy_die ()
{
	if (life <= 0)
	{
		alive				= false;
		sprite_index		= dead_sprite;
		if (array_length(create_on_die) > 0 && toggle_parts)
		{
			toggle_parts	= false;
			for (var i = 0; i < array_length(create_on_die); i++)
			{
				var dead_parts		= instance_create_layer(x, y, "Instances", create_on_die[i]);
				
			}
		}
		
		if (rotate_after_die && image_angle != (rotate * image_xscale))
		{
			image_angle		-= 5 * image_xscale;
		}
		
		scr_gravity_fall(self);
	}
}
function drop_roll ()
{
	
}