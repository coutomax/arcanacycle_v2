function pop_damage(inst, target){
	if (target != noone)
	{
		if (target.data.flag.alive)
		{
			var _popup		= instance_create_layer(target.x, target.y, "Instances", obj_damage);
					
			if (variable_struct_exists(inst.data.stats, "damage"))
			{
				_popup.data.colour	= c_red;
				_popup.data.text	= "-" + string(inst.data.stats.damage);
			}
			else
			{
				_popup.data.colour	= c_green;
				
				if (global.player.data.stats.max_life - global.player.data.stats.life >= (global.heal * global.heal_multiplier))
				{
					_popup.data.text		= "+" + string(global.heal);
				}
				else
				{
					if (global.player.data.stats.max_life == global.player.data.stats.life)
					{
						_popup.data.text		= "FULL";
					}
					else
					{ 
						_popup.data.text		= "+" + string(global.player.data.stats.max_life - global.player.data.stats.life);
					}					
				}
			}
		}
	}
}