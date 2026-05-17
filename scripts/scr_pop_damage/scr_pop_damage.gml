function scr_pop_damage(inst, target){
	if (target != noone)
	{
		if (target.alive)
		{
			var _popup		= instance_create_layer(target.x, target.y, "Instances", obj_damage);
					
			if (variable_instance_exists(inst, "damage"))
			{
				_popup.colour	= c_red;
				_popup.text	= "-" + string(inst.damage);
			}
			else
			{
				_popup.colour	= c_green;
				
				if (global.max_life - global.life >= (global.heal * global.heal_multiplier))
				{
					_popup.text		= "+" + string(global.heal);
				}
				else
				{
					_popup.text		= "+" + string(global.max_life - global.life);
				}
			}
			
			//if global.vidaMaxima - global.vida >= global.totalHeal
			//{
			//	dt.texto = "+" + string(global.totalHeal);
			//} 
			//else 
			//{
			//	dt.texto = "+" + string(global.vidaMaxima - global.vida);
			//}
		}
	}
}