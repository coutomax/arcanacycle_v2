depth		= 2;

life		= 25 * global.enemy_life_multiplier;
damage		= 15 * global.enemy_damage_multiplier;
experience	= 7	 * global.enemy_exp_multiplier;
target_x	= 0;
target_y	= 0;
y_check		= 1;

xspd		= 0;
yspd		= 0;
total_speed	= 2.2 * global.enemy_speed_multiplier;


attack_cooldown		= scr_timer( 1 * global.enemy_attack_interval );

idle_sprite		= noone;
attack_sprite	= noone;
attack_frame	= 0;

alive		= true;
pursue		= false;

function chaser ()
{
	if (pursue)
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
	if (pursue)
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
			if	(attack_cooldown.is_done() || !attack_cooldown.active)
			{
				sprite_index		= attack_sprite;
			}
			attack_cooldown.update();
		}
		else
		{
			attack_cooldown.update();
			sprite_index		= idle_sprite;
		}
		
	}
}