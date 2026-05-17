  function scr_drop_roll(drop_table) // drop_table = drop_table ou global.unic_drop_table
{
	var _total_weigth		= 0;
	var _dropped_item		= noone;
		
	for (var i = 0; i < array_length(drop_table); i++)
	{
		_total_weigth += drop_table[i].weigth;
	}
	
	var _roll				= random(_total_weigth);
		
	//rola os itens
	for(var i = 0; i < array_length(drop_table); i++)
	{
		if (_roll < drop_table[i].weigth)
		{
			if (drop_table[i].item == 0)//sem drop
			{
				break;
			}
			
			if (drop_table[i].item == -1) //caiu um drop unico
			{
				scr_drop_roll(global.unic_drop_table);
			}
			else //drop comum
			{
				if (variable_struct_exists(drop_table[i], "sprite"))
				{
					_dropped_item	= drop_table[i];
				}
				else
				{
					_dropped_item	= drop_table[i].obj;
				}
			}
			break;
		}
		_roll -= drop_table[i].weigth
	}
		
	if (_dropped_item != noone)
	{
		if (variable_struct_exists(_dropped_item, "sprite"))
		{
			var _drop			= instance_create_layer(round(x), round(y), "Instances", obj_dropped_item);
			
			_drop.sprite_index	= _dropped_item.sprite;
			_drop.description	= _dropped_item.description;
		}
		else
		{
			instance_create_layer(x, y, "Instances", _dropped_item);
		}		
	}
}